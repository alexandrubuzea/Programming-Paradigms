% maximum(+L, ?Max)
maximum(L, Max) :- findall(M, (member(M, L), forall(member(Y, L), Y =< M)), [Max|_]).