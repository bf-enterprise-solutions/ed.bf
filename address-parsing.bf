[ address-parsing.bf -- The experimental address/command parsing code for bfed.
 Approximate layout in the course of parsing ("f:" means it's a state flag):
 [line number][sign flag][f: 1st addr][f: 2nd addr][f: command][working space...]

 After parsing it becomes a usual bfed layout
 [line number][start line][end line][0][command][command args...]

 Code starts here:]

>+++++ ++++++ ; line number / exit flag (set to 10 for exemplarity)
[ ; main loop
 > ; sign flag
 > ; first address flag
 > ; second address flag
 > ; command flag
 >+ ; case flag
 > ; working space
 , ; read the first char
 [ ; '\n' (10)
  ----- -----
  [ ; ' ' (32)
   ----- -----
   ----- ----- --
   [ ; hash (35)
    ---
    [ ; dollar sign (36)
     -
     [ ; percent sign (37)
      -
      [ ; plus sign (43)
       ----- -
       [ ; comma (44)
        -
        [ ; minus sign (45)
         -
         [ ; dot (46)
          -
          [ ; '0' (48)
           --
           ;1 2 3 4 5 6 7 8 9 (49 to 57 respectively)
           [-[-[-[-[-[-[-[-[-
                    [ ; ';' (59)
                     --
                     ;; TODO: Maybe have '^'? GNU ed doesn't use it AFAIU
                     [ ;; default case
                      ;; Restore the original char (plus 59)
                      +++++ +++++ +++++ +++++ +++++ +++++
                      +++++ +++++ +++++ +++++ +++++ ++++
                      [<<+>>-] ;; set command flag to the char value
                      <[-]> ; empty the case flag and get back to empty char
                     ]
                     <
                     [ ; case ';'
                      [-]<<+ ; set second address flag
                      <<<[<+>>+<-]<[>+<-]> ; copy line number to start address
                      >>>>>
                     ]
                     >
                    ]
                    <[[->+<]>+<]>[<+>-]] ; case '9': increase case flag FALLTHROUGH
                   <[[->+<]>+<]>[<+>-]] ; case '8': increase case flag FALLTHROUGH
                  <[[->+<]>+<]>[<+>-]] ; case '7': increase case flag FALLTHROUGH
                 <[[->+<]>+<]>[<+>-]] ; case '6': increase case flag FALLTHROUGH
                <[[->+<]>+<]>[<+>-]] ; case '5': increase case flag FALLTHROUGH
               <[[->+<]>+<]>[<+>-]] ; case '4': increase case flag FALLTHROUGH
              <[[->+<]>+<]>[<+>-]] ; case '3': increase case flag FALLTHROUGH
             <[[->+<]>+<]>[<+>-]] ; case '2': increase case flag FALLTHROUGH
            <[[->+<]>+<]>[<+>-]] ; case '1': increase case flag FALLTHROUGH
           <
           [ ; case '0' to '9': case flag is the number read plus one
            -[<<<<<+>>>>>-] ; copy case flag to start address
            <<<+>>> ; set first address flag and exit
           ]
           >
          ]
          <
          [ ; case dot:
           [-]<<<+ ; set first address flag
           <<[<+>>+<-]<[>+<-]> ; copy line number to start address
           >>>>> ; back to empty case flag and exit
          ]
          >
         ]
         <
         [ ; case minus:
          [-] ; empty the case flag
          <<<+ ; set first address flag
          <++ ; set the sign flag to 2 for subtraction
          >>>> ; back to case flag and exit
         ]
         >
        ]
        <
        [ ; case comma:
         [-]<<+ ; second address parsing
         <<[-]+ ; set start address to 1
         >>>>
        ]
        >
       ]
       <
       [ ; case plus:
        [-] ; empty the case flag
        <<<+ ; set first address flag
        <+ ; set the sign flag to 1 for addition
        >>>> ; back to case flag and exit
       ]
       >
      ]
      <
      [ ; case percent sign:
       [-] ; clear case flag
       <+ ; set command flag as there can be no second address
       <<[-]- ; set end line to the maximum cell size (FIXME)
       <[-]+ ; set start line to 1
       >>>> ; back to case flag
      ]
      >
     ]
     <
     [ ; case dollar sign:
      [-]
      <+ ; set command flag as there can be no second address
      <<[-]- ; set start line to the maximum cell size (FIXME)
      >>>
     ]
     >
    ]
    ;; case hash: consume everything until a newline
    <[[-],----------[,----------]]>
   ]
   <
   [ ; case ' ':
    [-] ; empty the case flag
    <<<+ ; set first address flag
    <+ ; set the sign flag to 1 for addition
    >>>> ; back to case flag and exit
   ]
   >
  ]
  ;; case '\n':
  <[[-]]>
 ]
 <[-]+ ; reset case flag
 <<<+ ; set first address flag
 [ ; first address parsing
  >>>>, ;; read a char
  [ ; '\n' (10)
   ----- -----
   [ ; hash (35)
    ----- -----
    ----- -----
    -----
    [ ; comma (44)
     ----- ----
     [ ; '0' (48)
      ----
      ;1 2 3 4 5 6 7 8 9 (49 to 57 respectively)
      [-[-[-[-[-[-[-[-[-
               [ ; ';' (59)
                --
                [ ;; default case
                 ;; restore the original char (plus 59)
                 +++++ +++++ +++++ +++++ +++++ +++++
                 +++++ +++++ +++++ +++++ +++++ ++++
                 [<<+>>-] ;; set command flag to the char value
                 <[-]> ; empty the case flag and get back to empty char
                ]
                ;; case ';': set second address flag
                <[[-]<<+>>]>
               ]
               <[[->+<]>+<]>[<+>-]] ; case '9': increase case flag FALLTHROUGH
              <[[->+<]>+<]>[<+>-]] ; case '8': increase case flag FALLTHROUGH
             <[[->+<]>+<]>[<+>-]] ; case '7': increase case flag FALLTHROUGH
            <[[->+<]>+<]>[<+>-]] ; case '6': increase case flag FALLTHROUGH
           <[[->+<]>+<]>[<+>-]] ; case '5': increase case flag FALLTHROUGH
          <[[->+<]>+<]>[<+>-]] ; case '4': increase case flag FALLTHROUGH
         <[[->+<]>+<]>[<+>-]] ; case '3': increase case flag FALLTHROUGH
        <[[->+<]>+<]>[<+>-]] ; case '2': increase case flag FALLTHROUGH
       <[[->+<]>+<]>[<+>-]] ; case '1': increase case flag FALLTHROUGH
      <
      [ ; case '0' to '9': case flag is the number read plus one
       -<<<<<[>>>>> +++++ +++++ <<<<< -] ; move x10 of accumulator to case flag
       >>>>>[<<<<<+>>>>>-] ; copy case flag to start address
      ]
      >
     ]
     ;; case comma: parse second address
     <[[-]<<+<[-]>>>]>
    ]
    ;; case hash: stop parsing and consume until newline
    <[[-]<<<[-]>>>,----------[,----------]]>
   ]
   ;; case '\n': stop parsing
   <[[-]<<<[-]>>>]>
  ]
  ;; back to the first address flag and exit if it is cleared
  <<<<
 ]
 ;; TODO: substract or add things using sign flag
 <[-]+ ; reset case flag
 >+ ; set second address flag
 [ ;; second address parsing
  >>+>, ; read a char and set case flag
  [ ; '\n' (10)
   ----- -----
   [ ; hash (35)
    ----- -----
    ----- -----
    -----
    [ ; dot (46)
     ----- ----- -
     [ ; '0' (48)
      --
      ;1 2 3 4 5 6 7 8 9 (49 to 57 respectively)
      [-[-[-[-[-[-[-[-[-
               [ ; ';' (59)
                --
                [ ;; default case
                 ;; Restore the original char (plus 59)
                 +++++ +++++ +++++ +++++ +++++ +++++
                 +++++ +++++ +++++ +++++ +++++ ++++
                 [<<+>>-] ;; set command flag to the char value
                 <[-]> ; empty the case flag and get back to empty char
                ]
                ;; case ';': set second address flag
                <[[-]<<+>>]>
               ]
               <[[->+<]>+<]>[<+>-]] ; case '9': increase case flag FALLTHROUGH
              <[[->+<]>+<]>[<+>-]] ; case '8': increase case flag FALLTHROUGH
             <[[->+<]>+<]>[<+>-]] ; case '7': increase case flag FALLTHROUGH
            <[[->+<]>+<]>[<+>-]] ; case '6': increase case flag FALLTHROUGH
           <[[->+<]>+<]>[<+>-]] ; case '5': increase case flag FALLTHROUGH
          <[[->+<]>+<]>[<+>-]] ; case '4': increase case flag FALLTHROUGH
         <[[->+<]>+<]>[<+>-]] ; case '3': increase case flag FALLTHROUGH
        <[[->+<]>+<]>[<+>-]] ; case '2': increase case flag FALLTHROUGH
       <[[->+<]>+<]>[<+>-]] ; case '1': increase case flag FALLTHROUGH
      <
      [ ; case '0' to '9': case flag is the number read plus one
       -<<<<<[>>>>> +++++ +++++ <<<<< -] ; move x10 of accumulator to case flag
       >>>>>[<<<<<+>>>>>-] ; copy case flag to start address
      ]
      >
     ]
     <
     [ ; case dot:
      [-] ; empty the case flag
      <<<<<[<+>>+<-]<[>>+<<-]> ; copy line number to end address
      >>>>> ; back to empty case flag and exit
     ]
     >
    ]
    ;; case hash: stop parsing and consume until newline
    <[[-]<<<[-]>>>,----------[,----------]]>
   ]
   ;; case '\n': stop parsing
   <[[-]<<<[-]>>>]>
  ]
  ;; back to the second address flag and exit if it is cleared
  <<<
 ]
 ;; TODO: substract or add things using sign flag
 >+ ; set command flag
 [ ;; command parsing
  >+>, ; read a char and set case flag
  [ ; '\n' (10)
   ----- -----
   [ ; hash (35)
    ----- -----
    ----- -----
    -----
    [ ;; default case
     ;; restore the original char (plus 35)
     +++++ +++++ +++++ +++++ +++++ +++++ +++++
     ;; TODO: store the new command char elsewhere
    ]
    ;; case hash: stop parsing and consume until newline
    <[[-]<<<[-]>>>,----------[,----------]]>
   ]
   ;; case '\n': stop parsing
   <[[-]<<<[-]>>>]>
  ]
  <<
  ;; TODO
 ]
]
