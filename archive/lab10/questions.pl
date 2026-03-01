% Q16, 2023
% De cate ori este satisfacut pred(R) ?

pred(R) :- append(A, B, [1,X,Y]), member(R, A), member(R, B).

% variante: 4, niciodata, 2, 3

% Q14, 2023
% Ce va afisa Prolog daca vom incerca sa satisfacem scopul pred2(X)
% in toate modurile posibile ?

p(1). p(2). p(3).
q(1). q(3).
pred2(X) :- p(A), q(A), p(B), q(B), append(X, Y, [1,2,3,1]), member(A, X), member(B, Y).