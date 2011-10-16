-module(figure).
-include("figure.hrl").
-export([round/1,area/1]).

round(#circle{radius=Radius}) ->
  Radius * 2 * 3.14;
round(#rectangle{length=L,width=W}) ->
  2 * L + 2 * W;
round(#triangle{l1=L1,l2=L2,l3=L3}) ->
  L1 + L2 + L3.

area(#circle{radius=Radius}) ->
  Radius * Radius * 3.14;
area(#rectangle{length=L,width=W}) ->
  L * W;
area(#triangle{l1=L1,l2=L2,l3=L3}) ->
  S = ( L1 + L2 + L3 ) / 2,
  math:sqrt( S * ( S - L1 ) * ( S - L2 ) * ( S - L3) ).
