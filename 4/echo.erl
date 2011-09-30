-module(echo).
-export([start/0, stop/0, print/1,output/0]).

start() ->
  register(echo, spawn(echo, output,[])),
	ok.

stop() ->
  echo ! stop,
	ok.

print(Msg) ->
  echo ! {output,Msg},
	ok.
	
output() ->
  receive
	  {output,Msg} ->
		  io:format("~w~n",[Msg]),
			output();
		stop ->
		  true
	end.
