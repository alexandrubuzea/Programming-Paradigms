#lang racket

; Scrieti o functie in Racket care primeste o lista si intoarce o noua lista, continand:
; 1. Daca un element este un numar par, il injumatateste
; 2. Daca un element este un numar impar, atunci il inlocuieste cu 3 * element + 1
; 3. Daca un element este o lista, actiunea functiei este deep (se aplica si pe elementele
; listelor imbricate)
; 4. Altfel, il lasa la fel

; Ex. (my-function (list 1 2 3 '() "gigelinho" 'x)) -> '(4 1 10 '() "gigelinho" 'x)

; Hint: use (number? N) -> #t, daca N e numar, #f altfel
;           (list? L) -> #t daca L e lista, #f altfel

(define (func L)
  (cond [(null? L) '()]
    [(number? (car L)) (if (even? (car L)) (cons (/ (car L) 2) (func (cdr L))) (cons (+ 1 (* 3 (car L))) (func (cdr L))))]
    [(list? (car L)) (cons (func (car L)) (func (cdr L)))]
    [else (cons (car L) (func (cdr L)))]
  )
)