-module(lislen).
-compile(export_all).

lgth([]) ->0;
lgth([_|Xs]) -> 1 + lgth(Xs).
