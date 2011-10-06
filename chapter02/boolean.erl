-module(boolean).
-compile(export_all).

b_not(true) -> false;
b_not(false) -> true.

b_and(true,true) -> true;
b_and(_,_) -> false.

b_or(false,false) -> false;
b_or(_,_) -> true.

b_nand(A,B) ->
  b_and(b_not(A),b_not(B)).
