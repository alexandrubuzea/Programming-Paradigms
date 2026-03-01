#lang racket

; testul grila - none, dar improvizam :)

; Care este rezultatul expresiei de mai jos ?

(define (f L)
    (if (null? L)
        '()
        (if (even? (car L))
            (cdr L)
            (cons (* 2 (car L)) (f (cdr L)))
        )
    )
)

(f '(1 3 4 3 2))

; Care este rezultatul expresiei de mai jos ?

(append (cons '() (list '() (cons '() '()))) '(()))

; Care este rezultatul expresiei de mai jos ?

(define a 'b)
(define b 'a)
(define c '(a . b))

(eq? c (cons b a))
(equal? c (cons b a))