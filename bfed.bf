[bfed.bf -- the source code of bfed, Brainfuck-based ed re-implementation.

Code starts here:]

>+ ; line number / exit flag
[ ; main loop
 >>,----- ----- [>,----- -----] ; read a text until a newline
 <[+++++ +++++<] ; restore the original text
 +> ; set the case flag and get back to the command text
 ;;; case
 [ ; if exists
  ;; minus (45)
  ----- -----
  ----- -----
  ----- -----
  ----- -----
  -----
  [ ; '=' (61)
   ----- -----
   ----- -
   [ ; 'c' (99)
    ----- -----
    ----- -----
    ----- -----
    ----- ---
    [ ; 'd' (100)
     -
     [ ; 'p' (112)
      ----- ----- --
      [ ; 'q' (113)
       -
       [ ; not 'q'
        <->[-] ; empty the flag
        ;; error
        ;; question mark
        +++++ +++++
        +++++ +++++
        +++++ +++++
        +++++ +++++
        +++++ +++++
        +++++ +++++ +++.[-]
        +++++ +++++.[-]
       ]
       <
       [ ; when 'q'
        [-]<[-]> ; empty the line number and command flag
       ]
       >
      ]
      <
      [ ; when 'p'
       [-] ; empty command flag
       ;; 40 cells to line start
       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
       [.>] ; print the whole line
       +++++ +++++.[-] ; print newline
       <[<]
       ;; 39 back to empty command flag
       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      ]
      >
     ]
     <
     [ ; when 'd'
      - ; kill command flag
      ;; 40: move to the start of next line
      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      [>]< ; then to the end of it
      [[-]<]> ; erase everything and stop at the line start
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>> >> ;; 122 to next line
      [
       [>]<
       ;; copy the full line
       [[<<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<< << +
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>> >> -
       ]<]
       ;; 123: compensate for the copy loop and move to next line
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>> >>>
      ]
      ;; 40: back to the command flag and set it
      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<+
      [
       -
       ;; 122: Move to the previous command flag
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<< << + ; and set it
       < ; move to line number
       [ ; if line number
        >-< ; kill command flag
        [<+>-] ; copy line number and exit the loop
       ]
       <[>+<-]> ; restore (possibly) destroyed line number
       > ; back to command flag | exit if line number was there
      ]
     ]
     >
    ]
    <
    [ ; when 'c'
     - ; erase the command flag
     ;; 40 cells to the right is the beginning of the line sector
     >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
     ,----- ----- [>,----- -----] ; read a text until a newline
     <[+++++ +++++<] ; restore the original text
     ;; 39 Move to command flag and exit
     <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ]
    >
   ]
   <
   [ ; when '='
    < ; move to line number
    ;; https://esolangs dot org/wiki/Brainfuck_algorithms hash
    ;; Print_value_of_cell_x_as_number_for_ANY_sized_cell_ dot
    ;; 28eg_8bit dot 2C_100000bit_etc dot 29
    >[-]>[-]+>[-]+<                         // Set n and d to one to start loop
    [                                       // Loop on 'n'
     >
     [-<-                               // On the first loop
      <<[->+>+<<]                     // Copy V into N (and Z)
      >[-<+>]>>                       // Restore V from Z
     ]
     ++++++++++>[-]+>[-]>[-]>[-]<<<<<    // Init for the division by 10
     [->-[>+>>]>[[-<+>]+>+>>]<<<<<]      // full division
     >>-[-<<+>>]                         // store remainder into n
     <[-]++++++++[-<++++++>]             // make it an ASCII digit; clear d
     >>[-<<+>>]                          // move quotient into d
     <<                                  // shuffle; new n is where d was and
                                         //   old n is a digit
    ]                                   // end loop when n is zero
    <[.[-]<]                                // Move to were Z should be and
                                         // output the digits till we find Z
    ;; We are at the command flag now
    +++++ +++++.[-]
   ]
   >
  ]
  <
  [ ; when minus
   <- ; move to line number and decrease it
   [
    >[-]< ; kill command flag
    ;; copy line number one line back
    [<<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<< << +
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>> >> -]
    ;; move one line back
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<< <<
    [<+>-] ; copy line number one cell to the right
    ;; move to the line and print it
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>[.>]+++++ +++++.[-]
    ;; back to empty line number and empty command flag
    <[<]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]<
   ]
   <[>+<-]> ; possibly restore line number
   >
   [ ; if command flag is there (no movement happened)
    <+> ; restore line number
    [-]
    ;; question mark
    +++++ +++++
    +++++ +++++
    +++++ +++++
    +++++ +++++
    +++++ +++++
    +++++ +++++
    +++.[-]
    +++++ +++++.[-]
   ]
  ]
  >
 ]
 <
 [ ; when a single newline
  ;; move to the beginning of line and set presence flag
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+>
  [ ; if something on the line
   <-> ; kill presence flag
   [.>]+++++ +++++.[-] ; print the line
   ;; loop and 40: move back to line number
   <[<]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ;; 122: copy line number one sector forward
   [>>>>> >>>>> >>>>> >>>>>
    >>>>> >>>>> >>>>> >>>>>
    >>>>> >>>>> >>>>> >>>>>
    >>>>> >>>>> >>>>> >>>>>
    >>>>> >>>>> >>>>> >>>>>
    >>>>> >>>>> >>>>> >>>>> >> +
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<<
    <<<<< <<<<< <<<<< <<<<< << -]
   ; 122: move to next line (increase line number)
   >>>>> >>>>> >>>>> >>>>>
   >>>>> >>>>> >>>>> >>>>>
   >>>>> >>>>> >>>>> >>>>>
   >>>>> >>>>> >>>>> >>>>>
   >>>>> >>>>> >>>>> >>>>>
   >>>>> >>>>> >>>>> >>>>> >> +
   ;; 41: move to line start
   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   [<<+>>-] ; copy the first char if something on the line
  ]
  <<[>>+<<-] ; copy (possibly) saved first char
  > ; back to the presence flag
  [
   [-]
   ;; question mark
   +++++ +++++
   +++++ +++++
   +++++ +++++
   +++++ +++++
   +++++ +++++
   +++++ +++++
   +++.[-]
   +++++ +++++.[-]
  ]
  ;; 39: back to the command flag and kill it
  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]
 ]
 < ; back to line number
] ; main loop


