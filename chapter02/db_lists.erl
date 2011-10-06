-module(db_lists).
-compile(export_all).

new() -> [].

destroy(_Db) -> ok.

write(Key,Value,Db) -> lists:append([{Key,Value}],Db).

read(_Key,[]) -> {error,instance);
read(Key,Db) -> lists:foreach(fun(T)
