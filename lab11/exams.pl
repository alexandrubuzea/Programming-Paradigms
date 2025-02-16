/*
    Pornind de la o lista de numere, Xs, si de la o lista de liste de numere, Yss , scrieti în Prolog
    o interogare care determina lista tuturor listelor din Yss care fie au toate elementele în
    Xs , fie nu au niciun element în Xs . De exemplu, daca Xs = [1, 2, 3] si Yss = [[1,
    4], [1, 3, 2], [4]] , rezultatul este lista [[1, 3, 2], [4]] . Atentie! NU folositi
    recursivitate explicita, ci metapredicate !
*/

findall(
    Ys,
    (member(Ys, Yss), (forall(member(Y, Ys), member(Y, Xs)) ; forall(member(Y, Ys), \+ member(Y, Xs)))),
    Result
).