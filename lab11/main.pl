om(andrei).
om(alex).
om(radu).
om(diana).
om(maria).

om(X) :- filosof(X).
filosof(george).

% interogarea om(andrei). -> true.
% interogarea om(X). -> avem simbolul variabil X, care va fi
% legat la fiecare dintre numele de mai sus (valori pentru care
% se satisface predicatul de ordin I `om`).

% in Prolog, ordinea in care scriem clauzele are o importanta foarte mare.

% aplicatie: implementare de append sub forma lui my_append(?L1, ?L2, ?L3).

my_append([], L, L).
my_append([H|T], L, Res) :- my_append(T, L, Res1), Res = [H|Res1].

my_append2([], L, L).
my_append2([H|T], L, Res) :- Res = [H|Res1], my_append2(T, L, Res1).

my_append3([], L, L).
my_append3([H|T], L, [H|Rest]) :- my_append3(T, L, Rest).

% cat este domeniul de vizibilitate/scope-ul unui simbol ?
% domeniul de vizibilitate in Prolog = o interogare
% Ex. om(X), filosof(X). -> X = george, iar la urmatoarea interogare
% noi nu vom sti cine este X.

% negarea in limbajul Prolog reprezinta un esec in procesul de demonstrare
% aka "nu pot demonstra acest lucru" -> este true.

nu_este_om(X) :- \+ om(X).

% predicatul CUT (!) -> mentine legarile curente ale variabilelor si
% limiteaza spatiul de cautare la scopul curent (nu mai se exploreaza
% si celelalte variante).

% Ex. om(X), !, writeln(X).

% Exemplu: predicatul min
min(X, Y, Min) :- X > Y, Min = Y.
min(X, Y, Min) :- X =< Y, Min = X.

% Ne deranjeaza faptul ca avem cod redundant (X > Y si X =< Y).
% Cum remediem asta ? Este corect predicatul urmator ?

min2(X, Y, Min) :- X > Y, Min = Y.
min2(X, _, Min) :- Min = X.

% Cum putem optimiza cu cut ? Astfel:

% GREEN CUT
min3(X, Y, Min) :- X > Y, !, Min = Y.
min3(X, Y, Min) :- X =< Y, Min = X.

% RED CUT
min4(X, Y, Min) :- X > Y, !, Min = Y.
min4(X, _, Min) :- Min = X.

% intrebare: ar fi mers predicatul ! (cut) si la final ? Adica ceva de genul:
min5(X, Y, Min) :- X > Y, Min = Y, !.
min5(X, _, Min) :- Min = X.

% astfel, ordinea faptelor si a predicatelor dintr-un fisier conteaza cu atat
% mai mult:

triangle(a).
figure(X) :- !, triangle(X).
figure(b).

% Test grila 2022: ce se afiseaza la t(1). si de ce ?

p(1).
p(2).
p(3).
q(X) :- !, X >= 2.
q(_).
t(X) :- p(X), q(X).

% demo metapredicate:

% forall(+Condition1, +Condition2).

% forall(member(X, [1, 2, 3, 4, 5]), X mod 2 =:= 0).
% findall(X, (member(X, [1, 2, 3, 4, 5]), X mod 2 =:= 0), Bag).
% L = [1, 2, 3, 4, 5, 6], bagof(X, (member(X, L), member(Y, L), Y < X), Bag).