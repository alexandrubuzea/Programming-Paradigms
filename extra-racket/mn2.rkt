#lang racket

; In acest fisier, ne propunem sa implementam un mic framework pentru derivare simbolica, ca mai apoi sa
; implementam cateva aplicatii practice (cum ar fi rezolvarea unor ecuatii).

; Dupa cum stiti foarte bine, Racket permite lucrul cu expresii in forma simbolica. Fie ca exemplu expresia
; de mai jos, unde e este o lista care contine simbolul +, simbolul 'x si 1:
(define e '(+ x 1))

; Tineti cont ca expresia de mai sus e privita momentan doar ca o lista de 3 valori simbolice. In acest moment,
; ea nu are nicio proprietate aritmetica, insa prin folosirea functiei eval, putem sa transformam aceasta lista
; de simboluri intr-o aplicatie de functie, rezultatul fiind x + 1.

; Sa consideram expresiile aritmetice comune care folosesc +, -, *, /, o variabila (vom considera x variabila noastra)
; sau aparitii de constante. In plus, sa consideram si posibila existenta a functiilor sin, cos, sqrt, exp, log
; (consideram doar varianta lui log cu un singur parametru aka logaritm natural).

; Astfel, o expresie aritmetica poate fi definita in felul urmator:
; e = constant | 'x | e1 + e2 | e1 - e2 | e1 * e2 | e1 / e2 | sin e | cos e | sqrt e | exp e | log e

; Comportamentele lui +, -, *, / in cazul in care au mai mult de 2 parametri se pot observa usor cu exemple simple in terminal - try it !
; Noi vom trata insa numai cazul functiilor unare (sin, cos, sqrt, exp, log) si binare (+, -, *, /), pentru ca pentru un numar variabil
; de parametri implementarea se complica nenecesar de mult.

; In urma imbricarii unor astfel de expresii, vom obtine AST-uri de expresii aritmetice exprimate in forma simbolica.
; Spre exemplu, toate cele de mai jos sunt expresii posibile.

(define e1 'x)
(define e2 2)
(define e3 '(+ x 2))
(define e4 '(/ (log x) x))
(define e5 '(sqrt (+ x (exp x))))
(define e6 '(sin (+ x y)))

; TODO 1. Scrieti o functie care primeste o astfel de expresie si spune daca expresia contine numai constante. In cazul in care
; expresia contine cel putin o aparitie a variabilei x, se returneaza #f, altfel expresia este evaluata si se intoarce rezultatul
; evaluarii.

(define (contains-var e)
  'todo
  )

; TODO 2. Scrieti o functie care primeste o astfel de expresie si realizeaza optimizari asupra ei. A optimiza o expresie
; inseamna a o aduce la o forma mai simpla, ex. expresia '(+ 1 0) poate fi adusa la 1. Puteti avea in vedere optimizari
; pentru expresiile posibile de genul:
; a. e + 0 = e => din reprezentarea (list '+ e 0) putem ajunge la e
; b. e - 0 = e => din (list '- e 0) avem e.
; c. e + e = 2 * e
; d. log(exp(e)) = e
; e. sin(0) = 0
; f. e - e  = 0
; etc -> posibilitatile sunt nelimitate, puteti alege ce optimizari doriti.
(define (optimize-step e)
  'todo
  )

; TODO 3: Avand la dispozitie functia optimize-step de mai sus care realizeaza un pas de optimizare, ne putem gandi la un fapt
; foarte important: un pas de optimizare ne poate provoca aparitia altor oportunitati de optimizare. Scrieti functia optimize
; care aplica in mod repetat functia de optimizare cu un singur pas, pana cand rezultatul nu se mai modifica.

; Hint: ce tip de recursivitate este potrivit pentru aceasta functie ?
(define (optimize e)
  'todo
  )

; TODO 4: Avand la dispozitie regulile de constructie ale unei expresii aritmetice mentionate, implementati operatia de derivare
; pentru toate tipurile de expresii ce pot aparea.
; ex. (+ 'x 1) -> (+ 1 0)
(define (derivative e)
  'todo
  )

; TODO 5: Avand la dispozitie o expresie aritmetica, scrieti o functie care "interpreteaza expresia": intoarce o functie de 1
; parametru care intoarce valoarea expresiei.
; Hint: tineti cont de faptul ca o functie in Racket e definita ca (lambda (x) <corp>).
; Bonus restrictii: incercati sa folositi eval la top level - adica scrieti (define (compile-expression e) (eval ...))

(define (compile-expression e)
  'todo
  )

; Sa presupunem ca avem o ecuatie de forma x^3 + x - 3 = 0. Aceasta ecuatie nu are solutii evidente, insa se poate arata prin
; artificii matematice ca ecuatia are o unica solutie reala intre 1 si 2. Avand la dispozitie ecuatii de acest gen (expresie = 0),
; cum anume ati implementa o metoda generala de rezolvare a unor astfel de ecuatii, daca considerati:
; 1. Solutia este unica si se afla intr-un interval (a, b), iar functia noastra este continua
; 2. Avem la dispozitie expresia, derivata ei (o putem determina) si o valoare initiala, suficient de apropiata de radacina reala

; Aveti libertatea sa va proiectati propriile voastre functii si propria logica, let your imagination fly :)