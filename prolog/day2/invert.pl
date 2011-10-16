invert([], []).

invert(Result, [Head|Tail]) :- invert(List, Tail), append(List, [Head], Result).
