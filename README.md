# HomeClink
Small clink script to automatically expand `~` to `%HOME%` in any command the user executes via Windows' CMD shell.

## Installation
Simply place `HomeClink.lua` in any of the directories listed under 'scripts' when you run `clink info`, then start a new CMD session.

## Usage
Type any command and execute it as usual, any unescaped `~` will invisibly expand to `%HOME%`.

Any intentional tildes that are NOT intended be expanded should be escaped with a preceding `|`.

For example, `echo |~` will output `~`, because tilde was escaped, but `echo ~` will output `C:\Users\USER` (assuming your primary drive is C:).

## Tilde Expansion Exceptions
In addition to `|`-escaped tildes, there are other cases when a tilde will not be expanded. This script relies on Clink's builtin `rl.expandtilde` function for the actual tilde expansion, and this has its own quirks, such as:
  - Not expanding tildes in quoted paths.
    + E.g. The tilde in `cd ~/blah blah` will expand, but `cd "~/blah blah"` won't.
  - Only expanding each tilde at the start of each word/segment of a command.
    + E.g. `cd ~\~` becomes `cd C:\Users\USER\~`, rather than `cd C:\Users\USER\C:\Users\USER\`
  - Not expanding any tilde thought to be directly part of a filename, for example if followed by an extension.
    + E.g. `cat ~.txt` will always stay `cat ~.txt`, and will never expand to `cat C:\Users\USER\.txt`.
    + However, `cat ~\~.txt` will become `cat C:\Users\USER\~.txt`.