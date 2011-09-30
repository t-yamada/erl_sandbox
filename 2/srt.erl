-module(srt).
-compile(export_all).

qsrt([]) -> [];
qsrt(Array) -> divide(Array,[],[],[]).

divide([],Head,Big,Small) -> qsrt(Small) ++ [Head] ++ qsrt(Big);
divide([H|T],[],[],[]) -> divide(T,H,[],[]);
divide([H|T],Head,Big,Small) when H >= Head -> divide(T,Head,Big++[H],Small);
divide([H|T],Head,Big,Small) when H < Head -> divide(T,Head,Big,Small++[H]).
