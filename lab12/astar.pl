% this Prolog program is a solver for the 8-puzzle problem

% valid_state(+State)
valid_state(X) :- sort(X, [1, 2, 3, 4, 5, 6, 7, 8, e])

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
initial_state([6, 4, 7, 8, 5, 2, 1, 3, e]).

position_value(Value, Row, Column) :- Row is Value / 3, Col is Value mod 3.

heuristic(State, Value) :- State = [X1, X2, X3, X4, X5, X6, X7, X8, X9],

% run the A* algorithm with the initial state

astar() :- initial_state(State),
           astar_search([State], [])