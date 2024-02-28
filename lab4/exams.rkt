#lang racket

; CA '22

; Scrieti o functie recursiva pe stiva, numita (multicompose f n) care compune functia f cu
; ea insasi de n ori, intorcand functia rezultata (f^n).
; Exemplu: ((multicompose add1 5) 0) = 5
; Folositi o forma de let (si numiti-o) astfel incat sa nu pasati functia f ca parametru la
; fiecare aplicatie recursiva.

; (CA '23) Fie codul de mai jos:

(define (f n x L)
    (if (null? L)
        L
        (if (equal? (car L) x)
            (if (= n 1)
                (cdr L)
                (cons (car L) (f (sub1 n) x (cdr L)))
            )
            (cons (car L) (f n x (cdr L)))
        )
    )
)

; i. Ce face f ?
; ii. Ce tip de recursivitate utilizeaza ?
; iii. Rescrieti functia folosind celalalt tip de recursivitate si numiti-l.
;   Hint: problema de acum 2 laboratoare, acum puteti sa rezolvati pe deplin acest exercitiu.