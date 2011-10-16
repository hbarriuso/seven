-module(func).
-export([echo/1]).

echo(success) -> io:fwrite("success~n");
echo({error, Message}) -> io:fwrite("error: ~s~n", [Message]).
