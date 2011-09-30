-module(io_handler).
-export([init/1, terminate/1, handle_event/2]).

init(Count) -> Count.

terminate(Count) -> {count, Count}.

handle_event({raise_alerm, Id, Alerm}, Count) ->
  print(alerm, Id, Alerm, Count),
	Count+1;
handle_event({clear_alerm, Id, Alerm}, Count) ->
  print(clear, Id, Alerm, Count),
	Count+1;
handle_event(Event, Count) ->
  Count.

print(Type, Id, Alerm, Count) ->
  Date = fmt(date()), Time = fmt(time()),
	io:format("#~w,~s,~s,~w,~w,~p~n",
	         [Count, Date, Time, Type, Id, Alerm]).

fmt({AInt, BInt, CInt}) ->
  AStr = pad(integer_to_list(AInt)),
  BStr = pad(integer_to_list(BInt)),
  CStr = pad(integer_to_list(CInt)),
	[AStr,$:,BStr,$:,CStr].

pad([M1]) -> [$0,M1];
pad(Other) -> Other.
