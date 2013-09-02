nQueens([]).

nQueens([X-Y|Tail]) :-
	nQueens(Tail),
	member(Y,[1,2,3,4,5,6,7,8]),
	noConflict(X-Y,Tail).

member(Head,[Head|_]).
member(Head,[_|Tail]) :- member(Head,Tail).

noConflict(_,[]).
noConflict(X-Y,[X1-Y1|Tail]) :-
	Y =\= Y1,
	Y-Y1 =\= X-X1,
	X+Y =\= X1+Y1,
	noConflict(X-Y,Tail).

/*
	query : NQueens([1-Y1,2-Y2,3-Y3,4-Y4,5-Y5,6-Y6,7-Y7,8-Y8]).
*/
