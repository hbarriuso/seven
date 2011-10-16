-module(count).
-export([count_to_ten/1]).

count_to_ten(10) -> io:fwrite("~B~n", [10]);
count_to_ten(N) -> io:fwrite("~B~n", [N]), count_to_ten(N+1).
