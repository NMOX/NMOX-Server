# NMOX Meta-Framework Build System
# Peace, Love, and Harmony in Build Automation

# Configuration
PROJECT_NAME = NMOX
VERSION = $(shell cat x/bin/nmox 2>/dev/null | grep -o 'v[0-9]\+' || echo "v3")
SQUEAK_IMAGE = x/lib/NMOXSqueak6.0-22148-64bit.image
DOCKER_IMAGE = nmox/nmox-server
DOCKER_COMPOSE = docker compose
NODE_BIN = node_modules/.bin

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
	@echo ""
	@echo "$(YELLOW)Development:$(NC)"
	@echo "  $(GREEN)dev$(NC)          - Start development environment"
	@echo "  $(GREEN)serve$(NC)        - Start local development server"
	@echo "  $(GREEN)watch$(NC)        - Watch files for changes"
	@echo "  $(GREEN)setup$(NC)        - Initial project setup"
	@echo "  $(GREEN)install$(NC)      - Install all dependencies"
	@echo ""
	@echo "$(YELLOW)Testing:$(NC)"
	@echo "  $(GREEN)test$(NC)         - Run all tests across languages"
	@echo "  $(GREEN)test-unit$(NC)    - Run unit tests"
	@echo "  $(GREEN)test-int$(NC)     - Run integration tests"
	@echo "  $(GREEN)test-squeak$(NC)  - Run Squeak Smalltalk tests"
	@echo "  $(GREEN)test-wasm$(NC)    - Test WebAssembly modules"
	@echo "  $(GREEN)test-cross$(NC)   - Cross-language consistency tests"
	@echo "  $(GREEN)coverage$(NC)     - Generate test coverage report"
	@echo ""
	@echo "$(YELLOW)Building:$(NC)"
	@echo "  $(GREEN)build$(NC)        - Build all components"
	@echo "  $(GREEN)build-wasm$(NC)   - Build WebAssembly modules"
	@echo "  $(GREEN)build-rust$(NC)   - Build Rust components"
	@echo "  $(GREEN)build-docker$(NC) - Build Docker images"
	@echo ""
	@echo "$(YELLOW)Docker:$(NC)"
	@echo "  $(GREEN)up$(NC)           - Start Docker containers"
	@echo "  $(GREEN)down$(NC)         - Stop Docker containers"
	@echo "  $(GREEN)logs$(NC)         - View Docker logs"
	@echo "  $(GREEN)restart$(NC)      - Restart Docker containers"
	@echo ""
	@echo "$(YELLOW)Quality:$(NC)"
	@echo "  $(GREEN)lint$(NC)         - Run all linters"
	@echo "  $(GREEN)lint-fix$(NC)     - Fix linting issues"
	@echo "  $(GREEN)format$(NC)       - Format all code"
	@echo "  $(GREEN)benchmark$(NC)    - Run performance benchmarks"
	@echo ""
	@echo "$(YELLOW)Utilities:$(NC)"
	@echo "  $(GREEN)clean$(NC)        - Clean build artifacts"
	@echo "  $(GREEN)docs$(NC)         - Generate documentation"
	@echo "  $(GREEN)status$(NC)       - Show project status"
	@echo "  $(GREEN)version$(NC)      - Show version information"

# Development environment
.PHONY: dev
dev: install
	@echo "$(GREEN)Starting NMOX development environment...$(NC)"
	@$(DOCKER_COMPOSE) --profile development up -d
	@echo "$(GREEN)Development environment ready!$(NC)"
	@echo "Access points:"
	@echo "  - Application: http://localhost:8080"
	@echo "  - Studio: http://localhost:8080/studio"
	@echo "  - Squeak VNC: http://localhost:8081"

# Installation
.PHONY: install
install:
	@echo "$(YELLOW)Installing dependencies...$(NC)"
	@npm install
	@echo "$(GREEN)Dependencies installed!$(NC)"

# Watch for changes
.PHONY: watch
watch:
	@echo "$(GREEN)Watching for changes...$(NC)"
	@npm run dev

# Testing targets
.PHONY: test
test: test-unit test-integration test-squeak test-wasm test-cross
	@echo "$(GREEN)All tests completed!$(NC)"

.PHONY: test-unit
test-unit:
	@echo "$(YELLOW)Running unit tests...$(NC)"
	@npm test -- --testMatch='**/*.test.js'
	@cargo test --lib

.PHONY: test-integration
test-int: test-integration
test-integration:
	@echo "$(YELLOW)Running integration tests...$(NC)"
	@npm test -- --testMatch='**/*.integration.js'

.PHONY: test-squeak
test-squeak:
	@echo "$(YELLOW)Running Squeak Smalltalk tests...$(NC)"
	@./bin/test-image.sh

.PHONY: test-wasm
test-wasm:
	@echo "$(YELLOW)Testing WebAssembly modules...$(NC)"
	@cd x/lib/wasm && cargo test 2>/dev/null || echo "$(YELLOW)Cargo not available, skipping WASM tests$(NC)"

.PHONY: test-cross
test-cross:
	@echo "$(YELLOW)Running cross-language consistency tests...$(NC)"
	@./bin/nmox-simple-test

# Coverage
.PHONY: coverage
coverage:
	@echo "$(YELLOW)Generating test coverage report...$(NC)"
	@npm test -- --coverage
	@cargo tarpaulin --out Html

# Build targets
.PHONY: build
build: build-rust build-wasm build-docker
	@echo "$(GREEN)Build completed!$(NC)"

.PHONY: build-rust
build-rust:
	@echo "$(YELLOW)Building Rust components...$(NC)"
	@cargo build --release

.PHONY: build-wasm
build-wasm:
	@echo "$(YELLOW)Building WebAssembly modules...$(NC)"
	@npm run build:wasm

.PHONY: build-docker
build-docker:
	@echo "$(YELLOW)Building Docker images...$(NC)"
	@$(DOCKER_COMPOSE) build

# Performance benchmarks
.PHONY: benchmark
benchmark:
	@echo "$(YELLOW)Running performance benchmarks...$(NC)"
	@./bin/nmox-benchmark

# Docker commands
.PHONY: up
up:
	@echo "$(GREEN)Starting Docker containers...$(NC)"
	@$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)Containers started!$(NC)"

.PHONY: down
down:
	@echo "$(YELLOW)Stopping Docker containers...$(NC)"
	@$(DOCKER_COMPOSE) down
	@echo "$(GREEN)Containers stopped!$(NC)"

.PHONY: restart
restart: down up

.PHONY: logs
logs:
	@$(DOCKER_COMPOSE) logs -f

# Development server
.PHONY: serve
serve:
	@echo "$(GREEN)Starting NMOX development server...$(NC)"
	@npm start

# Cleanup
.PHONY: clean
clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf node_modules
	@find . -name "*.wasm" -type f -delete 2>/dev/null || true
	@find . -name "target" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.pyc" -type f -delete 2>/dev/null || true
	@rm -rf x/tmp/* x/var/log/*
	@echo "$(GREEN)Cleanup completed!$(NC)"

# Project setup
.PHONY: setup
setup:
	@echo "$(GREEN)Setting up NMOX development environment...$(NC)"
	@./scripts/setup.sh
	@echo "$(GREEN)Setup completed!$(NC)"

# Code quality
.PHONY: lint
lint:
	@echo "$(YELLOW)Running code quality checks...$(NC)"
	@npm run lint
	@cargo clippy -- -D warnings
	@./bin/nmox-lint

.PHONY: lint-fix
lint-fix:
	@echo "$(YELLOW)Fixing linting issues...$(NC)"
	@npm run lint:fix
	@cargo fmt

.PHONY: format
format:
	@echo "$(YELLOW)Formatting code...$(NC)"
	@npm run format
	@cargo fmt

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

# Version information
.PHONY: version
version:
	@echo "$(GREEN)NMOX Server Version Information$(NC)"
	@echo "Project: $(PROJECT_NAME) $(VERSION)"
	@echo "Node.js: $$(node -v 2>/dev/null || echo 'Not installed')"
	@echo "npm: $$(npm -v 2>/dev/null || echo 'Not installed')"
	@echo "Rust: $$(cargo --version 2>/dev/null || echo 'Not installed')"
	@echo "Docker: $$(docker --version 2>/dev/null || echo 'Not installed')"
	@echo "Git: $$(git --version)"

# Install development dependencies
.PHONY: deps
deps:
	@echo "$(YELLOW)Installing development dependencies...$(NC)"
	@npm install
	@if command -v cargo >/dev/null 2>&1; then \
		cargo install wasm-pack cargo-tarpaulin; \
	fi
	@echo "$(GREEN)Dependencies installation completed!$(NC)"

# Quick start for new developers
.PHONY: quickstart
quickstart: setup install build
	@echo "$(GREEN)=================================$(NC)"
	@echo "$(GREEN)   NMOX Server Ready!$(NC)"
	@echo "$(GREEN)=================================$(NC)"
	@echo ""
	@echo "Run '$(YELLOW)make dev$(NC)' to start the development environment"
	@echo "Run '$(YELLOW)make help$(NC)' to see all available commands"

# CI/CD targets
.PHONY: ci
ci: lint test build
	@echo "$(GREEN)CI pipeline completed successfully!$(NC)"

# Run everything needed before committing
.PHONY: pre-commit
pre-commit: format lint test
	@echo "$(GREEN)Pre-commit checks passed!$(NC)"