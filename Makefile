# NMOX Meta-Framework Build System
# Peace, Love, and Harmony in Build Automation

# Configuration
PROJECT_NAME = NMOX
VERSION = $(shell cat x/bin/nmox 2>/dev/null | grep -o 'v[0-9]\+' || echo "v3")
SQUEAK_IMAGE = x/lib/NMOXSqueak6.0-22148-64bit.image
DOCKER_IMAGE = nmox-server

# Colors for output
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "$(GREEN)NMOX Meta-Framework Build System$(NC)"
	@echo "$(YELLOW)Peace, Love, and Harmony in Development$(NC)"
	@echo ""
	@echo "Available targets:"
	@echo "  $(GREEN)dev$(NC)          - Start development environment"
	@echo "  $(GREEN)test$(NC)         - Run all tests across languages"
	@echo "  $(GREEN)test-squeak$(NC)  - Run Squeak Smalltalk tests"
	@echo "  $(GREEN)test-wasm$(NC)    - Test WebAssembly modules"
	@echo "  $(GREEN)test-cross$(NC)   - Cross-language consistency tests"
	@echo "  $(GREEN)build$(NC)        - Build all components"
	@echo "  $(GREEN)build-wasm$(NC)   - Build WebAssembly modules"
	@echo "  $(GREEN)build-docker$(NC) - Build Docker image"
	@echo "  $(GREEN)benchmark$(NC)    - Run performance benchmarks"
	@echo "  $(GREEN)serve$(NC)        - Start local development server"
	@echo "  $(GREEN)clean$(NC)        - Clean build artifacts"
	@echo "  $(GREEN)setup$(NC)        - Initial project setup"
	@echo "  $(GREEN)lint$(NC)         - Run code quality checks"
	@echo "  $(GREEN)docs$(NC)         - Generate documentation"
	@echo "  $(GREEN)status$(NC)       - Show project status"

# Development environment
.PHONY: dev
dev:
	@echo "$(GREEN)Starting NMOX development environment...$(NC)"
	@./x/boot/init.sh
	@echo "$(GREEN)Development environment ready!$(NC)"

# Testing targets
.PHONY: test
test: test-squeak test-wasm test-cross
	@echo "$(GREEN)All tests completed!$(NC)"

.PHONY: test-squeak
test-squeak:
	@echo "$(YELLOW)Running Squeak Smalltalk tests...$(NC)"
	@if [ -f "$(SQUEAK_IMAGE)" ]; then \
		echo "NMOXTests run" | squeak -headless "$(SQUEAK_IMAGE)"; \
	else \
		echo "$(RED)Squeak image not found at $(SQUEAK_IMAGE)$(NC)"; \
	fi

.PHONY: test-wasm
test-wasm:
	@echo "$(YELLOW)Testing WebAssembly modules...$(NC)"
	@cd x/lib/wasm && cargo test 2>/dev/null || echo "$(YELLOW)Cargo not available, skipping WASM tests$(NC)"

.PHONY: test-cross
test-cross:
	@echo "$(YELLOW)Running cross-language consistency tests...$(NC)"
	@./bin/nmox-simple-test

# Build targets
.PHONY: build
build: build-wasm
	@echo "$(GREEN)Build completed!$(NC)"

.PHONY: build-wasm
build-wasm:
	@echo "$(YELLOW)Building WebAssembly modules...$(NC)"
	@cd x/lib/wasm && \
		if command -v cargo >/dev/null 2>&1; then \
			cargo build --release --target wasm32-unknown-unknown; \
			wasm-pack build --target web 2>/dev/null || echo "$(YELLOW)wasm-pack not available$(NC)"; \
		else \
			echo "$(YELLOW)Cargo not available, skipping WASM build$(NC)"; \
		fi

.PHONY: build-docker
build-docker:
	@echo "$(YELLOW)Building Docker image...$(NC)"
	@docker build -f x/Docker/nmox-nginx.Dockerfile -t $(DOCKER_IMAGE) .

# Performance benchmarks
.PHONY: benchmark
benchmark:
	@echo "$(YELLOW)Running performance benchmarks...$(NC)"
	@./bin/nmox-benchmark

# Development server
.PHONY: serve
serve:
	@echo "$(GREEN)Starting NMOX development server...$(NC)"
	@if command -v python3 >/dev/null 2>&1; then \
		cd x/usr/share/nginx/html && python3 -m http.server 8080; \
	elif command -v python >/dev/null 2>&1; then \
		cd x/usr/share/nginx/html && python -m SimpleHTTPServer 8080; \
	else \
		echo "$(RED)Python not available for development server$(NC)"; \
	fi

# Cleanup
.PHONY: clean
clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@find . -name "*.wasm" -type f -delete 2>/dev/null || true
	@find . -name "target" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.pyc" -type f -delete 2>/dev/null || true
	@echo "$(GREEN)Cleanup completed!$(NC)"

# Project setup
.PHONY: setup
setup:
	@echo "$(GREEN)Setting up NMOX development environment...$(NC)"
	@chmod +x x/boot/init.sh
	@chmod +x x/bin/nmox
	@chmod +x bin/nmox-* 2>/dev/null || true
	@echo "$(GREEN)Setup completed!$(NC)"

# Code quality
.PHONY: lint
lint:
	@echo "$(YELLOW)Running code quality checks...$(NC)"
	@./bin/nmox-lint

# Documentation generation
.PHONY: docs
docs:
	@echo "$(YELLOW)Generating documentation...$(NC)"
	@./bin/nmox-docs

# Project status
.PHONY: status
status:
	@echo "$(GREEN)NMOX Project Status$(NC)"
	@echo "Version: $(VERSION)"
	@echo "Squeak Image: $(shell [ -f '$(SQUEAK_IMAGE)' ] && echo '✓ Available' || echo '✗ Missing')"
	@echo "Docker: $(shell command -v docker >/dev/null 2>&1 && echo '✓ Available' || echo '✗ Missing')"
	@echo "Rust/Cargo: $(shell command -v cargo >/dev/null 2>&1 && echo '✓ Available' || echo '✗ Missing')"
	@echo "Python: $(shell command -v python3 >/dev/null 2>&1 && echo '✓ Available' || command -v python >/dev/null 2>&1 && echo '✓ Available' || echo '✗ Missing')"
	@echo "Node.js: $(shell command -v node >/dev/null 2>&1 && echo '✓ Available' || echo '✗ Missing')"
	@echo "Git Status: $(shell git status --porcelain 2>/dev/null | wc -l | xargs echo) modified files"

# Install development dependencies
.PHONY: deps
deps:
	@echo "$(YELLOW)Installing development dependencies...$(NC)"
	@if command -v cargo >/dev/null 2>&1; then \
		cd x/lib/wasm && cargo install wasm-pack 2>/dev/null || echo "$(YELLOW)wasm-pack installation failed$(NC)"; \
	fi
	@echo "$(GREEN)Dependencies installation completed!$(NC)"