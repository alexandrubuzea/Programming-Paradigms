/*
    TODO: live demo

    1. Unification/binding (reminder from previous lab)
    2. Scope vs goal
    3. Negation (\+)
    4. Why Prolog actually is not first order logic (X == Y, X = Y. vs X = Y, X == Y.)
    5. How to use logic to generate solutions (ex. member, append)
    6. Control: fail, !.
    7. Higher-order predicates: findall(+Template, +Goal, -Bag).
                                forall(+Cond, +Action)
    Practical demo: how to determine maximum value in a list (do not use recursion)

    8. BONUS: How to think Prolog programs as nondeterministic (ex. partition)
    9. BONUS: How does Prolog "compute" (goal stack, substitution)?
*/

sumList([], 0).
sumList([H|T], Sum) :- sumList(T, Prev), Sum is Prev + H.

partition(L) :- helper(L, [], []).

helper([], L1, L2) :- sumList(L1, S1), sumList(L2, S2), S1 =:= S2, write(L1), write(L2).
helper([H|T], L1, L2) :- helper(T, [H|L1], L2), !; helper(T, L1, [H|L2]).

nod(a).
nod(b).
nod(c).
nod(d).
nod(e).
nod(f).
nod(g).

arc(a/b). % arc(a, b).
arc(b/c).
arc(a/c).
arc(a/g).
arc(g/c).
arc(a/d).
arc(d/e).
arc(a/e).
arc(c/e).
arc(e/f).

edge(X/Y) :- arc(X/Y) ; arc(Y/X).

color(c1).
color(c2).
color(c3).

run_coloring(Solution) :- coloring([], Acc), !, Solution = Acc.

coloring(Solution, Acc) :- forall(nod(Node), member(Node/_, Solution)), !, Acc = Solution.

coloring(Solution, Acc) :- nod(Node), \+ member(Node/_, Solution), !, color(Color),
                        forall(edge(Node/Neighbour), 
                            (member(Neighbour/NeighCol, Solution), NeighCol \= Color)
                            ;
                            (\+ member(Neighbour/_, Solution))
                        ), coloring([Node/Color|Solution], Acc).

% maxList(+L, ?Max)
maxList(L, Max) :- findall(X, (member(X, L), forall(member(Y, L), Y =< X)), [Max|_]).