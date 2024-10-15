# candy

Candy is a collection (or suite) of tools that make the CLI slightly more fun and/or better.

## Usage

The files in the Candy Suite are meant to be added to your path on the command line. You can do this by editing the resource file for your shell, in a file that looks like one of these:
- .zshrc
- .bashrc
- .profile

The profile one will only work when you run a login shell, which is fine for our purposes if you as a human are the only one going to use these tools. For system-wide usage, at least for your user, add the following instruction to e.g. ~/.zshrc:

export PATH=~/bin/candy:$PATH

(If you install candy inside your home directory's bin folder, for example.) For use with NMOX Server, place x/bin/candy in your path.

