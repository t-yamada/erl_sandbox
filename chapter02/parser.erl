-module(parser).
-compile(export_all).

eval({num,Number}) -> Number;
eval({plus,Exp1,Exp2}) -> eval(Exp1) + eval(Exp2);
eval({minus,Exp1,Exp2}) -> eval(Exp1) - eval(Exp2).

shape({num,Number}) -> integer_to_list(Number);
shape({plus,Exp1,Exp2}) -> "(" ++ shape(Exp1) ++ "+" ++ shape(Exp2) ++ ")";
shape({minus,Exp1,Exp2}) -> "(" ++ shape(Exp1) ++ "-" ++ shape(Exp2) ++ ")".
