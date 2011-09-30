-module(lc).
-compile(export_all).

reverse_create(1) -> [1];
reverse_create(N) -> [N | reverse_create(N-1)].

create(N) -> lists:reverse(reverse_create(N)).


