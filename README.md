# bfed -- an opinionated ed re-implementation in Brainfuck

`ed` is notorious for being the most user-hostile text editor. Brainfuck is notorious for being one of the most programmer-hostile programming languages. Feels like a perfect match, doesn't it?

This is an incomplete, buggy and (potentially) Turing-complete re-implementation of UNIX ed in Brainfuck. It is *already* non-standard in where I feel it necessary.

The Memory layout (see below) it has allows for terrible hacks and more efficient text editing if you understand it. I will *never* fix the memory layout being overrestrictive/hackable. Enjoy.

## Getting started

Clone the code
```
  git clone https://github.com/aartaka/bfed.git
```

Find the proper implementation. bfed work only on implementations where:
- All cells are initially zeroed.
- Tape size is at least 122 * cell size (see layout for why).
- Cell wraparound works in both directions.

Run bfed.bf and enjoy the most user-and-programmer-hostile text editor!

## Memory layout
Layout is approximately this:

```
[0][40 command cells][0][80 text cells (a line)][0][40 command cells][0] et cetera  
```

80 text cells mean a restriction of 80 characters per line. Enforcing this otherwise optional thing helps to ensure the layout stability.

40 command cells need a further explanation. After the command parsing, their layout is

```
[line number/exit flag][0][command][37 argument cells]
```

This layout hints at some more restrictions that bfed has:

- Line number is one cell, and thus there can only be as many lines, as cell capacity allows. For 8 bit implementations, 255 is the maximum line number. Pick a 16/32/64 bit implementation if you want more lines.
- Line number serves as the exit flag. If it's zero, bfed exits. Thus, the range of values for line numbers is 1 to 255.
- Commands can only be one char wide, as in classic ed.
- There are only 37 cells for arguments. Anything wider will break bfed in horrible ways. Unless you know what you're doing, restrict your command arguments to 37 characters.

You can hack the layout, if you want. It is trivial to rewrite command/line areas by supplying overly long input.

## To Do
- [ ] Simple commands (`a`, `d`, `=` etc.)
  - [X] `=` -- half-standard: indexes lines from 1.
  - [X] `q` -- non-standard: does not prompt for confirmation. Brainfuck has no file handling anyway.
  - [X] `c` -- non-standard: inserts exactly one line terminated by newline. Creates the line if necessary.
  - [X] `p`.
  - [X] newline -- non-standard: moves forward and prints lines until an empty line is encountered. Stays on this empty line.
  - [X] `d`.
  - [X] `-`.
- [ ] Commands with args (`s` etc.)
- [ ] Commands with optional args.
- [ ] Address without a command.
- [ ] Simple addresses (`1`, `222`).
- [ ] Ranges (`10-20`).
- [ ] Address aliases (`,` and `.`, `$`, `;`, `%`).
- [ ] Relative addresses (`-10`).
- [ ] Mark addresses (`k`, `\``).
- [ ] Forward regexp addresses.
- [ ] Backward regexp addresses.
- [ ] Use GNU m4 macros to reduce code repetition.
  - Is that worthy of Brainfuck programmer? No, it's not.
    - Do I care? Depends on how much bloat I'll end up with.

## Contributing
- Stick to Code conventions listed below.
- Change the code and comment the changes exhaustively.
- Open a PR with the clear explanation of what you've done.
  
### Code conventions
- Every loop body is indented by one more space than the outer code.
  - Matching brackets have the same indentation.
- Every semantically separate piece of code is put onto the line of their own.
- Comments start with semicolon(s), as in Assembly or Lisp.
  - Three semicolons are a comment for a block of code.
  - Two semicolons are comments for a line or a small block,
    standing on a separate line.
  - One semicolon is a line comment just after the code.
  - Comments always end with a newline. No comment-code mixing.

## Change Log
### Version 1.0
Finally, a full range of editing primitives: =, -, newline, c, d, p.

## Acknowledgements

The cell printing snippet is taken from [Brainfuck wiki](https://esolangs.org/wiki/Brainfuck_algorithms#Print_value_of_cell_x_as_number_for_ANY_sized_cell_.28eg_8bit.2C_100000bit_etc.29).

##  License
BSD 2-Clause