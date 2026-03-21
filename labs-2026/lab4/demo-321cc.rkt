#lang racket

; DEMO: explain why functions are first order values.

(list 1 2 "LabPP" #t (λ(x) (* x (add1 x))))

(define (g n) (λ(x) (+ x n)))

(define (add x y)
  (+ x y)
  )

(define (curry-add x)
  (λ(y) (+ x y))
  )

(define curry-add2
  (λ(x) (λ(y) (+ x y))))

(define inc ((curry +) 1))


; DEMO: implement same function in a curried and uncurried manner. Explain the differences and what would mean a "mix" of uncurry/curry.
; DEMO: how does the way we call a function change when we transform it curry -> uncurry and the other way ? How is currying useful ?


; DEMO: procedure-arity (compare arity of curried vs non-curried function)

; DEMO: higher-order functions (compose)

; DEMO: map (general case), filter

; DEMO: foldl, foldr (general case). Pay attention to the differences between them & order of processing.

; DEMO: apply
; (apply f x1 x2 ... xn '(y1 y2 ... ym)) -> (f x1 x2 ... xn y1 y2 ... ym)

; (Exam 2022): write a function (cartesian-app F X) that takes a list of unary functions (list f1 f2 ...) and a list of inputs (list x1 x2 ...)
; and returns a list of all possible applications: (list (f1 x1) (f1 x2) ...).
; example: (cartesian-app (list add1 sub1 odd?) (list 1 2)) -> (list 2 3 0 1 #t #f)

(define (cartesian-app F X)
  (foldr append '() (map (λ(f) (map f X)) F))
  )

; Exercise: write a function (pairs L1 L2) that takes 2 lists of positive integers L1 and L2 and returns a list of pairs of the form
; (<x from L1> . <multiples of x from L2>).

(define (pairs L1 L2)
  (map (λ(x) (cons x (filter (λ(y) (= (modulo y x) 0)) L2))) L1)
  )
  
; (Multiple choice, 2022): What would the below code return ?

(define (f a)
  (lambda (b)
    (lambda (g)
      (g b a)
      )
    )
  )

(map ((f '()) '()) (list cons append list))

; (f '()) = λ(b) λ(g) (g b '())
; (f '()) '() = λ(g) (g '() '())
; (map (λ(g) (g '() '())) (list cons append list))
; '( (()) ()  (() ()) )