#lang racket

; in limbajele functionale, functiile sunt valori de prim rang
; ce inseamna asta ? Functiile se comporta ca orice altceva (variabile/simboluri, instructiuni etc)

; Exemplu 1
(define function-list (list even? odd? (lambda(x) (+ x (* x x))) cons append))

; Ce presupune efectiv asta ? Ele pot fi pasate altor functii sau pot fi returnate din functii !
; Astfel, putem defini functii care lucreaza cu alte functii, numite functionale (functii de ordin superior)
(define (apply-on-first f) (compose f car))
((apply-on-first (lambda(x) (* x x))) '(3 2 4 1 5))

; Putem scrie o functie in asa fel incat sa permitem reutilizarea de cod ? Spre exemplu, urmatoarele functii
; sunt toate similare intre ele:

(define (add2 x) (+ x 2))
(define (add5 x) (+ x 5))
(define (custom-add x y) (+ x y))
(define (add10 x) (+ x 10))

; Din fericire, avem un mijloc de a transforma o functie obisnuita intr-o functie care sa imi accepte parametrii
; "pe rand" = si daca nu ii am acum pe toti, ii pot pasa functiei ceea ce am si mi se va returna o functie care asteapta
; restul parametrilor
; Un astfel de procedeu -> se numeste currying
(define my-add
	(lambda(x)
    	(lambda(y)
      		(+ x y)
      	)
    )
)

; (define add2 (my-add 2))

; Currying-ul se mai numeste si aplicare partiala, si este foarte util in momentul in care ne dorim reutilizare de cod.
; In Racket, functiile sunt uncurried by default (nu accepta aplicare partiala).
; Mare atentie la aplicarea functiilor curried ! Dupa pasarea primului parametru, return type-ul este o functie, de aceea
; trebuie sa aplicati succesiv parametrii folosind un rand de paranteze
; (my-add 5 5)
; ((my-add 5) 5)

; Pentru a transforma o functie uncurry intr-o functie curry, aveti variantele:
; 1. Daca e o functie cunoscuta, atunci puteti realiza/scrie o succesiune de lambda-uri imbricate, cate un lambda pentru fiecare
; parametru
; 2. Folosind functionala predefinita curry
(define my-add2 (curry +))
((my-add2 5) 5)

; Pentru transformarea inversa (mai rar), creati un lambda/o functie care accepta toti parametrii deodata, si ii aplica asupra
; functiei curried
(define uncurried-add
  (lambda (x y) ((my-add x) y))
  )
(uncurried-add 5 5)

; Functionalele tipice in programarea functionala sunt map, filter, fold
; In particular, in Racket, avem map, filter, foldr, foldl, apply
; Ce face fiecare dintre ele ?

; 1. map aplica o operatie/functie pe toate elementele unei liste. Aceeasi idee ca map() din Java, aplicabil pentru stream-uri.
(map add1 '(1 2 3))

; In particular in Racket, map are o proprietate deosebita: suporta aplicarea unei operatii pe mai multe liste cu o functie
; care sa combine elementele cu acelasi index din fiecare lista (posibil numai daca listele au lungimi egale !!)
(map + '(1 2 3) '(4 5 6) '(7 8 9))

; 2. filter foloseste un predicat (functie care returneaza un boolean) si filtreaza toate elementele dintr-o lista care respecta
; acel predicat (aceeasi idee ca filter() din Java)
(filter odd? '(1 2 3 4 5 6 7 8 9))

; fold la modul general -> este folosit pentru a reduce o lista de elemente la un singur element, plecand de la o valoare initiala,
; numita acumulator (reduce() din Java)

; In cazul nostru -> foldr va combina elementele 2 cate 2, incepand de la sfarsit (aka prima data va combina ultimul element cu acumulatorul) !
; (foldr f acc '(elem1 elem2 elem3 ... elemn)) -> (f elem1 (f elem2 (f elem3 ... (f elemn acc))...)
; Idee 1: puteti sa va ghidati ca foldr va lucra pe lista pastrand elementele in ordinea in care ele exista in lista.
; Idee 2: puteti sa va ghidati ca foldr foloseste recursivitate pe STIVA, adica va face apeluri recursive pentru a ajunge la ultimul element,
; pe care il combina cu acumulatorul, rezultatul cu elementul precedent etc pana termina lista
; Idee 3: puteti sa va ganditi la foldr ca un operator care actioneaza asupra TDA-ului lista:
; foldr f acc [] = acc
; foldr f acc (x:xs) = f x (foldr f acc xs)

(foldr + 0 '(1 2 3 4)) ; operator comutativ, rezultatul este 10, destul de intuitiv
(foldr - 0 '(1 2 3 4)) ; operator necomutativ, rezultatul este (- 1 (- 2 (- 3 (- 4 0)))) = (- 1 (- 2 (- 3 4))) = (- 1 (- 2 -1)) = (- 1 3) = -2

; In mod deloc surprinzator, foldl va functiona exact pe dos !
; (foldl f acc '(elem1 elem2 elem3 elem4 ... elemn)) -> (f elemn (f elemn-1 ( ... (f elem1 acc))...)
; Idee 1: foldl va face reverse pe lista apoi va prelucra elementele (sau puteti considera ca le va prelucra incepand cu primele elemente, intr-o
; maniera mai degraba iterativa, pana la capat)
; Idee 2: foldl foloseste recursivitate pe coada ! Se va comporta ca un proces iterativ, incepand cu primele elemente, pana la final.
; Idee 3: asemanator ca la foldr, operatorul foldl va avea urmatoarele axiome ca operator pentru TDA-ul lista:
; foldl f acc [] = acc
; foldl f acc (x:xs) = foldl f (f x acc) xs

(foldl + 0 '(1 2 3 4)) ; operator comutativ, rezultatul este 10, destul de intuitiv
(foldl - 0 '(1 2 3 4)) ; operator necomutativ, rezultatul este (- 4 (- 3 (- 2 (- 1 0)))) = (- 4 (- 3 (- 2 1))) = (- 4 (- 3 1)) = (- 4 2) = 2

; Mai avem functionala apply, care are comportamentul de a aplica o functie pe toti parametrii unei liste (asemanator cu map, doar ca ... e
; total diferit). Functionala apply va "da discard" la parantezele listei finale. Sintaxa ei generala este:
; (apply f x1 x2 ... xn '(elem1 elem2 ... elemn)) -> (f x1 x2 ... xn elem1 elem2 elem3 ... elemn). Practic, nu conteaza ca elementele
; elem1, elem2 etc au facut parte initial dintr-o lista, ele sunt considerate in mod separat parametrii pentru functia f.

; Exemplu 1
(apply + 1 2 3 4 '(1 2 3 4))

; Exemplu 2
(apply list '(1 2 3 4) '(5 6 7 8)) ; atentie la paranteze !!!! apply nu da discard la toate parantezele, ci doar la cele de la ultimul argument.

; Exemplu 3 (Racket master)
(define transpose
  (λ(matrix)
    (apply map list matrix)
    )
  )

(transpose '((1 2) (3 4)))