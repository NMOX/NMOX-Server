# Candy

Candy is a collection (or suite) of tools that make the command line interface (CLI) slightly more fun and/or more efficient. Think of it as syntactic sugar for the CLI, modular and simple, following the Unix philosophy.

## History

The Candy Suite traces its roots back to a 2008 project called CLI-MAX (Command Line Interface - MySQL/Apache/Unix). CLI-MAX was an early attempt to bring a layer of convenience and "syntactic sugar" to the CLI experience.

## Usage

The tools in the Candy Suite are intended to be added to your system's path, making them easily accessible from your command line. To do this, add the following line to your shell's configuration file (e.g., `.zshrc`, `.bashrc`, or `.profile`):

```bash
export PATH=~/bin/candy:$PATH
```

If you have installed Candy in your home directory's `bin` folder, the above line will make these tools accessible whenever you open a terminal. For NMOX Server usage, ensure that `x/bin/candy` is in your path.

> Note: Using `.profile` will only work when running a login shell, which is usually sufficient if you're the only one using these tools. For wider usage, consider adding it to `.zshrc` or `.bashrc`.

## Applications

Below is a list of tools currently available in the Candy Suite, presented in alphabetical order:

- **uptime**: A slightly fancier uptime display. For example, `candy-uptime` might show uptime with a colorful progress bar or a friendly "System has been awake for X hours" message.
- **status**: A status viewer for the system, displaying CPU usage, memory, and network stats in a compact format.

More tools will be added as the suite continues to grow.

## CLI App Ideas

Here are some ideas for future additions to the Candy Suite, playing on the candy theme:

- **`lollipop`**: Wraps another command and displays its output in a visually appealing, colorful way, like a lollipop makes medicine more fun.
- **`gumball`**: A random fun fact or quote generator. Every time you run it, you get a new "gumball" of information.
- **`jawbreaker`**: Breaks down complex command outputs (like `ls -l`) into more digestible formats.
- **`pixie_stick`**: Quickly generates random passwords or strings of characters, like the chaos of a pixie stick.
- **`candy_corn`**: Helps manage and switch between different shell configurations, embracing the divisiveness of candy corn.
- **`rock_candy`**: Encrypts and decrypts files. Rock candy is hard to break, just like encryption.
- **`everlasting_gobstopper`**: Runs a process in the background and keeps it alive, similar to an everlasting gobstopper that never disappears.

## Contributing

Contributions are always welcome! Feel free to open issues or submit pull requests to help improve Candy.

## License

This project is licensed under the MIT License.

## Unix Philosophy Reminders

- Each utility should do one thing well.
- Tools should be designed to work together.
- The output of one utility should be usable as the input to another.

We aim to keep the spirit of Unix alive while making the CLI a more enjoyable space.

