-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1,list/0,force_stop/0]).
-export([init/0]).

start() ->
  register(frequency,spawn(frequency,init,[])).

init() ->
  Frequencies = {get_frequencies(), []},
	loop(Frequencies).

get_frequencies() -> [10,11,12,13,14,15].

% client

stop()           -> call(stop).
force_stop()     -> call(force_stop).
allocate()       -> call(allocate).
deallocate(Freq) -> call({deallocate,Freq}).
list()           -> call(list).

call(Message) ->
  frequency ! {request, self(), Message},
	receive
	  {reply, Reply} -> Reply
	end.

loop(Frequencies) ->
  receive
	  {request, Pid, allocate} ->
		  {NewFrequencies,Reply} = allocate(Frequencies, Pid),
			reply(Pid,Reply),
			loop(NewFrequencies);
		{request, Pid, {deallocate,Freq}} ->
		  {NewFrequencies,Reply} = deallocate(Frequencies, Freq, Pid),
			reply(Pid,Reply),
			loop(NewFrequencies);
		{request, Pid, list} ->
		  reply(Pid,Frequencies),
			loop(Frequencies);
		{request, Pid, stop} ->
		  {_Free,Alloc} = Frequencies,
			case Alloc of
			  [] ->
				  reply(Pid,ok);
				_Other ->
				  reply(Pid,{error,allocated_is_not_empty}),
          loop(Frequencies)
			end;
		{request, Pid, force_stop} ->
		  reply(Pid,ok)
	end.

reply(Pid, Reply) ->
  Pid ! {reply, Reply}.

% Internal Help Function

allocate({[],Allocated},_Pid) ->
  {{[],Allocated}, {error, no_frequency}};
allocate({[Freq|Free], Allocated},Pid) ->
  io:format("~w~n",[pidfind(Pid,Allocated)]),
  case pidfind(Pid,Allocated) of
	  0 -> {{Free,[{Freq, Pid}|Allocated]}, {ok, Freq}};
	  1 -> {{Free,[{Freq, Pid}|Allocated]}, {ok, Freq}};
	  2 -> {{Free,[{Freq, Pid}|Allocated]}, {ok, Freq}};
	  _Other -> {{[Freq|Free], Allocated}, {error, pid_limit_3}}
	end.

pidfind(Pid,Allocated) -> pidfind_acc(Pid,Allocated,0).

pidfind_acc(_Pid,[],Count) -> Count;
pidfind_acc(Pid,[{_Key,Pid}|T],Count) ->
  pidfind_acc(Pid,T,Count+1);
pidfind_acc(Pid,[_|T],Count) ->
  pidfind_acc(Pid,T,Count).

deallocate({Free,Allocated},Freq,Pid) ->
  case lists:keyfind(Freq,1,Allocated) of
	{Freq,Pid} ->
    NewAllocated=lists:keydelete(Freq,1,Allocated),
	  {{[Freq|Free],NewAllocated} , {ok,Freq}};
	{Freq,_} ->
	  {{Free,Allocated} , {error,pid_not_found}};
	false ->
	  {{Free,Allocated} , {error,freq_not_found}}
  end.
