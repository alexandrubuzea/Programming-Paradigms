#lang racket

; Racket = limbaj preponderent functional (are niste constructii iterative, pe care insa noi nu le vom studia)
; avem aici o variabila definita => are statut de variabila globala

(define a 5)

; definim si o functie: functia care primeste un numar n si returneaza n + 2

(define (f n)
  (+ n 2)
  )

; aici se va afisa 7
(+ a 2)

; Observatie: in ceea ce priveste aplicatea unei functii in limbajul Racket, totul se aplica in forma prefixata
; Adica: chiar si operatiile aritmetice, pe care noi suntem obisnuiti sa le aplicam in forma infixata, vor fi ceva de genul:
; (+ 3 5) in loc de (5 + 3)

(+ 3 5)

; In Racket, sintaxa se bazeaza pe paranteze si pe literali, care separa diferite componente ale codului sursa.
; Intotdeauna, interpretorul de limbaj va considera ca ceea ce se afla dupa o paranteza deschisa este o functie (asta daca nu marcam noi altfel).
; De pilda, expresia (3) nu are sens in Racket (eroare la runtime -> nu exista functia "3")
; (3)

; Q1: Va da eroare apelul de mai jos ?
; (define a 4)

; Racket este un limbaj tipat dinamic. Ce inseamna asta ? Pai, inseamna ca tipurile de date se determina
; la runtime, nu la momentul compilarii (nu sunt cunoscute la rulare). Ce implicatii are asta? Pai, sa vedem ...

; 1. Nu avem type annotations la functii/nu cunoastem tipurile datelor de intrare.

(define (fact n)
  (if (zero? n) 1 (* n (fact (- n 1)))))

(fact 6)

; 2. Putem returna tipuri de date diferite in functie de datele de intrare (wow!)

(define (control val)
  (if val 3 #t))

(control #t)
(control #f)

; 3. Putem avea liste in Racket (Racket = dialect de Lisp, Lisp e acronim de la List Processing)
; in care sa avem elemente de tipuri diferite

(define list1 (list 3 4 "gigel" #t))
list1

(define list2 (list #f "gigelinho" (list 2 3 4 "PP") (λ(x) (if (< (/ x 2) 3) (* 10 x) (+ 5 3))) "abracadabra"))

; Listele Racket sunt vazute ca perechi intre un element din lista (head) si restul listei (tail)
(define ex1 (list 1 2 3))
(define ex2 '(1 2 3))
(define ex3 (cons 1 (cons 2 (cons 3 null))))

(equal? ex1 ex2)
(equal? ex1 ex3)

; Cum putem exprima lista (1 2 3) fara ca interpretorul sa considere ca 1 e aplicatie de functie?
; Solutie: marcam asta cu un ' inaintea parantezei deschise.

(define ex-list '((f 1) 2 #t))