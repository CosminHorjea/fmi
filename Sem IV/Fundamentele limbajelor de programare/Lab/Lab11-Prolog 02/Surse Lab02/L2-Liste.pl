% Lists

member_of(X,[X|_]).
member_of(X,[_|Tail]) :- member_of(X,Tail).

concat_lists([], List, List).
concat_lists([Elem | List1], List2, [Elem | List3]) :-
		concat_lists(List1, List2, List3).

/** <examples>
 
?- member_of(a,[a,b,c]).
?- member_of(X,[a,b,c]).
?- concat_lists([1, 2, 3], [d, e, f, g], X).
?- concat_lists(X, Y, [a, b, c, d]).

*/
