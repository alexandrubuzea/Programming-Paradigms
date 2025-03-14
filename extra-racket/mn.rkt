#lang racket

; fisierul de fata propune un suport de lucru pentru algoritmi cunoscuti (sper) si
; expresii matematice in forma simbolica

; TODO 1: Implementati o functie care, avand 2 liste de aceeasi lungime, realizeaza
; produsul scalar al vectorilor reprezentati de cele doua liste.

; recursivitate pe stiva
(define (stack-dot-product v1 v2)
  'todo
  )

; recursivitate pe coada
(define (tail-dot-product v1 v2)
  'todo
  )

; functionale - de preferat modalitatea folosind functionale recursive pe coada
(define (functional-dot-product v1 v2)
  'todo
  )

; selectam functia dintre implementarile de mai sus pentru a fi folosita in cele ce urmeaza
(define dot-product functional-dot-product)

; TODO 2: Folosind dot-product, implementati operatia de inmultire a unei matrice cu un vector
; O matrice este reprezentata in Racket ca o lista de liste in care fiecare lista este o linie
; din matrice.
; Se garanteaza ca inmultirea e posibila (numarul de elemente de pe o linie = lungimea vectorului
; cu care se inmulteste matricea). Matricea poate sa nu fie neaparat patratica

; recursivitate pe stiva
(define (stack-matrix-vector M v)
  'todo
  )

; recursivitate pe coada
(define (tail-matrix-vector M v)
  'todo
  )

; functionale - alegeti ce functionala vi se pare convenabila
(define (functional-matrix-vector M v)
  'todo
  )

; selectam implementarea dorita pentru mai tarziu
(define matrix-vector functional-matrix-vector)

; TODO 3: Folosind matrix-vector, implementati operatia de inmultire a doua matrice.
; Reprezentarea matricelor este aceeasi ca pana acum.
; Este garantat ca operatia de inmultire este posibila.

; Hint: este posibil sa considerati o alta functie utila, aceea de transpunere a unei matrice:
(define (transpose M)
  'todo
  )

; implementati cum doriti - de preferat, folositi functionale pentru un cod mai scurt & usor de inteles
(define (mult-matrix M1 M2)
  'todo
  )

; TODO 4: Avand la dispozitie dot-product, implementati operatia de proiectie a unui vector v pe un alt
; vector, u. Se garanteaza ca cei doi vectori au aceeasi lungime.
; Proiectia unui vector pe alt vector reprezinta componenta din vectorul original de-a lungul directiei
; de proiectie odata ce descompunem vectorul pe 2 (sau mai multe) directii: directia lui u si directia
; perpendiculara pe u.
; Hint: proj_u v = ((v^T * u) / (u^T * u)) * u

(define (proj u v)
  'todo
  )

; TODO 5: Avand la dispozitie functia proj si 2 vectori u si v, scrieti functia two-orth, care ortogonalizeaza
; si normalizeaza vectorul v in raport cu u si intoarce vectorul v', ortogonal cu u si avand norma 1.

(define (two-orth u v)
  'todo
  )

; TODO 6: Avand la dispozitie functia two-orth, scrieti functia gram-schmidt care primeste o matrice si aplica
; procedeul Gram-Schmidt asupra coloanelor acestei matrice.
; Procedeul Gram-Schmidt pentru o multime de vectori {v1, v2 ... vn} liniar independenti urmareste obtinerea
; unei multimi {q1, q2, ... qn} de vectori, astfel:
; 1. Pentru primul vector v1, acesta se normalizeaza (se inmulteste cu 1 / ||v1||, unde ||v1|| = sqrt(v1^T * v1))
; Rezultatul este q1 care se adauga in multimea rezultat
; 2. Pentru v2, acesta se ortogonalizeaza in raport cu v1 (implicit cu q1, intrucat au aceeasi directie) iar
; rezultatul se normalizeaza, obtinandu-se q2.
; 3. Pentru v3, acesta se ortogonalizeaza in raport cu q1, apoi q2, apoi prin normalizare obtinem q3.
; 4. Analog pentru restul vectorilor.

; Rezultatul returnat este o matrice care are coloanele o baza ortonormata (vectorii sunt ortogonali/perpendiculari
; intre ei si de norma 1. Matricea are aceleasi dimensiuni cu matricea primita ca parametru.

; Hint 1: proiectiile lui vi+1 pe q1, q2, ... qi se pot calcula separat, intrucat ortogonalizarea
; in raport cu submultimea {q1, q2 ... qi} determinata in primii i pasi nu influenteaza rezultatul,
; indiferent de ordinea in care se scad proiectiile.

; Hint 2: intrucat algoritmul trebuie folosit pentru a aduce coloanele matricei la o baza ortonormata, poate
; fi util sa folositi functia transpose implementata anterior.

(define (gram-schmidt M)
  'todo
  )

; TODO 7: Avand la dispozitie functia gram-schmidt, determinati o factorizare QR posibila a unei matrice patratice
; A, primita ca parametru al functiei qr. Intoarceti rezultatul ca o pereche cu punct intre Q si R. Ce
; observati la printare ?

; Hint: Cum puteti determina matricea Q folosind una dintre functiile deja implementate? Avand la dispozitie Q (matrice
; ortogonala), cum puteti obtine matricea R? Hint: porniti de la A = Q * R si prelucrati ecuatia putin.

(define (qr A)
  'todo
  )

; TODO 8: Scrieti o functie care, primind la intrare o matrice A despre care cunoastem ca este patratica si superior
; triunghiulara si un vector b al termenilor liberi de aceeasi lungime cu ordinul matricei A, intoarce un vector
; x care reprezinta solutia sistemului superior triunghiular (SST) Ax = b.
; Un astfel de sistem cu necunocutele x = [x1, x2, ... xn]^T se poate rezolva foarte simplu, pornind de la ultima
; ecuatie (care contine doar xn) de unde determinam xn, apoi inlocuind in penultima ecuatie (care contine xn-1 si xn)
; putem obtine xn-1, apoi in antepenultima etc, procedeu care se numeste substitutie inapoi.
(define (solve-sst A x)
  'todo
  )

; TODO 9: folosind functiile qr si solve-sst, implementati o functie solve-linear care primeste o matrice A patratica
; si inversabila, un vector b al termenilor liberi si rezolva sistemul Ax = b, returnand solutia unica x.
(define (solve-linear A b)
  'todo
  )