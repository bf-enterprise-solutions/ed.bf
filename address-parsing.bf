
>>> ; line number to command flag
>[-] ; first address parsing flag
>[-] ; second address parsing flag
>[-] ; command parsing flag
>+ ; first char switch flag
>, ; read the first char
[ ; switch
 ----- ----- ; '\n' (10)
 [ ; exclamation mark (33)
  ----- -----
  ----- -----
  ---
  [ -- ; hash (35)
   [ - ; dollar sign (36)
    [ - ; percent sign (37)
     [ -- ; apostrophe (39)
      [ - ; plus sign (43)
       [ - ; comma (44)
        [ ; TODO
        ]
        ;; TODO: set start address to 1 for comma
        <[>>[-],<<<<+>>]> ; case comma: get to the second address parsing
       ]
       <
       [ ; case plus: restore plus and get to first address parsing
        ;; 0 in the restore space is parse literally
        ;; 1 is parse relative plus
        ;; 2 is parse relative minus
        >>+
        <<<<<+>>>[-] ; set first address parsing flag
       ]
       >
      ]
      <
      [ ; case apostrophe: get to command parsing and restore apostrophe
       >>[-]
       ;; apostrophe
       +++++ +++++
       +++++ +++++
       +++++ +++++
       +++++ ++++
       <<<+>[-]
      ]
      >
     ] <[>>[-],<<<+>]> ; case percent sign: get to command parsing
    ] <[>>[-],<<<+>]> ; case dollar sign: get to command parsing
   ] <[-,----------[[-],----------]]> ; case hash: read until newline and exit
  ]
  <
  [; case exclamation mark: set command parsing flag and restore exclamation mark
   [-]>>[-]
   ;; exclamation mark
   +++++ +++++
   +++++ +++++
   +++++ +++++ +++
   <<+>
  ]
  >
 ] <[->>++++++++++<<]> ; case '\n': nullify the flag and restore '\n'
 [-] ; nullify current char and exit
]
<<<
[ ; first address parsing
]
>
[ ; second address parsing
]
>
[ ; command parsing
]
