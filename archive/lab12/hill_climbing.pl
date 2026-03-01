%%% Demo Hill Climbing

% cost(+State, ?Cost).
cost(coords(X, Y), Cost) :- Cost is 4 - (X - 4) * (X - 4) - (Y - 2) * (Y - 2).

% get_neighbours(+State, -Neighbours).
get_neighbours(coords(X, Y), [coords(X1, Y1), coords(X2, Y2), coords(X3, Y3), coords(X4, Y4)]) :-
    X1 is X - 1, Y1 is Y,
    X2 is X + 1, Y2 is Y,
    X3 is X, Y3 is Y - 1,
    X4 is X, Y4 is Y + 1.

% initial_state(?InitialState).
initial_state(InitialState) :- InitialState = coords(-10, 0).

% hill_climbing(+State, -Path).
hill_climbing(State, Path) :- get_neighbours(State, Neighbours), cost(State, Cost),
                                findall(Candidate, (member(Candidate, Neighbours), cost(Candidate, CandidateCost), CandidateCost > Cost,
                                    forall(member(S, Neighbours), (cost(S, CostS), CostS =< CandidateCost))), Results),
                                ((Results == [], !, Path = [State]);
                                ([Next|_] = Results, hill_climbing(Next, Rest), Path = [State|Rest])).
                              
run() :- initial_state(InitialState), hill_climbing(InitialState, Path), writeln(Path).                        