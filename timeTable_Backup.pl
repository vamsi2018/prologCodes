deleteElementFromList([],_,TempList,TempList).
deleteElementFromList([H|T],ElementToBeDeleted,FinalList,FFinalList):-
	ElementToBeDeleted is H,
	deleteElementFromList(T,ElementToBeDeleted,FinalList,FFinalList).
deleteElementFromList([H|T],ElementToBeDeleted,FinalList,FFinalList):-
	append(FinalList,[H],TempList),
/*	write('After Append -> '), write(TempList),nl,
*/
	deleteElementFromList(T,ElementToBeDeleted,TempList,FFinalList).

append([],SecondList,SecondList).
append([Head|TailOfFirstList],SecondList,[Head|TailOfFinalList]):-
	append(TailOfFirstList,SecondList,TailOfFinalList).

timeTableSchedule([[]]).
timeTableSchedule([]).
timeTableSchedule([HeadCluster|Tail]):-
	member(X,[1,2,3,4]),
	write('In timetable schedule, member identified as ->'),write($X),nl,
	TempList=[],
	write('Calling deleteElement From List'),nl,
	deleteElementFromList([1,2,3,4],X,TempList,DiffList),
	write('Difference List is -> '),write($DiffList),nl,
	scheduleCollidingCluster(HeadCluster,X,DiffList),
	timeTableSchedule(Tail).

member(Head,[Head|_]).
member(Head,[_|Tail]) :- member(Head,Tail).

scheduleCollidingCluster([],_,_).
scheduleCollidingCluster([_-Slot|TailCluster],N,List):-
	Slot is N,
	member(X,List),
	TempList=[],
	deleteElementFromList(List,X,TempList,DiffList),
/*	member(M,DiffList),
*/
	scheduleCollidingCluster(TailCluster,X,DiffList).
