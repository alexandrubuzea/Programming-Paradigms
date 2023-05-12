#lang racket
(require racket/stream)

; reamintim faptul ca Racket foloseste modelul de evaluare aplicativa
; aka (+ 1 (+ 2 3)) se va evalua din interior spre exterior (+ exterior va cere evaluarea parametrilor sai, iar
; evaluarea are loc astfel:
; (+ 1 (+ 2 3)) -> (+ 1 5) -> 6

; evaluarea se poate realiza insa si in alta ordine: din motive de performanta, noi am putea evalua o expresie
; numai atunci cand avem nevoie explicit de ea.

; avem deci nevoie de o metoda care sa ne realizeze intarzierea evaluarii pana in momentul in care avem nevoie
; de rezultatul operatiei noastre
; cunoastem deja o metoda in acest sens: inchiderea functionala.
; ce facem insa daca putem evalua corpul si nu mai avem parametrii de dat ? -> folosim inchideri nulare :)
; (aka lambda-uri cu 0 parametri)
; Exemple:

; chiar daca noi am putea evalua rezultatul, totusi nu o vom face: avem de "evaluat" functia lambda la momentul la care trebuie
(define result (λ() (+ 2 3)))

; ce facem insa daca vrem sa folosim valoarea lui result de mai multe ori ?
; raspuns: inchiderea functionala este dummy (se va evalua de fiecare data cand este solicitata evaluarea ei)

; Exemplu concret
(define op (λ() (display "gigel\n") (+ 2 3)))
(+ (op) (op))

; deci daca avem de facut calcule complexe care trebuie intarziate, trebuie sa facem de fiecare data valoarea acelei inchideri.
; avem alternativa ?
; raspuns: DA. Avem un mecanism builtin in Racket, care se numeste promisiune.

(define b (delay 5)) ; b aici va avea tipul #<promise>

; ne salveaza promisiunile de dezavantajul de la inchideri de a evalua calculul de fiecare data ? Raspuns: DA
(define c (delay (display "gigel2\n") (+ 2 3)))
c
(force c)
c
(force c)

; acest nou tip de evaluare se numeste evaluare intarziata/lenesa. Haskell va folosi exclusiv evaluare lenesa din motive de performanta.
; Cum putem realiza liste cu evaluare lenesa ? (liste care se evalueaza numai pe masura ce ne trebuie elemente din ele)

; 1. Cu inchideri functionale
(define (clojure-take s n)
  (if (= n 0) null
      (cons (car (s)) (clojure-take (cdr (s)) (- n 1)))
  )
  )

(define clojure-ones (λ() (cons 1 clojure-ones)))

(clojure-take clojure-ones 5)

; 2. Folosind promisiuni
(define (delay-take s n)
  (if (= n 0) null
      (cons (car s) (delay-take (force (cdr s)) (- n 1)))
  )
)

(define delay-ones (cons 1 (delay delay-ones)))
(delay-take delay-ones 10)

; observati ca mai sus, datorita evaluarii lenese, am putut genera lista infinite. WOW !

; din fericire, Racket ofera o interfata simplificata pentru lucrul cu streams.
; avem functii precum stream-cons (cons de la liste), stream-first (car de la liste), stream-last (cdr de la liste) si
; functionale precum stream-map, stream-filter. De asemenea, avem si stream-ul gol (empty-stream)

; pentru inceput, pentru a vizualiza stream-urile, definim o functie care ne extrage primele n numere
; dintr-un stream dat.

(define (stream-take s n)
  (cond
    ((equal? s empty-stream) null)
    ((= n 0) null)
    (else (cons (stream-first s) (stream-take (stream-rest s) (- n 1))))
    )
  )

; sa definim stream-uri din ce in ce mai interesante ...

; A. stream-ul numerelor naturale (al tuturor)
; pentru acest stream, avem mai multe variante de definire, astfel:
; varianta 1: naturals in functie de ... el insusi
(define naturals-1 (stream-cons 0 (stream-map (λ(x) (+ x 1)) naturals-1)))

; varianta 2: naturals folosind un helper, care ne genereaza elementele de la o valoare k incolo, si particularizarea helper-ului pentru k = 0
(define helper-naturals (λ(k) (stream-cons k (helper-naturals (+ k 1)))))

(define naturals-2 (helper-naturals 0))

; varianta 3: naturals folosind stream-ul de ones si o functie care imi combina 2 streams, numita stream-zip-with
(define ones (stream-cons 1 ones))
(define (stream-zip-with f s1 s2)
  (cond
    ((stream-empty? s1) s2)
    ((stream-empty? s2) s1)
    (else (stream-cons (f (stream-first s1) (stream-first s2)) (stream-zip-with f (stream-rest s1) (stream-rest s2))))
    )
  )

(define naturals-3 (stream-cons 0 (stream-zip-with + ones naturals-3)))

; B. stream-ul patratelor perfecte

; varianta 1: putem mapa stream-ul numerelor naturale cu λ(x) (* x x) si obtinem patratele perfecte
(define squares-1 (stream-map (λ(x) (* x x)) naturals-1))

; varianta 2: putem filtra patratele perfecte din stream-ul numerelor naturale.
(define is-square?
  (λ(n)
    (let helper-square ([d 0])
      (cond
        ((= d (+ n 1)) #f)
        ((= n (* d d)) #t)
        (else (helper-square (+ d 1)))
        )
      )
    )
  )

(define squares-2 (stream-filter is-square? naturals-1))

(stream-take squares-2 10)

; C. stream-ul numerelor prime

; pentru acest stream, vom folosi un algoritm cunoscut sub numele de ciurul lui Eratostene.
; care sunt pasii ? -> luam primul element din stream si eliminam din restul stream-ului acele elemente divizibile cu el (care deci nu pot fi prime)
; avem nevoie de o functie auxiliara care ne primeste un stream si ne aplica ciurul pe el.

(define sieve
  (λ(s) 
    (let ([elem (stream-first s)])
      (stream-cons elem (sieve (stream-filter (λ(x) (> (remainder x elem) 0))
                             (stream-rest s)))))))

(define primes (sieve (stream-rest (stream-rest naturals-3))))

(stream-take primes 100)

(define fibo (stream-cons 0 (stream-cons 1 (stream-zip-with + fibo (stream-rest fibo)))))
(stream-take fibo 20)