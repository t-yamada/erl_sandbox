-module(np).
-compile(export_all).

printnumber(N) -> io:format(createformat(N),createlist(N)).

createformat(0) -> "~n";
createformat(N) -> "~p"++createformat(N-1).

createlist(N) -> create(N).

reverse_create(1) -> [1];
reverse_create(N) -> [N | reverse_create(N-1)].

create(N) -> lists:reverse(reverse_create(N)).
