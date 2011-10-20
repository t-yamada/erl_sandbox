-module(my_db).
-import(db,[new/1,destroy/1,write/3,delete/2,read/2,match/2]).
-export([start/0, stop/0, write/2, delete/1, read/1, match/1,loop/1,list/0]).

start() ->
  register(db, spawn(my_db, loop,[[]])),
  ok.

stop() ->
  db ! stop,
  ok.

loop(Db) ->
  receive
    stop ->
      true;
    {list,Pid} ->
      Pid ! Db,
      loop(Db);
    {write,Key,Element} ->
      Db2 = write(Key,Element,Db),
      loop(Db2);
    {read,Key,Pid} ->
      Pid ! read(Key,Db),
      loop(Db);
    {delete,Key} ->
      Db2 = delete(Key,Db),
      loop(Db2);
    {match,Element,Pid} ->
      Pid ! match(Element,Db),
      loop(Db);
    _Other ->
      loop(Db)
  end.

write(Key, Element) ->
  db ! {write,Key,Element},
  ok.

delete(Key) ->
  db ! {delete,Key},
  ok.

read(Key) ->
  db ! {read,Key,self()},
  receive
    Elenemt -> {ok,Elenemt}
  end.

list() ->
  db ! {list,self()},
  receive
    Lst -> {ok,Lst}
  end.

match(Element) ->
  db ! {match,Element,self()},
  receive
    Key -> Key
  end.
