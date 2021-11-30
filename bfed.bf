[bfed.bf -- the source code of bfed, Brainfuck-based ed re-implementation.

 Code starts here:]

>+ ; line number / exit flag
[ ; main loop
 >>>>,----- ----- [>,----- -----] ; read a text until a newline
 <[+++++ +++++<] ; restore the original text
 +> ; set the case flag and get back to the command text
 ;;; switch
 [ ; if exists
  ;; minus (45)
  ----- -----
  ----- -----
  ----- -----
  ----- -----
  -----
  [ ; zero (48)
   ---
   ;1 2 3 4 5 6 7 8 9 (49 to 57 respectively)
   [-[-[-[-[-[-[-[-[-
            [ ; '=' (61)
             ----
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
                 [ ; case 'q':
                  [-]<<<[-]>>> ; empty the line number and command flag
                 ]
                 >
                ]
                <
                [ ; case 'p':
                 [-] ; empty command flag
                 ;; 38: to line start
                 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                 [.>] ; print the whole line
                 +++++ +++++.[-] ; print newline
                 <[<]
                 ;; 37: back to empty command flag
                 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                ]
                >
               ]
               <
               [ ; case 'd':
                - ; kill command flag
                ;; 38: move to the start of next line
                >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
                ;; 38: back to the command flag and set it
                <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<+
                [
                 -
                 ;; 122: Move to the previous command flag
                 <<<<< <<<<< <<<<< <<<<<
                 <<<<< <<<<< <<<<< <<<<<
                 <<<<< <<<<< <<<<< <<<<<
                 <<<<< <<<<< <<<<< <<<<<
                 <<<<< <<<<< <<<<< <<<<<
                 <<<<< <<<<< <<<<< <<<<< << + ; and set it
                 <<< ; move to line number
                 [ ; if line number
                  >>>-<<< ; kill command flag
                  [<+>-] ; copy line number and exit the loop
                 ]
                 <[>+<-]> ; restore (possibly) destroyed line number
                 >>> ; back to command flag | exit if line number was there
                ]
               ]
               >
              ]
              <
              [ ; case 'c':
               - ; erase the command flag
               ;; 38: beginning of the line sector
               >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
               ,----- ----- [>,----- -----] ; read a text until a newline
               <[+++++ +++++<] ; restore the original text
               ;; 37: to command flag and exit
               <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              ]
              >
             ]
             <
             [ ; case '=':
              <<< ; move to line number
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
              >> ; we are at the command flag now
              +++++ +++++.[-]
             ]
             >
            ]
            <[[->+<]>+<]>[<+>-]] ; case '9': increase command flag FALLTHROUGH
           <[[->+<]>+<]>[<+>-]] ; case '8': increase command flag FALLTHROUGH
          <[[->+<]>+<]>[<+>-]] ; case '7': increase command flag FALLTHROUGH
         <[[->+<]>+<]>[<+>-]] ; case '6': increase command flag FALLTHROUGH
        <[[->+<]>+<]>[<+>-]] ; case '5': increase command flag FALLTHROUGH
       <[[->+<]>+<]>[<+>-]] ; case '4': increase command flag FALLTHROUGH
      <[[->+<]>+<]>[<+>-]] ; case '3': increase command flag FALLTHROUGH
     <[[->+<]>+<]>[<+>-]] ; case '2': increase command flag FALLTHROUGH
    <[[->+<]>+<]>[<+>-]] ; case '1': increase command flag FALLTHROUGH
   <
   [ ; case '0':
    [>+<-]>-> ; get to the first unprocessed digit
    [ ; get it to be 1 to 10 for 0 to 9
     ----- -----
     ----- -----
     ----- -----
     ----- -----
     ----- -- >]
    <[<]>> ; back to the first undeciphered digit
    [ ; main deciphering loop
     - ; decrease the number by 1
     <[<++++++++++>-]<[>+<-] ; multiply previous sum by ten
     >> ; back to the current digit
     [<+>-] ; add it to the sum
     >[[<+>-]>] ; shift the whole number to be one chunk again
     <<[<]>> ; to the next digit
    ]
    <[<<<+>>>-] ; back to the sum and copy it to the destination
    <<<<- ; to line number and decrease it
    [
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
     > ; copy start number one line back
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
     < ; move one line back and decrease line number
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<<
     <<<<< <<<<< <<<<< <<<<< <<-
    ] ; repeat until line number is zero
    ;; we should be at the first line now
    +>- ; restore line number and decrease start number
    [ ; move forward to start line
     ;; copy start line number
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
     < ; copy line number
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
     ;; move one line forward
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>>
     >>>>> >>>>> >>>>> >>>>> >>
     +>- ; increase line number and decrease start number
    ] ; we should return when at the destination line
    ;; we're at start line cell now
    ;; 40: move to the line and print it
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>[.>]+++++ +++++.[-]
    ;; 37: back to the command flag
    <[<]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]
   ]
   >
  ]
  <
  [ ; case minus:
   <<<- ; move to line number and decrease it
   [
    >>>[-]<<< ; kill command flag
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
    ;; 41: move to the line and print it
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>[.>]+++++ +++++.[-]
    ;; 40: back to empty line number and empty command flag
    <[<]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]<<<
   ]
   <[>+<-]> ; possibly restore line number
   >>>
   [ ; if command flag is there (no movement happened)
    <<<+>>> ; restore line number
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
 [ ; case '\n':
  ;; 37: move to the beginning of line and set presence flag
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+>
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
  ;; 37: back to the command flag and kill it
  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]
 ]
 <<< ; back to line number
] ; main loop
