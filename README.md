# NMOX Server

New Media On X Server: Squeak Smalltalk and Rust WASM demos included.

## Overview

NMOX-Server is a comprehensive cross-language meta-framework designed to build modern media applications based on the Unix philosophy. It emphasizes building small, simple, modular programs that do one thing well and work together through clear, standardized interfaces.

At the core of NMOX-Server is an object called "x", which can represent a PAGE, an API, or DATA. The "X" in NMOX symbolizes UNIX, emphasizing the principles of modularity, simplicity, and portability. The x object contains an x instance variable that can be one of three data types:

```
x = "text";          // Text
x = X.new();         // An X object
x = ['a', 'b', 'c']; // An array
```

By conceptualizing web-connected entities as objects (or structs in languages like C, Go, Rust), NMOX-Server ensures that standards permeate every aspect of your project. For example, the `P` object creates a Paragraph, while the `DIV` object creates a Division. These objects can be composed to form standards-compliant pages, APIs, or other instances of "x".

## Peace, Love, and Harmony

The motto of NMOX is "Peace, Love, and Harmony". These concepts are represented in the three data types: Strings, X objects, and arrays. A string is the resolved state of an object in NMOX. Arrays of these objects can serialize and deserialize into and out of JSON or XML. See `x/lib/org/NMOX.org` for more about these principles.

## Features

- **Modular Design**: Build applications using a consistent object-oriented approach.
- **Standards Compliance**: Ensures adherence to web standards and UNIX principles.
- **Extensibility**: Easily extend and customize objects to fit specific needs.

## Getting Started

To get started with NMOX-Server, follow these steps:

1. Clone the Repository:
   ```sh
   git clone https://github.com/nmox/nmox-server.git
   ```

2. Navigate to the x library Directory:
   ```sh
   cd nmox-server/x/lib/
   ```

3. Inspect the Code:
   Open the .image file in Squeak 6, or open the HTML or Rust source files in your preferred text editor.

## Filesystem Hierarchy Standard

NMOX-Server adheres to the [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) to ensure compatibility with *NIX systems. This standard defines the directory structure and directory contents in UNIX-like operating systems, ensuring a predictable environment.

## Contributing

We welcome contributions to NMOX-Server. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

## License

NMOX-Server is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

We would like to thank the contributors and the open-source community for their support and contributions.

---

For more information, visit our [website](https://nmox.org/).


