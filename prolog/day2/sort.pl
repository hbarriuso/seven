smallest(Head, [Head|[]]).

smallest(Min, [Head|Tail]) :- smallest(TailMin, Tail), Min is min(TailMin, Head).

sort_list([], []).
sort_list([Head], [Head|[]]).
sort_list(Sorted, [Head|Tail]) :- smallest(MinTail, Tail), Head =< MinTail, sort_list(SortedTail, Tail), append([Head], SortedTail, Sorted).
sort_list(Sorted, [Head|Tail]) :- smallest(MinTail, Tail), Head > MinTail, append(Tail, [Head], List), sort_list(Sorted, List).
