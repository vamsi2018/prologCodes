/*
* deleteElementFromList(arg1,arg2,arg3,arg4)
* arg1 -> input, List from which element has to be deleted
* arg2 -> element to be deleted from arg1
* arg3 -> This acts as an accumulator while deleting th element
* arg4 -> This is the final output in which the list is present
*/
/*
* Main logic behind this rule is :-->
*	if(arg2 is the head of arg1) **this condition implies that the input list has the element to be deleted
*		then recursively call deleteElementFromList with input list as the tail of the previous input list rest being same
*	else
*		append the head of the input list to the arg3 and create a new List named TempList which is equal to arg3 appended with head of the input list and then recursively call deleteElementFromList with input list as the tail of the previous input list and arg3 being TempList rest being same
*/
deleteElementFromList([],_,TempList,TempList).
deleteElementFromList([H|T],ElementToBeDeleted,FinalList,FFinalList):-
	ElementToBeDeleted is H,
	deleteElementFromList(T,ElementToBeDeleted,FinalList,FFinalList).
deleteElementFromList([H|T],ElementToBeDeleted,FinalList,FFinalList):-
	append(FinalList,[H],TempList),
	deleteElementFromList(T,ElementToBeDeleted,TempList,FFinalList).

append([],SecondList,SecondList).
append([Head|TailOfFirstList],SecondList,[Head|TailOfFinalList]):-
	append(TailOfFirstList,SecondList,TailOfFinalList).

timeTableSchedule([[]]).
timeTableSchedule([]).
timeTableSchedule([HeadCluster|Tail]):-
	member(X,[1,2,3,4]),
	TempList=[],
	deleteElementFromList([1,2,3,4],X,TempList,DiffList),
	scheduleCollidingCluster(HeadCluster,X,DiffList),
	noConflict(HeadCluster),
	timeTableSchedule(Tail).

member(Head,[Head|_]).
member(Head,[_|Tail]) :- member(Head,Tail).
/*
* The functionality of noConflict method is to ensure that 
* there are no conflicts between course slots in the same colliding cluster.
* This method is not efficient as its complexity is O(n**2)
*/
noConflict([]).
noConflict([_-Slot|Tail]):-recursiveNoConflict(Slot,Tail),noConflict(Tail).
/*
This method is infact a helper method for noConflicts method
*/
recursiveNoConflict(_,[]).
recursiveNoConflict(Slot,[_-NewSlot|Tail]):-Slot =\= NewSlot , recursiveNoConflict(Slot,Tail).

/*
* This rule forms the crux of the program. 
* It takes care of scheduling slots for the courses which are in same colliding cluster
*/
scheduleCollidingCluster([],_,_).
scheduleCollidingCluster([_-Slot|TailCluster],N,List):-
	Slot is N,
	member(X,List),
	TempList=[],
	deleteElementFromList(List,X,TempList,DiffList),
	scheduleCollidingCluster(TailCluster,X,DiffList).
