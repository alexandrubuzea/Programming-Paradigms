#lang racket

; CA '22

; Scrieti în Racket, folosind exclusiv functionale, o functie care ia ca parametri o lista de
; functii si o lista de argumente, posibil de lungimi diferite, si aplica fiecare functie pe fiecare
; argument, pe principiul unui produs cartezian, întorcând lista rezultatelor. De exemplu,
; (cartesian-app (list add1 sub1 odd?) (list 1 2)) se evalueaza la ’(2 3 0 1
; #t #f) . Primele dou elemente ale rezultatului, 2 si 3 , corespund aplicatiilor (add1 1)
; si (add1 2) ; urmatoarele doua, 0 si 1 , aplicatiilor (sub1 1) si (sub1 2) etc.

(define (cartesian-app F L)
  (apply append (map (λ(f) (map (λ(e) (f e)) L)) F))
)

; CA '20

; Se dă o listă L de numere. Sa se scrie o functie count-smaller care intoarce o lista de
; perechi de forma (number . freq), unde freq este numarul de numere mai mic decat numarul
; number. Perechile trebuie sa fie unice dupa numarul number. Ordinea perechilor nu conteaza.
; Ex. '(1 2 3 3 4 2 1 3 3) -> '((1 . 0) (2 . 2) (3 . 4) (4 . 8))
(define (count-pairs L)
  (map (λ(e) (cons e (length (filter (λ(x) (< x e)) L)))) (foldr (λ(x acc) (if (equal? #f (member x acc)) (cons x acc) acc)) '() L))
)

; Precizare: functia trebuie sa fie scrisa folosind exclusiv functionale.
; Hint: ganditi-va de ce ati avea nevoie mai intai in alcatuirea listei de perechi, pentru
; ca perechile sa fie unice.

