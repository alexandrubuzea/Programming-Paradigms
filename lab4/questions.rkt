#lang racket

; Q7 2022

; La ce valoare se evalueaza expresia de mai jos ?

(let*  ([a 3]
        [b 2]
        [c 1]
        [f (lambda (a b) (+ a b c))])
    (let ([a 4] [b 5] [c 2]) (f a b))
)

; Q6 2022

; Ce se afiseaza la executia urmatorului cod ?

(define L '(1 2 3))
(define x (cdr L))
(define y (cddr L))
(define z (cdddr L))
(let* ([x y] [y z] [z x]) (list x y z))

; Q8 2017

; Ce se afiseaza la executia urmatorului cod ?

; (define x 5)
; (let ((x 100) (y x))
;     (let* ((y (+ y 1)) (x (* 2 y)))
;         (+ x y)
;     )
; )
