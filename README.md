# NMOX Server

New Media On X Server: A meta-framework implementing UNIX philosophy in web development, featuring live programming through Squeak Smalltalk and high-performance computing via Rust WebAssembly. Built on the central X object pattern, NMOX Server unifies cross-language web development with Docker-centric deployment.

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Key Features

- **UNIX Philosophy Integration**
  - Directory structure following FHS standards
  - Modular components that do one thing well
  - Simple interfaces using pipes and filters pattern
  - Text-based data formats for interoperability

- **Cross-Language Architecture**
  - Squeak Smalltalk for live programming and dynamic development
  - Rust/WebAssembly modules for performance-critical operations
  - Language-agnostic X object pattern implementation
  - Docker-based deployment with Nginx front-end

- **Development Tools**
  - GToolkit integration for moldable development
  - Live programming environment
  - WebAssembly performance examples
  - Integrated debugging tools

## Overview

NMOX Server implements a meta-framework for building modern web applications using UNIX principles. It emphasizes:

- Small, focused modules
- Clear interfaces
- Text-stream processing
- Composition over complexity

### The X Object

At its core, NMOX uses an `x` object that can represent:

```
x = "text"           # Peace (Resolution)
x = X.new()         # Love (Connection)
x = ['a', 'b', 'c'] # Harmony (Collection)
```

This pattern is implemented across languages:

```python
# Python
x = X("text")
```

```rust
// Rust
let x = X::new("text");
```

```ruby
# Ruby
x = X.new("text")
```

## Directory Structure

```
/nmox-server
├── /bin           # Executable programs
├── /etc           # Configuration files
├── /lib           # Libraries
│   ├── /org       # Organization-specific code
│   └── /x         # Core X object implementations
├── /opt           # Optional packages
├── /srv           # Service data
├── /tmp           # Temporary files
└── /var           # Variable data
    ├── /log       # Log files
    └── /www       # Web content
```

## Quick Start

1. **Clone the Repository**
   ```sh
   git clone https://github.com/nmox/nmox-server.git
   cd nmox-server
   ```

2. **Start with Docker**
   ```sh
   docker compose up -d
   ```

3. **Access Development Environment**
   ```sh
   open http://localhost:8080/studio
   ```

## Development Workflow

1. **Live Programming (Squeak)**
   - Open the `.image` file in Squeak 6
   - Use GToolkit for moldable development
   - Changes are reflected immediately

2. **Performance Modules (Rust)**
   ```sh
   cd lib/x/wasm
   wasm-pack build
   ```

3. **Deploy Changes**
   ```sh
   docker compose build
   docker compose up -d
   ```

## Architecture

NMOX Server implements three core principles:

1. **Peace** (Resolution)
   - String representations
   - Final rendered content
   - Serialized data

2. **Love** (Connection)
   - X objects linking components
   - Cross-language bridges
   - Service interfaces

3. **Harmony** (Collection)
   - Arrays of objects
   - Component composition
   - Data structures

## Standards Compliance

- HTML5/CSS3/ES2022 web standards
- POSIX compliance
- WAI-ARIA accessibility
- OAuth 2.0 authentication
- WebAssembly 2.0

## Performance Considerations

- Server-side rendering with hydration
- WebAssembly for compute-intensive tasks
- Edge caching support
- HTTP/3 ready
- Built-in performance monitoring

## Contributing

1. Fork the repository
2. Create a feature branch
   ```sh
   git checkout -b feature/amazing-feature
   ```
3. Commit changes
   ```sh
   git commit -m 'Add amazing feature'
   ```
4. Push to branch
   ```sh
   git push origin feature/amazing-feature
   ```
5. Open a Pull Request

## Testing

```sh
# Run unit tests
cargo test

# Run integration tests
npm run test:integration

# Run Squeak tests
./bin/test-image.sh
```

## License

MIT License - see [LICENSE](LICENSE)

## Project History

- 2001: Initial release
- 2008: Second edition
- 2024: Current v3 release

## Community

- [Discord](https://discord.gg/nmox)
- [Forum](https://discuss.nmox.org)
- [Wiki](https://wiki.nmox.org)

---

Documentation: [https://docs.nmox.org](https://docs.nmox.org)  
Contributing Guidelines: [CONTRIBUTING.md](CONTRIBUTING.md)
