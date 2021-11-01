[bfed.bf -- the source code of bfed, Brainfuck-based ed re-implementation.

Code starts here:]

>+ ; line number / exit flag
[ ; main loop
 >>,----- ----- [>,----- -----] ; read a text until a newline
 <[+++++ +++++<] ; restore the original text
 > ; get back to the command text
 <+> ; set the case flag
 ;;; case
 [ ; if exists
  ;; '=' (61)
  ----- -----
  ----- -----
  ----- -----
  ----- -----
  ----- -----
  ----- ----- -
  [ ; 'c' (99)
   ----- -----
   ----- -----
   ----- -----
   ----- ---
   [ ; 'q' (113)
    ----- ----- ----
    [ ; not 'q'
     <->[-]
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
     <[-]>[-] ; empty the line number
    ]
    >
   ]
   <
   [ ; when 'c'
    >[-] ; erase the command
    << ; back to line number
    ;; 41 cells to the right is the beginning of the line sector
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ,----- ----- [>,----- -----] ; read a text until a newline
    <[+++++ +++++<] ; restore the original text
    >>[<<<+<+>>>>-]<<<<[>>>>+<<<<-] ; copy second char if present
    >>+>> ; set the flag for length checking
    [ ; if length more than 1 (= second char nonzero)
     <<- ; kill flag
     >>[-] ; nullify second char (to exit the loop)
    ]
    <<<[>>>+<<<-] ; copy second char back
    >>[<<+<+>>>-]<<<[>>>+<<<-]>> ; duplicate the first char and move to flag
    [ ; if length is 1
     >
     ----- -----
     ----- -----
     ----- -----
     ----- -----
     ----- -    ; dot
     [ ; if not dot
      [-]<-> ; kill flag
      ;; TODO: set the command to something (1) to continue the insert loop
     ]
     <<[>>+<<-] ; restore the first char
     >
     [ ; if dot AND nothing else (insert finished)
      - ; kill flag
      ;; TODO:
      ;; * remove the dot line
      ;; * Move line back
      ;; * Check whether on a first line
      ;;   * If on a first line do nothing
      ;;   * Otherwise go back
     ]
    ]
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
    >[-<-                               // On the first loop
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
   +++++ +++++.[-]
  ]
  >
 ]
 <
 [ ; when does not exist
  ;; question mark
  +++++ +++++
  +++++ +++++
  +++++ +++++
  +++++ +++++
  +++++ +++++
  +++++ +++++
  +++.[-]
  +++++ +++++.[-]
  >[-]<
 ]
 <
] ; main loop


