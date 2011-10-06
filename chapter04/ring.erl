-module(ring).
-export([start/3]).

start(M,N,Message) ->
  Pid = spawn(ring,nd,[N]),
	send_message(Pid,M,Message),
	send_message(Pid,1,stop).

send_message(Pid,M,Message) ->
  Pid ! {transfer,Message
	
nd(N) ->
  
