#lang racket

; DEMO discuss about recursion and why do we need it in functional programming

(define (rev L)
  (if (null? L)
      null
      (append (rev (cdr L)) (list (car L))))
  )

(define (rev-helper L [acc '()])
  (if (null? L)
      acc
      (rev-helper (cdr L) (cons (car L) acc))
  )
  )

(define (rev2 L)
  (rev-helper L null)
  )

(define (fib n)
  (cond
    [(<= n 1) 1]
    [else (+ (fib (- n 1)) (fib (- n 2)))]
    )
  )

(define (fib2 n [a 1] [b 1])
  (cond
    [(= n 0) a]
    [else (fib2 (- n 1) b (+ a b))]
    )
  )

; [] ++ L = L
; (x : xs) ++ L = x : (xs ++ L)

; DEMO discuss about stack recursion. Use the factorial/reverse example.

; DEMO how do we optimize this usually ? -> tail recursion. In what way is the tail recursion more efficient ? Tail recursion modulo cons.

; DEMO discuss about tree recursion (fibonacci). How to convert the implementation to tail recursion ?

; DEMO fractals (see below how we can define a triangle, and play with it !)

(require 2htdp/image)

(triangle 100 "outline" "blue")

(define (sierpinski n)
  (if (< n 10)
      (triangle n "outline" "blue")
      (helper (sierpinski (/ n 2))))
      )

(define (helper c) (above c (beside c c)))

; (EXAM 2025): Write the function skip-sum (with stack recursion), that operates on a list L and returns the sum of some elements in the list
; For each element in the list that is added to the sum, skip a number of elements equal to the added value.
; Ex. (skip-sum '(2 3 3 1 2 4 5 2 1 2 3 1)) -> 2 + 1 + 4 + 3 = 10
; For the above example and given your implementation, how many stack frames are necessary ? (including the original one)

(define (skip-sum L [count 0])
  (cond
    [(null? L) 0]
    [(= count 0) (+ (car L) (skip-sum (cdr L) (car L)))]
    [else (skip-sum (cdr L) (- count 1))]
  )
  )

(require racket/match)

(define/match (sum-list L)
  [('()) 0]
  [((cons x xs)) (+ x (sum-list xs))]
  )