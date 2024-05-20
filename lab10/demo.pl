/*
    TODO: Live demo

    1. What is Prolog && how to write code in Prolog
    2. What is computation in Prolog ?
    3. Facts and rules in Prolog (example: human, parent, grandparent)
    4. Goals and terms (aka symbols, constant symbols, datatypes: list and string in Prolog)
    5. Recursion in Prolog (example: length and append predicates)
    6. Predicate annotation (what do +, - and ? mean)
    7. Not in Prolog (\+)
    8. Arithmetic operators in Prolog (+, -, /, *), functions (mod)
    9. Unification (X + Y = 1 + 2)
    10. Equality (and not equality) in Prolog (=, ==, is, =:=, \=, \==, =\=)
*/

% om(x) = "x este om"
om(mihai). % Mihai este om
om(andrei).
om(alexandru).
om(ciprian).
om(mihnea).
om(andreea).

om(X) :- filosof(X).

filosof(george).

% filosof(X) :- ...

% pair(X, Y)

valid_pair(pair(X, Y)) :- X = 0, Y = 0.

% append(L1, L2, Result)

% custom_length(+List, ?Length)
custom_length([], 0).
custom_length([_|T], Len) :- custom_length(T, PrevLen), Len = PrevLen + 1.

% custom_length(L, Len) :- (L == [], Len = 0) ; (L = [_ | T], custom_length(T, Prev), Len is Prev + 1).

% state([x, 0, x, e, e, e, e, e, e], 0)
app([], L, L).
app([H|T], R, [H|M]) :- app(T, R, M).