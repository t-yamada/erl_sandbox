-module(ring).
-export([start/3, setup/3]).

start(M, N, Msg) ->
  io:format("~w Origin start~n", [self()]),
  Next = spawn(ring, setup, [self(), M, N-1]),
  receive
    {setup_complete, Last} -> 
      io:format("setup_complete by ~w ~n", [Last]),
      Next ! Msg,
      loop(Next, M)
  end.

setup(Origin, M, 0) ->
  io:format("~w Last process setup start~n", [self()]),
  Origin ! {setup_complete, self()},
  loop(Origin, M);
setup(Origin, M, N) ->
  io:format("~w process setup start~n", [self()]),
  Pid = spawn(ring, setup, [Origin, M, N-1]),
  loop(Pid, M).

loop(Next, 0) ->
  io:format("~w sending stop ~n", [self()]),
  Next ! stop,
  receive
    stop ->
      io:format("~w stop received ~n", [self()]),
      ok
  end;
loop(Next, M) ->
  io:format("~w loop for ~w ~n", [self(), M]),
  receive
    Msg ->
      io:format("~w~n", [Msg]),
      Next ! Msg,
      loop(Next, M-1)
  end.
