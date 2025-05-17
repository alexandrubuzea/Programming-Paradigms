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

    ++ side detail: closed world assumption
*/

% om(x) = "x este om"
om(mihai). % Mihai este om
om(andrei).
om(alexandru).
om(ciprian).
om(mihnea).

om(andreea).
om(alina).

parent(andrei, mihai).
parent(ciprian, mihnea).
parent(mihai, ciprian).

grandparent(andreea, alina).

% parent(X, Y) ^ parent(Y, Z) -> grandparent(X, Z)
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

min(X, Y, Min) :- X > Y, Min = Y.
min(X, _, Min) :- Min = X. % wrong -> it should be min(X, _, Min) :- X <= Y, Min = X.

% len(L, Len)
len([], 0).
len([_|T], Len) :- len(T, PrevLen), Len is PrevLen + 1.

% exemplu de termen - "structura" din Prolog
is_pair(pair(_, _)).

