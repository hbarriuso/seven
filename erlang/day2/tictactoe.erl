-module(tictactoe).
-export([check/1]).

check(Board) ->
  RowChecker = fun(X) -> fun(Y) -> X == Y end end,
  Rows = [lists:sublist(Board, 3),
          lists:sublist(Board, 4, 3),
          lists:sublist(Board, 7, 3),
          [lists:nth(1, Board), lists:nth(4, Board), lists:nth(7, Board)],
          [lists:nth(2, Board), lists:nth(5, Board), lists:nth(8, Board)],
          [lists:nth(3, Board), lists:nth(6, Board), lists:nth(9, Board)],
          [lists:nth(1, Board), lists:nth(5, Board), lists:nth(9, Board)],
          [lists:nth(3, Board), lists:nth(5, Board), lists:nth(7, Board)]
          ],
  X_wins = lists:any(fun(R) -> lists:all(RowChecker(x), R) end, Rows),
  O_wins = lists:any(fun(R) -> lists:all(RowChecker(o), R) end, Rows),
  Cat = lists:all(fun(E) -> (E == o) or (E == x) end, Board),
  if
    X_wins -> x;
    O_wins -> o;
    Cat -> cat;
    true -> no_winner
  end.
