% this Prolog program is a solver for the 8-puzzle problem

% valid_state(+State)
valid_state(X) :- sort(X, [1, 2, 3, 4, 5, 6, 7, 8, e]).

% final(?State)
final_state([1, 2, 3, 4, 5, 6, 7, 8, e]).

% how can we express the move rules in a game ? Hardcode them !

% for X1
neighbour([e, X2, X3, X4, X5, X6, X7, X8, X9], [X4, X2, X3, e, X5, X6, X7, X8, X9]).
neighbour([e, X2, X3, X4, X5, X6, X7, X8, X9], [X2, e, X3, X4, X5, X6, X7, X8, X9]).

% for X2
neighbour([X1, e, X3, X4, X5, X6, X7, X8, X9], [e, X1, X3, X4, X5, X6, X7, X8, X9]).
neighbour([X1, e, X3, X4, X5, X6, X7, X8, X9], [X1, X3, e, X4, X5, X6, X7, X8, X9]).
neighbour([X1, e, X3, X4, X5, X6, X7, X8, X9], [X1, X5, X3, X4, e, X6, X7, X8, X9]).

% for X3
neighbour([X1, X2, e, X4, X5, X6, X7, X8, X9], [X1, e, X2, X4, X5, X6, X7, X8, X9]).
neighbour([X1, X2, e, X4, X5, X6, X7, X8, X9], [X1, X2, X6, X4, X5, e, X7, X8, X9]).

% for X4
neighbour([X1, X2, X3, e, X5, X6, X7, X8, X9], [e, X2, X3, X1, X5, X6, X7, X8, X9]).
neighbour([X1, X2, X3, e, X5, X6, X7, X8, X9], [X1, X2, X3, X5, e, X6, X7, X8, X9]).
neighbour([X1, X2, X3, e, X5, X6, X7, X8, X9], [X1, X2, X3, X7, X5, X6, e, X8, X9]).

% for X5
neighbour([X1, X2, X3, X4, e, X6, X7, X8, X9], [X1, e, X3, X4, X2, X6, X7, X8, X9]).
neighbour([X1, X2, X3, X4, e, X6, X7, X8, X9], [X1, X2, X3, e, X4, X6, X7, X8, X9]).
neighbour([X1, X2, X3, X4, e, X6, X7, X8, X9], [X1, X2, X3, X4, X6, e, X7, X8, X9]).
neighbour([X1, X2, X3, X4, e, X6, X7, X8, X9], [X1, X2, X3, X4, X8, X6, X7, e, X9]).

% for X6
neighbour([X1, X2, X3, X4, X5, e, X7, X8, X9], [X1, X2, e, X4, X5, X3, X7, X8, X9]).
neighbour([X1, X2, X3, X4, X5, e, X7, X8, X9], [X1, X2, X3, X4, e, X5, X7, X8, X9]).
neighbour([X1, X2, X3, X4, X5, e, X7, X8, X9], [X1, X2, X3, X4, X5, X9, X7, X8, e]).

% for X7
neighbour([X1, X2, X3, X4, X5, X6, e, X8, X9], [X1, X2, X3, e, X5, X6, X4, X8, X9]).
neighbour([X1, X2, X3, X4, X5, X6, e, X8, X9], [X1, X2, X3, X4, X5, X6, X8, e, X9]).

% for X8
neighbour([X1, X2, X3, X4, X5, X6, X7, e, X9], [X1, X2, X3, X4, X5, X6, e, X7, X9]).
neighbour([X1, X2, X3, X4, X5, X6, X7, e, X9], [X1, X2, X3, X4, X5, X6, X7, X9, e]).
neighbour([X1, X2, X3, X4, X5, X6, X7, e, X9], [X1, X2, X3, X4, e, X6, X7, X5, X9]).

% for X9
neighbour([X1, X2, X3, X4, X5, X6, X7, X8, e], [X1, X2, X3, X4, X5, X6, X7, e, X8]).
neighbour([X1, X2, X3, X4, X5, X6, X7, X8, e], [X1, X2, X3, X4, X5, e, X7, X8, X6]).

% prerequisites - an example of an initial state
% initial_state([6, 4, 7, 8, 5, 2, 1, 3, e]).
initial_state([8, 5, 2, 7, 1, 4, 6, 3, e]).

position_value(Index, Row, Column) :- Row is div(Index, 3), Column is mod(Index, 3).

manhattan(Row1, Col1, Row2, Col2, Value) :- DR is abs(Row2 - Row1), DC is abs(Col2 - Col1),
                                            Value is DR + DC.

sumList([], 0).
sumList([H|T], Sum) :- sumList(T, Prev), Sum is Prev + H.

heuristic(State, Value) :- final_state(Final), findall(Cost,
                            (
                                member(F, Final),
                                nth0(FIndex, Final, F),
                                nth0(Index, State, F),
                                position_value(FIndex, Row1, Col1),
                                position_value(Index, Row2, Col2),
                                manhattan(Row1, Col1, Row2, Col2, Cost)
                            )
                            , Costs), sumList(Costs, Value).

% run the A* algorithm with the initial state

astar(Path) :- initial_state(State),
           heuristic(State, H),
           astar_search([State/H], [State/none/0], States),
           final_state(Final),
           get_path(State, Final, States, Path),
           !,
           write(Path).

astar_search([], _, _) :- !, fail.

astar_search(PQ, Discovered, States) :- extract_state(PQ, Next, _), final_state(Next), !, States = Discovered.

astar_search(PQ, Discovered, States) :-
        extract_state(PQ, Next, Visited),
        expand_state(Next, Neighbours),
        member(Next/_/Distance, Discovered),
        update_discovered(Neighbours, Visited, Discovered, Next, Distance, NewVisited, NewDiscovered),
        % write(NewVisited),
        astar_search(NewVisited, NewDiscovered, States).

% extract_state(+PQ, -Next, -Visited).
extract_state(PQ, Next, Visited) :- findall(Candidate,
                                        (member(Candidate/Heuristic, PQ),
                                        forall(member(_/OtherHeuristic, PQ), Heuristic =< OtherHeuristic)),
                                        [Next|_]
                                    ),
                                    findall(Pair, (member(Pair, PQ), Pair \= Next/_), Visited).


update_discovered([], Visited, Discovered, _, _, Visited, Discovered) :- !.
update_discovered([N|Ns], Visited, Discovered, Parent, Distance, NewVisited, NewDiscovered)
    :- (\+ member(N/_/_, Discovered), !, heuristic(N, H), NewDistance is Distance + 1,
                Value is NewDistance + H,
            update_discovered(Ns, [N/Value|Visited], [N/Parent/NewDistance|Discovered], Parent, Distance, NewVisited, NewDiscovered))
        ;
        (
            member(N/_/OldDistance, Discovered), NewDistance is Distance + 1,
            (
                OldDistance > NewDistance, !, nth0(_, Discovered, N/_/_, Rest),
                heuristic(N, H), Value is NewDistance + H,
                update_discovered(Ns, [N/Value|Visited], [N/Parent/NewDistance|Rest],
                        Parent, Distance, NewVisited, NewDiscovered)
            );
            (
                update_discovered(Ns, Visited, Discovered, Parent, Distance, NewVisited, NewDiscovered)
            )
        ).

expand_state(State, Neighbours) :- findall(Nei, neighbour(State, Nei), Neighbours).

get_path(State, State, _, [State]) :- !.
get_path(State, Final, Discovered, Path) :- member(Final/Parent/_, Discovered),
                                            get_path(State, Parent, Discovered, Rest),
                                            append(Rest, [Final], Path).