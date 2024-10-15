// fib_module.rs
// Source code for generating the Fibonacci sequence in WebAssembly

#[no_mangle]
pub extern "C" fn fib(n: u32) -> u32 {
    match n {
        0 => 0,
        1 => 1,
        _ => fib(n - 1) + fib(n - 2),
    }
}

// Instructions for building the WebAssembly module:
// 1. Install Rust and the wasm32 target:
//    $ rustup target add wasm32-unknown-unknown
// 2. Compile the module using Rust:
//    $ rustc --target wasm32-unknown-unknown -O --crate-type=cdylib fib_module.rs -o fib_module.wasm
// 3. Copy the generated `fib_module.wasm` file to the directory containing your HTML file.
//
// This code calculates the nth Fibonacci number using recursion, which is a simple demonstration.
// Note: For larger numbers, consider optimizing the implementation to improve performance.