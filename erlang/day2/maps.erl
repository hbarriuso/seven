-module(maps).
-export([get/2]).

get(List, Key) -> [V || {K, V} <- List, K == Key]. 
