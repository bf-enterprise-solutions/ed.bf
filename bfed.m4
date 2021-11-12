define(`left', `ifelse($#, `0', ``$0'',`ifelse($1, `0', `', `<left(decr($1))')')')dnl
define(`right', `ifelse($#, `0', ``$0'', `ifelse($1, `0', `', `>right(decr($1))')')')dnl
define(`inc', `ifelse($#, `0', ``$0'', `ifelse($1, `0', `', `+inc(decr($1))')')')dnl
define(`dec', `ifelse($#, `0', ``$0'', `ifelse($1, `0', `', `-dec(decr($1))')')')dnl
define(`readln', `ifelse($#, `0', ``$0'', `,----------[>,----------]<[++++++++++<]>')')dnl
define(`printint', `ifelse($#, `0', ``$0'', `>[-]>[-]+>[-]+<[>[-<-<<[->+>+<<]>[-<+>]>>]++++++++++>[-]+>[-]>[-]>[-]<<<<<[->-[>+>>]>[[-<+>]+>+>>]<<<<<]>>-[-<<+>>]<[-]++++++++[-<++++++>]>>[-<<+>>]<<]<[.[-]<]')')dnl
define(`nextline', `ifelse($#, `0', ``$0'', `right(122)')')dnl
define(`prevline', `ifelse($#, `0', ``$0'', `left(122)')')dnl
define(`error', `ifelse($#, `0', ``$0'', `[-]inc(63).[-]inc(10).[-] ; error')')dnl
