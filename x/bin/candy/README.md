# candy

Candy is a collection (or suite) of tools that make the CLI slightly more fun and/or better. Think of it as syntactic sugar, but modular, following the Unix philosophy.

## Usage

The files in the Candy Suite are meant to be added to your path on the command line. You can do this by editing the resource file for your shell, in a file that looks like one of these:

- .zshrc
- .bashrc
- .profile

The `.profile` option will only work when you run a login shell, which is fine for our purposes if you as a human are the only one going to use these tools. For system-wide usage, at least for your user, add the following instruction to e.g. `~/.zshrc`:

```bash
export PATH=~/bin/candy:$PATH
```

(If you install candy inside your home directory's bin folder, for example.) For use with NMOX Server, place x/bin/candy in your path.

## Applications
The following apps are listed in alphabetical order for the candy suite:

- uptime: A slightly fancier uptime display. (e.g., candy-uptime could show uptime with a colorful progress bar or a fun "system has been awake for X hours" message)
- status: A status viewer for the system. (e.g., candy-status could show CPU usage, memory, network stats in a compact format)
- (Add more applications here as we develop them)

# Contributing
Contributions are welcome! Feel free to open issues or submit pull requests.

# License
MIT License


**Clever CLI App Ideas:**

Here are some ideas for cleverly named CLI utilities, playing on the "candy" theme:

* **`lollipop`:**  A command to "wrap" another command and display its output in a colorful, visually appealing way.  Like a lollipop makes medicine more appealing!
* **`gumball`:** A random fun fact or quote generator. Every time you run it, you get a different "gumball" of information.
* **`jawbreaker`:** A tool to break down complex command outputs (like `ls -l`) into more digestible, user-friendly formats.
* **`pixie_stick`:**  A command to quickly generate random passwords or strings of characters.  (Like the sugary chaos of a pixie stick!)
* **`candy_corn`:**  A tool for managing and switching between different shell configurations. (Maybe because candy corn is somewhat controversial - like some shell configs!)
* **`rock_candy`:**  A command to encrypt and decrypt files. (Rock candy is hard to break!)
* **`everlasting_gobstopper`:** A command to run a process in the background and keep it alive (like an everlasting gobstopper that never disappears).


**Remember to focus on the Unix philosophy:**

* Each utility should do one thing well.
*  Utilities should be designed to work together.
*  Output of one utility can be the input of another.