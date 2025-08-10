#!/bin/bash

# NMOX Server Development Setup Script
# This script sets up the development environment for NMOX Server

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Header
echo "======================================"
echo "   NMOX Server Development Setup"
echo "======================================"
echo ""

# Check operating system
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    OS="windows"
fi

print_info "Detected OS: $OS"

# Check for required tools
print_info "Checking required tools..."

# Check Git
if command -v git &> /dev/null; then
    print_success "Git is installed ($(git --version))"
else
    print_error "Git is not installed. Please install Git first."
    exit 1
fi

# Check Docker
if command -v docker &> /dev/null; then
    print_success "Docker is installed ($(docker --version))"
else
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check Docker Compose
if command -v docker compose &> /dev/null; then
    print_success "Docker Compose is installed"
elif command -v docker-compose &> /dev/null; then
    print_success "Docker Compose is installed (legacy)"
else
    print_error "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    print_success "Node.js is installed ($NODE_VERSION)"
    
    # Check Node version
    REQUIRED_NODE_VERSION="20"
    CURRENT_NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$CURRENT_NODE_VERSION" -lt "$REQUIRED_NODE_VERSION" ]; then
        print_error "Node.js version $REQUIRED_NODE_VERSION or higher is required. Current: $NODE_VERSION"
        exit 1
    fi
else
    print_error "Node.js is not installed. Please install Node.js v20 or higher."
    exit 1
fi

# Check npm
if command -v npm &> /dev/null; then
    print_success "npm is installed ($(npm -v))"
else
    print_error "npm is not installed."
    exit 1
fi

# Check Rust (optional but recommended)
if command -v cargo &> /dev/null; then
    print_success "Rust is installed ($(cargo --version))"
    
    # Check for wasm-pack
    if command -v wasm-pack &> /dev/null; then
        print_success "wasm-pack is installed"
    else
        print_info "wasm-pack not found. Installing..."
        curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
    fi
else
    print_info "Rust is not installed. It's recommended for WASM development."
    read -p "Would you like to install Rust? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
        rustup target add wasm32-unknown-unknown
    fi
fi

# Setup Git LFS
print_info "Setting up Git LFS..."
if command -v git-lfs &> /dev/null; then
    git lfs install
    git lfs pull
    print_success "Git LFS configured"
else
    print_error "Git LFS is not installed. Installing..."
    if [[ "$OS" == "macos" ]]; then
        if command -v brew &> /dev/null; then
            brew install git-lfs
        else
            print_error "Please install Git LFS manually: https://git-lfs.github.com"
        fi
    elif [[ "$OS" == "linux" ]]; then
        curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
        sudo apt-get install git-lfs
    fi
    git lfs install
    git lfs pull
fi

# Create necessary directories
print_info "Creating directory structure..."
mkdir -p x/var/{log,www,db}
mkdir -p x/tmp
mkdir -p x/srv
mkdir -p x/lib/wasm/src
mkdir -p x/lib/rust/src
print_success "Directory structure created"

# Setup environment file
if [ ! -f .env ]; then
    print_info "Creating .env file from template..."
    cp .env.example .env
    print_success ".env file created (please update with your values)"
else
    print_success ".env file already exists"
fi

# Install Node dependencies
print_info "Installing Node.js dependencies..."
npm install
print_success "Node.js dependencies installed"

# Initialize Rust workspace (if Rust is installed)
if command -v cargo &> /dev/null; then
    print_info "Initializing Rust workspace..."
    
    # Create basic Rust source files if they don't exist
    if [ ! -f x/lib/rust/src/lib.rs ]; then
        echo "// NMOX Core Library" > x/lib/rust/src/lib.rs
        echo "pub mod x;" >> x/lib/rust/src/lib.rs
    fi
    
    if [ ! -f x/lib/rust/src/main.rs ]; then
        cat > x/lib/rust/src/main.rs << 'EOF'
use axum::{Router, routing::get};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/health", get(|| async { "OK" }));
    
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8080")
        .await
        .unwrap();
    
    println!("NMOX Server running on http://0.0.0.0:8080");
    axum::serve(listener, app).await.unwrap();
}
EOF
    fi
    
    if [ ! -f x/lib/wasm/src/lib.rs ]; then
        cat > x/lib/wasm/src/lib.rs << 'EOF'
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hello, {}! Welcome to NMOX.", name)
}
EOF
    fi
    
    # Build Rust projects
    cargo build
    print_success "Rust workspace initialized"
fi

# Setup Git hooks
print_info "Setting up Git hooks..."
if [ -f package.json ]; then
    npx husky install
    print_success "Git hooks configured"
fi

# Build Docker images
print_info "Building Docker images..."
docker compose build
print_success "Docker images built"

# Create test Squeak image script
if [ ! -f bin/test-image.sh ]; then
    print_info "Creating test-image.sh script..."
    cat > bin/test-image.sh << 'EOF'
#!/bin/bash
# Test Squeak image
echo "Testing Squeak image..."

if [ -f x/lib/NMOXSqueak6.0-22148-64bit.image ]; then
    echo "✓ Squeak image found"
    # Add actual Squeak tests here
    exit 0
else
    echo "✗ Squeak image not found"
    exit 1
fi
EOF
    chmod +x bin/test-image.sh
    print_success "test-image.sh created"
fi

# Final checks
echo ""
echo "======================================"
echo "        Setup Complete!"
echo "======================================"
echo ""
print_success "NMOX Server development environment is ready!"
echo ""
echo "Next steps:"
echo "  1. Update .env file with your configuration"
echo "  2. Start the development server:"
echo "     • Docker:     docker compose up -d"
echo "     • Node.js:    npm run dev"
echo "     • Rust:       cargo run"
echo "  3. Access the application:"
echo "     • HTTP:       http://localhost:8080"
echo "     • Studio:     http://localhost:8080/studio"
echo "     • Squeak VNC: http://localhost:8081 (if using development profile)"
echo ""
echo "Useful commands:"
echo "  • npm test          - Run tests"
echo "  • npm run lint      - Run linters"
echo "  • make help         - Show all make targets"
echo "  • docker compose logs -f  - View logs"
echo ""
print_info "For more information, see README.md"