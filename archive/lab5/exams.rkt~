#lang racket

(require racket/stream)

(define (stream-zip-with f s1 s2)
    (stream-cons (f (stream-first s1) (stream-first s2))
        (stream-zip-with f (stream-rest s1) (stream-rest s2)))
)

(define naturals (stream-cons 0 (stream-map add1 naturals)))

(define (stream-merge s1 s2)
    (stream-cons (stream-first s1)
        (stream-cons (stream-first s2)
            (stream-merge (stream-rest s1) (stream-rest s2))
        )
    )
)

; CA '23

; Determinati primele 8 elemente ale urmatorului stream:

(define s (stream-cons 1 (stream-cons 2 (stream-zip-with - s naturals))))

; CA '22

; Sa presupunem ca avem functia stream-merge care imbina elementele a doua fluxuri
; (vezi definitia mai sus). Spre exemplu, (stream-merge naturals naturals) =
; '(0 0 1 1 2 2 ...)

; Determinati primele 8 elemente ale fluxului:

(define s2 (stream-cons 'x (stream-merge naturals s2)))

; CA '23

; Cu ce se pot inlocui punctele din urmatoarea expresie:
; (λx.(x y) . . .) → z

; CA '22

; Fie λ-expresia de mai jos:
; E ≡ (λx.λy.(x y) y)
; (a) (4p) Completati fraza: Pentru a evalua expresia utilizând modelul bazat pe substitutie
; textuala, trebuie înlocuite aparitiile (libere/legate?) _(1)_ ale variabilei _(2)_ din
; expresia _(3)_ cu expresia _(4)_.
; (b) (3p) Care este rezultatul evaluarii si de ce nu este corect?
; (c) (3p) Ce pas lipseste pentru a obtine rezultatul corect? Scrieti rezultatul corect.