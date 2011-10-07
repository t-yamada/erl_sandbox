-module(mutex_v1).
-export([start/0, stop/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() ->
  register(mutex, spawn(?MODULE, init, [])).

stop() ->
  mutex ! stop.

wait() ->
  mutex ! {wait, self()},
	exit(hogehoge),
  receive ok -> ok end.

signal() ->
  mutex ! {signal, self()}, ok.

init() ->
  free().

free() ->
  receive
    {wait, Pid} ->
		  sleep(5000),
		  % waitを送信したプロセスとlinkさせておく
		  try_link(Pid),
			Pid ! ok,
      busy(Pid);
    stop ->
      terminate()
  end.

sleep(Time) ->
	io:fwrite("sleep start~n",[]),
	timer:sleep(Time),
	io:fwrite("sleep end~n",[]).

try_link(Pid) ->
  try link(Pid) of
	  _ -> ok
	catch
	  exit:Reason ->
		  io:fwrite("exit:~w~n",[Reason]),
			{exit, Reason};
		error:Error ->
		  io:fwrite("error:~w~n",[Error]),
			{error, Error};
		Other:Others -> {Other, Others}
	end.

busy(Pid) ->
  receive
    {signal, Pid} ->
		  % waitを送信したプロセスとのリンクを解消する
			unlink(Pid),
      free()
  end.

terminate() ->
  receive
    {wait, Pid} ->
      exit(Pid, kill),
      terminate()
  after
    0 -> ok
  end.
  
