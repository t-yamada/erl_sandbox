-module(sum).
-compile(export_all).

sum(0) -> 0;
sum(N) -> N + sum(N-1).

sum(N,N) -> N;
sum(N,M) when N>M -> {error, invalid_object};
sum(N,M) -> N+sum(N+1,M).
