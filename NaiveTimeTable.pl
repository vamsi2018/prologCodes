deleteElementFromList([],_,_).
deleteElementFromList([H|T],ElementToBeDeleted,FinalList):-
	ElementToBeDeleted is H,
	deleteElementFromList(T,ElementToBeDeleted,FinalList).
deleteElementFromList([H|T],ElementToBeDeleted,FinalList):-
	append(FinalList,[H],FinalList),
	deleteElementFromList(T,ElementToBeDeleted,FinalList).

append([],SecondList,SecondList).
append([Head|TailOfFirstList],SecondList,[Head|TailOfFinalList]):-
	append(TailOfFirstList,SecondList,TailOfFinalList).

timeTableSchedule([[]]).
timeTableSchedule([]).
timeTableSchedule([HeadCluster|Tail]):-
	member(X,[1,2,3,4]),
	DiffList=[],
	deleteElementFromList([1,2,3,4],X,DiffList),
	scheduleCollidingCluster(HeadCluster,X,DiffList),
	timeTableSchedule(Tail).

member(Head,[Head|_]).
member(Head,[_|Tail]) :- member(Head,Tail).

scheduleCollidingCluster([],_).
scheduleCollidingCluster([_-Slot|TailCluster],N,List):-
	member(N,List),
	Slot is N,
	DiffList=[],
	deleteElementFromList(List,N,DiffList),
	member(M,DiffList),
	scheduleCollidingCluster(TailCluster,M,DiffList).
