#lang racket

; DEMO: explain why functions are first order values.

(list 1 2 #t #f "Gigel" (λ(x) (* x x)))

(define (inc n)
  (λ(x) (+ x n))
  )

(define (add x y)
  (+ x y)
  )

(define (curry-add x)
  (λ(y) (+ x y)
    )
  )

(define curry-add2
  (λ(x) (λ(y) (+ x y)))
  )

(define curry-add3 (curry +))

; A -> B -> C
; f : A -> B, g : B -> C, (compose g f)

; DEMO: implement same function in a curried and uncurried manner. Explain the differences and what would mean a "mix" of uncurry/curry.
; DEMO: how does the way we call a function change when we transform it curry -> uncurry and the other way ? How is currying useful ?

; DEMO: procedure-arity (compare arity of curried vs non-curried function)

; DEMO: higher-order functions (compose)

; DEMO: map (general case), filter

; (map curry-add2 '(1 2 3))

;(map + '(1 2 3) '(4 5 6))
     
; DEMO: foldl, foldr (general case). Pay attention to the differences between them & order of processing.

; foldr(f, acc, []) = acc
; foldr(f, acc, x : xs) = f(x, foldr(f, acc, xs))

; foldl(f, acc, []) = acc
; foldl(f, acc, x : xs) = foldl(f, f(x, acc), xs)

(define (rev L) (foldl cons '() L))

(define rev2 (curry foldl cons '()))

; (cons 1 (cons 2 (cons 3 (cons 4 null))))
; (- 1 (- 2 (- 3 (- 4 0)))) = -2
; DEMO: apply
; (apply f x1 x2 ... xn '(y1 y2 ... ym)) -> (f x1 x2 ... xn y1 y2 ... ym)

; '((1 2 3) (4 5 6)) -> '((1 4) (2 5) (3 6))

; (Exam 2022): write a function (cartesian-app F X) that takes a list of unary functions (list f1 f2 ...) and a list of inputs (list x1 x2 ...)
; and returns a list of all possible applications: (list (f1 x1) (f1 x2) ...).
; example: (cartesian-app (list add1 sub1 odd?) (list 1 2)) -> (list 2 3 0 1 #t #f)

(define (cartesian-app F X)
  (apply append (map (λ(f) (map f X)) F))
  )

; Exercise: write a function (pairs L1 L2) that takes 2 lists of positive integers L1 and L2 and returns a list of pairs of the form
; (<x from L1> . <multiples of x from L2>).
  
; (Multiple choice, 2022): What would the below code return ?

(define (f a)
  (lambda (b)
    (lambda (g)
      (g b a)
      )
    )
  )

; (map ((f '()) '()) (list cons append list))

; (f '()) '() -> (λ(b) λ(g) (g b '())) '() -> λ(g) (g '() '())
; '( (())   ()    (() ()) )