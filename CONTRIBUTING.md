# Contributing to NMOX Server

Thank you for your interest in contributing to NMOX Server! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Philosophy](#philosophy)
- [Getting Started](#getting-started)
- [Development Environment](#development-environment)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Documentation](#documentation)
- [Testing](#testing)
- [Language-Specific Guidelines](#language-specific-guidelines)
- [Community](#community)

## Code of Conduct

NMOX Server follows the principles of Peace, Love, and Harmony. We expect all contributors to:

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain professional discourse
- Follow the UNIX philosophy of simplicity and modularity

## Philosophy

When contributing to NMOX Server, keep in mind our core principles:

1. **UNIX Philosophy**
   - Write programs that do one thing and do it well
   - Write programs to work together
   - Write programs to handle text streams

2. **X Object Pattern**
   - Maintain consistency with the X object model
   - Follow the Peace (String), Love (X), Harmony (Array) paradigm
   - Ensure cross-language compatibility

3. **Standards First**
   - Adhere to web standards
   - Follow POSIX conventions
   - Maintain accessibility compliance

## Getting Started

1. **Fork and Clone**
   ```sh
   git clone https://github.com/YOUR-USERNAME/NMOX-Server.git
   cd NMOX-Server
   git remote add upstream https://github.com/NMOX/NMOX-Server.git
   ```

2. **Set Up Development Environment**
   ```sh
   # Install dependencies
   make install-dev
   
   # Set up pre-commit hooks
   make setup-hooks
   ```

3. **Create a Branch**
   ```sh
   git checkout -b feature/your-feature-name
   ```

## Development Environment

Required tools:

- Docker and Docker Compose
- Squeak 6.0 or later
- Rust toolchain (latest stable)
- Node.js 20.x or later
- GToolkit (for live programming)

Optional but recommended:

- direnv (for environment management)
- shellcheck (for script validation)
- hadolint (for Dockerfile linting)

## Coding Standards

### General Guidelines

- Follow the principle of least surprise
- Write self-documenting code
- Keep functions small and focused
- Use meaningful variable names
- Comment only what code cannot clearly convey
- Follow SOLID principles

### Directory Structure

Maintain the FHS-like structure:
```
/NMOX-Server
├── /bin           # Executables
├── /etc           # Configuration
├── /lib           # Libraries
├── /test          # Tests
└── /var           # Variable data
```

### File Naming

- Use kebab-case for files: `my-component.js`
- Use PascalCase for X objects: `MyComponent.x`
- Use snake_case for internal modules: `internal_utils.rs`

## Commit Guidelines

Follow conventional commits:

```
type(scope): subject

body

footer
```

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code restructuring
- test: Adding tests
- chore: Maintenance

Example:
```
feat(x-object): add array transformation methods

Implements new methods for transforming arrays in the X object:
- map
- filter
- reduce

Closes #123
```

## Pull Request Process

1. **Update Documentation**
   - Add/update relevant documentation
   - Include code examples where appropriate
   - Update CHANGELOG.md

2. **Run Tests**
   ```sh
   make test          # Run all tests
   make test-rust     # Run Rust tests
   make test-squeak   # Run Squeak tests
   ```

3. **Check Standards**
   ```sh
   make lint         # Run all linters
   make fmt          # Format code
   ```

4. **Create Pull Request**
   - Use the PR template
   - Link related issues
   - Provide clear description
   - Include test results

5. **Review Process**
   - Address reviewer feedback
   - Maintain commit history
   - Rebase if needed
   - Ensure CI passes

## Documentation

- Use Org-mode format when possible
- Include examples for each feature
- Document both usage and implementation
- Keep language-specific docs in respective directories
- Update API documentation

## Testing

Required tests for all contributions:

- Unit tests for new features
- Integration tests for components
- Performance tests for critical paths
- Cross-language interface tests
- Documentation tests

## Language-Specific Guidelines

### Rust
- Follow Rust 2021 edition idioms
- Use `cargo fmt` and `cargo clippy`
- Implement `From` for X object conversions
- Document public APIs

### Squeak/Smalltalk
- Follow Smalltalk naming conventions
- Use GToolkit for development
- Include live programming examples
- Document message patterns

### JavaScript/TypeScript
- Use ESM modules
- Follow StandardJS style
- Include JSDoc comments
- Use TypeScript for type safety

## Community

- Join our [Discord](https://discord.gg/nmox)
- Participate in [Discussions](https://github.com/NMOX/NMOX-Server/discussions)
- Follow our [Blog](https://blog.nmox.org)
- Attend monthly community calls

## Questions?

Feel free to:
- Open an [Issue](https://github.com/NMOX/NMOX-Server/issues)
- Start a [Discussion](https://github.com/NMOX/NMOX-Server/discussions)
- Email the maintainers: maintainers@nmox.org

---

Thank you for contributing to NMOX Server! Your efforts help make the project better for everyone.
