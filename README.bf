[ED.BF---AN OPINIONATED ED RE-IMPLEMENTATION IN BRAINFUCK

 The original grep [as part of ed text editor] was written [overnight]
 in PDP-11 assembly language [by Ken Thompson].
 -- Brian Kernigan, in the YouTube Computerphile video about grep
 (https://www.youtube.com/watch?v=NTfOnGZUZDk).

 Not being Ken Thompson is a struggle every working software engineer
 has to contend with.
 -- David Gillies, a YouTube comment under the same video.

 UNIX ed is notorious for being the most user-hostile text editor. It
 was initially implemented in assembly. Brainfuck is notorious for
 being one of the most programmer-hostile programming languages. It is
 extremely close to assembly. Feels like a perfect match for one get
 the feel of the legendary programmer existence, doesn't it?

 ed.bf is an incomplete, buggy and (potentially) Turing-complete
 re-implementation of UNIX ed in Brainfuck. It is ALREADY non-standard
 in where we feel it necessary.

 The memory layout (see below) it has allows for terrible hacks and
 more efficient text editing if you understand it. It will NEVER be
 fixed and will always stay overrestrictive/hackable. Enjoy.

 [1 GETTING STARTED

  Clone the code:
  [shell:
   git clone https://github.com/bf-enterprise-solutions/ed.bf.git]

  Find the proper implementation. ed.bf work only on implementations where:
  - All cells are initially zeroed.
  - Tape size is at least 122 * cell size (see layout for why).
  - Cell wraparound works in both directions.

  Run ed.bf and enjoy the most user-and-programmer-hostile text editor!]

 [2 ED.BF COMMANDS

  - 'c' to change the current line.
  - 'd' to remove the current line (flush it clean, basically). Moves
  all the filled lines after the deleted ones to cover the deleted
  one.
  - 'p' to print the current line.
  - '=' to print the current line number. Even if the line is empty.
  - newline to go to next line.
  - '-' to go to previous line.
  - '!' to evaluate Brainfuck code on the current line contents. Given
    that Brainfuck implies no underlying OS, there's no shell. Thus,
    the meta-evaluation of Brainfuck code is as close to ed's '!'
    meaning as we can get. Uses meta.bf
    (https://github.com/bf-enterprise-solutions/meta.bf) internally.
  - 'q' to exit ed.bf.]

 [3 EXAMPLE SESSION

  This is simply a free-style copy of the example ed session from
  Wikipedia (https://en.wikipedia.org/wiki/Ed_(text_editor)#Example).

  Lines starting with '>' are user input. Note that ed.bf doen't do
  any indication of when to input commands, much like original
  ed. Thus, these '>' were added for clarity and shouldn't be there in
  the actual session.

  Also note that ed.bf doesn't yet support comments, neither on the
  line by themselves nor inline. Those were added for clarity
  too. Using those can break ed.bf. Or it won't do anything, who
  knows...
  =========================================================================
  # bff is used as bf interpreter there, but any other
  # interpreter/compiler should be fine too
  $ bff ed.bf # run ed.bf
  > c # input one line
  > ed.bf is an opinionated UNIX ed re-implementation in Brainfuck.
  >
  ed.bf is an opinionated UNIX ed re-implementation in Brainfuck.
  > c # input another line
  > This is line number two.
  >
  This is line number two.
  > c # input empty line
  >
  > = # print a line number
  3
  > - # line back
  This is line number two.
  > - # line back
  ed.bf is an opinionated UNIX ed re-implementation in Brainfuck.
  > - # line back, but there's nowhere to go
  ?
  > p # print current line
  ed.bf is an opinionated UNIX ed re-implementation in Brainfuck.
  > ! [.>]+++++ +++++.[-] # run a script
  ed.bf is an opinionated UNIX ed re-implementation in Brainfuck.
  > q # quit
  =========================================================================]

 [3 MEMORY LAYOUT

  Layout is approximately this:
  [0][80 command cells][0][80 text cells (a line)][0][80 command cells][0] etc.

  80 text cells mean a restriction of 80 characters per
  line. Enforcing this otherwise optional thing helps to ensure the
  layout stability.

  80 command cells need a further explanation. After the command
  parsing, their layout is:
  [line number/exit flag][start line number][end line number][command flag][command][75 argument cells]


  This layout hints at some more restrictions that ed.bf has:

  - Line number is one cell, and thus there can only be as many lines,
  as cell capacity allows. For 8 bit implementations, 255 is the
  maximum line number. Pick a 16/32/64 bit implementation if you
  want more lines.
  - Same restriction holds for start and end line numbers.
  - Line number serves as the exit flag. If it's zero, ed.bf
  exits. Thus, the range of values for line numbers is 1 to 255.
  - Commands can only be one char wide, as in classic ed.
  - There are only 75 cells for arguments. Anything wider will break
  ed.bf in horrible ways. Unless you know what you're doing,
  restrict your command arguments to 75 characters.
  - Command flag is the flag used for the command switch. It should be
  zero unless the current command is not yet processed.
  - Start and end line numbers are not yet used, but will be... one
  day.

  You can hack the layout, if you want. It is trivial to rewrite
  command/line areas by supplying overly long input.]

 [4 TO DO
  - [ ] More commands
  -- [ ] Simple commands ('a', 'd', '=' etc.)
  --- [X] '=' -- half-standard: indexes lines from 1. Prints current
  line, instead of the last line.
  --- [X] 'q' -- non-standard: does not prompt for
  confirmation. Brainfuck has no file handling anyway.
  --- [X] 'c' -- non-standard: inserts exactly one line terminated by
  newline. Creates the line if necessary.
  --- [X] 'p'.
  --- [X] newline -- non-standard: moves forward and prints next line
  unless it's an empty line. Stays on this empty line.
  --- [X] 'd'.
  --- [X] Standalone '-'.
  -- [ ] Commands with args ('s' etc.)
  -- [ ] OS-specific placeholders ('w', 'r').
  -- [ ] Commands with optional args.
  -- [X] Meta-evaluation with '!'.
  - [ ] Addresses.
  -- [X] Address without a command -- half-standard: moves to lines
  that don't even exist yet. Enjoy.
  -- [X] Simple addresses ('1', '222').
  -- [ ] Ranges ('10,20').
  -- [ ] Address aliases (',' and '.', '$', ';', '%').
  -- [ ] Relative addresses ('-10').
  -- [ ] Mark addresses ('k', ''').
  -- [ ] Forward regexp addresses.
  -- [ ] Backward regexp addresses.
  -- [ ] Addresses with commands.
  - [ ] Make ed.bf embeddable.
  -- [ ] Terminate on the same memory cell that ed.bf started on.
  -- [ ] Clean up the memory before terminating.
  - [ ] Use GNU m4 macros to reduce code repetition.
  -- Is that worthy of Brainfuck programmer? No, it's not.
  --- Do I care? Depends on how much bloat I'll end up with.]

 [5 CHANGE LOG
  Version 1.5.7-revision-12
  - Integrate meta.bf nested loops support.

  Version 1.4:
  - Rename to ed.bf and polish the code a bit.

  Version 1.3:
  - Add meta-evaluation in with the help of meta.bf
    (https://github.com/bf-enterprise-solutions/meta.bf).

  Version 1.2
  - A new and minimal bfed-min.bf

  Version 1.1
  - Command sectors are 80 cells long now.

  Version 1.0
  - Finally, a full range of editing primitives: =, -, newline, c, d, p.]]
