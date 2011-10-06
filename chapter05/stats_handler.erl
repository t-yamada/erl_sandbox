-module(stats_handler).
-export([init/1, terminate/1, handle_event/2]).

% [{Type, Description, Count}, { }, ...]

init(Stat) -> Stat.

terminate(Stat) -> {stat, Stat}.

handle_event({Type, _Id, Description}, Stat) ->
  statupdate({Type, Description}, Stat).

statupdate({Type, Description}, Stat) ->
  statupdate_acc({Type, Description}, Stat, []).

statupdate_acc({Type, Description},[],[]) -> [{Type, Description, 1}];
statupdate_acc({Type, Description},[],NewStat) -> NewStat++[{Type, Description, 1}];
statupdate_acc({Type, Description},[{Type, Description, Count}|T], NewStat) ->
  NewStat++[{Type, Description, Count+1}]++T;
statupdate_acc({Type, Description},[{_Type, _Description, Count}|T], NewStat) ->
  statupdate_acc({Type, Description},T,NewStat++[{_Type, _Description, Count}]).
