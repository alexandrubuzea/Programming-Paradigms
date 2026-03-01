om(george).
om(alex).
om(maria).
om(andrei).
parent(george, alex).
parent(alex, maria).

grandparent(X, Y) :- om(X), om(Y), om(Z), parent(X, Z), parent(Z, Y).

% [], [X], [X|T], [X1, X2, X3 | T]

my_length(0, []).
my_length(Len, [_|T]) :- my_length(Len2, T), Len is Len2 + 1.

