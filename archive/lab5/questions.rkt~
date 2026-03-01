#lang racket

(define calcul (lambda(_x) 0)) ; nu e relevanta

; Q8 2023

; De cate ori se evalueaza corpul functiei calcul in expresia de mai jos ?
(stream-first (stream-cons (calcul 0)
    (stream-cons (calcul 1) empty-stream)))

; Q6 2023

; La ce se evalueaza cele 2 expresii Racket de mai jos ?

(define x 3)

(letrec ([f (lambda () (+ x 3))] [x 6]) (f))
(let ([f (delay (+ x 3))] [x 6]) (force f))