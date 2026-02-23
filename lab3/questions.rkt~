#lang racket

; Q3 2023

; 3. Care dintre functionalele map, foldl, foldr, apply poate ı̂nlocui sem-
; nul ı̂ntrebării ı̂n expresia Racket de mai jos astfel ı̂ncât aceasta să se
; evalueze la ’((1))?

; (? (lambda (x y) (y x)) (list 1) (list list))

; Q4 2023

; Care este valoarea expresiei Racket de mai jos ?

((foldr compose (lambda (x) x) (list (curry + 1) (curry * 2))) 5)

; Q4 2023

; Care este valoarea expresiei Racket de mai jos ?

(define (f a)
    (lambda (b)
        (lambda (g)
            (g b a)
        )
    )
)

(map ((f '()) '()) (list cons append list))