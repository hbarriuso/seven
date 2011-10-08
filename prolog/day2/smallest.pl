smallest(Head, [Head|[]]).

smallest(Min, [Head|Tail]) :- smallest(TailMin, Tail), Min is min(TailMin, Head).
