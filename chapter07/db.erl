-module(db).
-compile(export_all).
-include("db.hrl").

new() -> [].

destroy(_Db) -> ok.

write(Key,Value,[]) -> [#data{key=Key,data=Value}];
write(Key,Value,Db) -> [#data{key=Key,data=Value}] ++ Db.

read(_Key,[]) -> {error,instace};
read(Key,[#data{key=Key,data=Value}|_T]) -> Value;
read(Key,[_H|T]) -> read(Key,T).

delete(Key,Db) -> delete_acc(Key,Db,[]).

delete_acc(_,[],Result) -> Result;
delete_acc(Key,[#data{key=Key}|T],Result) -> delete_acc(Key,T,Result);
delete_acc(Key,[H|T],Result) -> delete_acc(Key,T,Result ++ [H]).

match(Value,Db) -> match_acc(Value,Db,[]).

match_acc(_Value,[],Result) -> Result;
match_acc(Value,[#data{key=Key,data=Value}|T],Result) -> match_acc(Value,T,Result ++ [Key]);
match_acc(Value,[_H|T],Result) -> match_acc(Value,T,Result).
