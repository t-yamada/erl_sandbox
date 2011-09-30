-module(db).
-compile(export_all).

new() -> [].

destroy(_Db) -> ok.

write(Key,Value,[]) -> [{Key,Value}];
write(Key,Value,Db) -> [{Key,Value}] ++ Db.

read(_Key,[]) -> {error,instace};
read(Key,[H|_T]) when Key == element(1,H) -> element(2,H);
read(Key,[_H|T]) -> read(Key,T).

match(Value,Db) -> match_acc(Value,Db,[]).

match_acc(_Value,[],Result) -> Result;
match_acc(Value,[H|T],Result) when Value == element(2,H) -> match_acc(Value,T,Result ++ [element(1,H)]);
match_acc(Value,[_H|T],Result) -> match_acc(Value,T,Result).
