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
     <[-]>[-] ; empty the line number
    ]
    >
   ]
   <
   ;; FIXME:
   ;; * continues input if "dot only"
   ;; * exits if input is longer than one char
   ;; * Completes if a single char on a single line
   [ ; when 'c'
    ->[-] ; erase the command flag and command
    << ; back to line number
    ;; 41 cells to the right is the beginning of the line sector
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ,----- ----- [>,----- -----] ; read a text until a newline
    <[+++++ +++++<] ; restore the original text
    >>[<<<+<+>>>>-]<<<<[>>>>+<<<<-] ; copy second char if present
    >>+>> ; set the flag for length checking and move to second char
    [ ; if length more than 1 (= second char nonzero)
     <<- ; kill flag
     ;; move 39 chars back to the command flag and set it
     <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<+
     < ; line number
     [[ ; copy the command to the next line
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>> >> ; 122 chars forward is next command sector
       +
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<< << -
      ]
      >
     ]
     >
     [[ ; copy the command to the next line (in case there's anything left)
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>> > + ; 121 chars forward to merge it with previous block
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<< < -
      ]
      >
     ]
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>> > ; next sector
     ; move to the line number and increase it
     [<]>+
     ;; 42: back to the second char of a new line
     >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
     ;; copy second char to the left and leave empty
     [<<<+>>>-]
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
      +++++ +++++
      +++++ +++++
      +++++ +++++
      +++++ +++++
      +++++ +    ; dot
      <<[-]>> ; destroy the copy of first char now that it's restored
      ;; move 40 chars back to the command flag and set it
      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<+
      < ; line number
      [[ ; copy the command to the next line
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>> >> ; 122 chars forward is next command sector
        +
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<< << -
       ]
       >
      ]
      >
      [[ ; copy the command to the next line (in case there's anything left)
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>>
        >>>>> >>>>> >>>>> >>>>> > + ; 121 chars forward to merge it with previous block
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<<
        <<<<< <<<<< <<<<< <<<<< < -
       ]
       >
      ]
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>>
      >>>>> >>>>> >>>>> >>>>> > ; next sector
      ; move to the line number and increase it
      [<]>+
      ;; 41: back to the first char of a new line
      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
     ]
     <<[>>+<<-] ; restore the first char
     >
     [ ; if dot AND nothing else (insert finished)
      - ; kill flag
      >[-] ; destroy the dot line
      ;; Move to the line number
      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      <+> ; set "line number is 1" flag
      -
      [ ; if line number not 1
       <-> ; kill flag
       [[ ; copy the command to the prev line
         <<<<< <<<<< <<<<< <<<<<
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
         >>>>> >>>>> >>>>> >>>>> >> - ; 122 chars back is prev command sector
        ]
        >
       ]
       >
       [[ ; copy the command to the prev line (in case there's anything left)
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<<
         <<<<< <<<<< <<<<< <<<<< < +
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>>
         >>>>> >>>>> >>>>> >>>>> > - ; 121 chars forward to merge it with previous block
        ]
        >
       ]
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<<
       <<<<< <<<<< <<<<< <<<<< < ; prev sector
       [<]>+ ; move to the line number and increase it
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>> >> ; back to the next sector line number
      ]
      <
      [ ; if line 1
       -> ; kill flag, move to line number
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>>
       >>>>> >>>>> >>>>> >>>>> >> ; one sector forward to compensate the move below
       <[-] ; to flag cell (empty it just in case)
      ]
      >
      <<<<< <<<<< <<<<< <<<<<
      <<<<< <<<<< <<<<< <<<<<
      <<<<< <<<<< <<<<< <<<<<
      <<<<< <<<<< <<<<< <<<<<
      <<<<< <<<<< <<<<< <<<<<
      <<<<< <<<<< <<<<< <<<<< <<+ ; one sector back and increase it
     ]
    ]
    <[>>+<<-] ; restore first char unconditionally
    ;; Move to command flag and loop
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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


