#lang racket

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
;   Hint: named let (incoming peste 2 laboratoare), momentan folositi-va de o functie helper.




; (CA '21) Fie codul de mai jos:

(define (f1 L)
    (if (or (null? L) (null? (cdr L)))
        L
        (cons (max (car L) (cadr L)) (f1 (cddr L)))
    )
)

; i. Ce face f1 ?
; ii. Ce tip de recursivitate utilizeaza ?
; iii. Rescrieti functia folosind celalalt tip de recursivitate.
;   Hint: named let (incoming peste 2 laboratoare), momentan folositi-va de o functie helper.