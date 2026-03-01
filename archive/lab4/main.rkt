#lang racket

; scope al unei variabile = domeniul sau de vizibilitate = multimea liniilor / locurilor in care acea variabila este vizibila
; context computational = o multime de perechi (simbol - valoare) care sunt caracteristice unui anumit loc din programul nostru

; niste exemple utile

; aici scope-ul variabilei x este DOAR in interiorul let-ului
; contextul este nul inainte de let, apoi este {(x 2)} in interiorul let-ului, apoi este din nou nul (linia 12)
(let ([x 2])
  (+ x 2))

; (* x 5) ; va da eroare de compilare: x este vizibil doar in interiorul let-ului.

; in precursorul lui Racket numit Scheme (dar si in Lisp), `define` facea legare dinamica, de asemenea, puteam redefini simboluri
; in Racket acest lucru nu mai este adevarat (legarea dinamica cu define ar putea introduce efecte laterale, ceea ce nu e permis
; conform paradigmei functionale)

(define a 10) ; define in limbajul Racket va face legare statica globala (NU legare dinamica)
; (define a 30) -> in Scheme/Lisp era posibil, in Racket nu mai este

; legare statica locala in limbajul Racket putem face cu:

; 1. let

; Sintaxa: (let ([e1 val1] [e2 val2] [e3 val3] ... [en valn]) expr)

; In cazul unui let, scope-ul unei variabile este strict corpul let-ului (fara zonele de definire ale celorlalte variabile)

; in urmatorul let, legarile variabilelor vor fi facute pe rand, astfel:
; i. prima data, a se leaga la 5
; ii. apoi, b se leaga la valoarea lui a din contextul superior ! (nu la a = 5, ci la a-ul din contextul global)
; Deci b = 10
; iii. la final, se va evalua expresia (+ 5 10) adica 15

(let ([a 5] [b a])
  (+ a b)
  )

; 2. let*

; Sintaxa este aceeasi ca la let

; Diferenta ? Scope-ul unei variabile incepe in momentul definitiei ei si se termina la finalul let-ului/expresiei.

; Deci evaluarea urmatorului let* va decurge astfel:
; i. a se leaga la 5
; ii. b se leaga la valoarea lui a definita anterior (adica 5)
; iii. Se evalueaza (+ 5 5) adica 10

(let* ([a 5] [b a])
  (+ a b)
  )

; 3. letrec

; Sintaxa este aceeasi ca la let

; Diferenta ? Scope-ul este, de aceasta data, tot letrec-ul (inclusiv inaintea zonei de definire).
; Intrucat putem folosi oricare variabila in procesul de legare, putem avea recursivitate mutuala (a depinde de b, b depinde de a)?
; Raspunsul este: depinde. Spre exemplu, urmatorul letrec va da eroare de compilare.

(define b 20)

; (letrec ([a b] [b a]) (+ a b))

; Dar urmatoarea expresie este valida (functiile sunt remarcabile prin faptul ca continutul lor nu se evalueaza in momentul definirii
; - inca nu am apelat functia)

(letrec ([my-even (λ(x) (if (= x 0) #t (my-odd (- x 1))))]
         [my-odd (λ(x) (if (= x 0) #f (my-even (- x 1))))]
         ) (my-odd 5))

; Practic, la momentul definirii, compilatorul nu va inspecta continutul functiilor. E necesar doar ca la runtime (aka momentul cand
; facem (my-odd 5)) sa stie care este definitia lui my-even (amintim evaluarea intarziata a corpului functiilor)

; 4. named let

; Putem avea situatii cand avem nevoie de o functie helper locala, fara insa sa fie nevoie sa ne definim global acel helper (ex.
; recursivitate pe coada)

; In acest caz, putem sa ne definim o functie recursiva locala sub forma unui let, iar acest let sa ne preia numai parametrii
; dupa care facem recursivitatea
; Avantaj: named let va avea un context superior de unde poate prelua acei parametri ai functiei mari care nu se modifica, si
; un context intern, in care are inclusiv variabilele dupa care se face recursivitatea).
; Un exemplu concret:

; Sa se scrie o functie care primeste o functie f, un numar n si calculeaza f^n (f compus cu f de n ori).
; Evident, parametrul f nu se va modifica, de aceea facem urmatoarea functie (in forma curried):

(define multicompose
  (λ(f)
    (λ(n)
      (let helper-compose ([n n] [acc identity])
        (if (= n 0) acc (helper-compose (- n 1) (compose acc f))))
        )
      )
    )

(((multicompose (curry * 2)) 10) 1) ; rezultatul va fi functia care inmulteste cu 2^10, aplicata pe 1 = 1024

; ce este o inchidere functionala ?
; in limbajul Racket, in momentul in care o lambda-expresie este definita (lambda-expresie = textul unei functii lambda),
; are loc o inchidere functionala = functia lambda isi va salva contextul exterior in care ea a fost definita

; exemplu concret:

(define c 10)
(define f (λ(x) (+ x c)))

; aici expresia va fi evaluata la 20, intrucat functia va folosi valoarea lui c din momentul definirii ei
; aka c = 10, nu c = 20 din contextul folosirii functiei
(let ([c 20]) (f 10))

; Exercitiu: ce se va afisa in urmatoarele exemple ?
(define a1 1)
(define a2 2)
(define a3 3)

(let ([a1 a2] [a2 a3] [a3 a1]) (+ a1 a2 a3))

(let* ([a1 a2] [a2 a3] [a3 a1]) (+ a1 a2 a3))

(let ([map filter] [filter map])
  ((compose (curry map odd?) (curry filter (λ(x) (+ x (quotient x 2))))) '(1 2 3))
  )
(let* ([c 20]) (f 10))