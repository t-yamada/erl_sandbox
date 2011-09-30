-module(lst).
-compile(export_all).

filter(Array,Target) -> filter_acc(Array,Target,[]).

filter_acc([],_Target,Result) -> Result;
filter_acc([H|T],Target,Result) when H =< Target -> filter_acc(T,Target,Result++[H]);
filter_acc([_H|T],Target,Result) -> filter_acc(T,Target,Result).

reverse(Array) -> reverse_acc(Array,[]).

reverse_acc([],Result) -> Result;
reverse_acc([H|T],Result) -> reverse_acc(T,[H]++Result).

concatenate(Lst) -> c_acc(Lst,[]).

c_acc([],Result) -> Result;
c_acc([H|T],Result) -> c_acc(T,Result++c_acc_acc(H)).

c_acc_acc([]) -> [];
c_acc_acc([H|T]) -> [H]++c_acc_acc(T).

flatten(Lst) -> f_acc(Lst,[]).


f_acc([],Result) -> Result;
f_acc([H|T],Result) -> f_acc(T,Result++f_acc(H,[]));
f_acc(H,[]) -> [H].
