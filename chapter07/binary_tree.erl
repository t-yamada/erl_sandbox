-module(binary_tree).
-include("binary_tree.hrl").
-export([sum/1,max/1]).

sum(#node{left=Left,right=Right,parent=Parent,value=Value}) ->
  
