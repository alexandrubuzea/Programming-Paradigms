#lang racket

; Q1, 2023

(define (f x)
    (cond [(< x 0) x]
          [(odd? x) (f (- x 1))]
          [else (+ (f (- x 3)) (f (- x 4)))]))

; Fie codul de mai sus. Ce adancime maxima atinge stiva in timpul apelului (f 5) ?
; Se considera ca primul apel (adica (f 5)) se afla la adancime 0. 

; Q2, 2023

(define (f1 x acc)
    (if (zero? x) acc
        (f1 (sub1 x) (add1 acc))))

; Variante:
; (a) f este recursivă pe coadă pentru că nu mai realizează alte
; operatii după aplicatia recursivă.
; (b) f este recursivă pe coadă pentru că nu mai realizează alte
; operatii după aplicatia recursivă si pentru că foloseste un acu-
; mulator (fără acumulator nu am avea recursivitate pe coadă).
; (c) f este recursivă pe coadă pentru că foloseste un acumulator.
; (d) f este recursivă pe stivă.

; Q2, 2022

; Cum arată procesul generat de apelul (par? 10) ı̂n Racket?

(define (par? x)
    (or (zero? x) (impar? (- x 1)))
)

(define (impar? x)
    (and (> x 0) (par? (- x 1)))
)

; (a) Ca o iteratie — nu este necesară depunerea de informatie pe
; stivă.
; (b) Ca o recursivitate pe stivă — se asteaptă rezultatele apelurilor
; pe numere mai mici pentru a putea fi procesate de or si and.
; (c) Ca o recursivitate arborescentă — exceptând cazul de bază,
; pentru fiecare apel este nevoie să combinăm două rezultate
; (unul al functiei par?, unul al functiei impar?).
; (d) Ca un calcul elementar — functiile nu sunt recursive (niciuna
; dintre ele nu se autoapelează).