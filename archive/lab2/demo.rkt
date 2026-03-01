#lang racket

(define (rev L)
  (if (null? L) '() (append (rev (cdr L)) (list (car L))))
  )

(define (rev-helper L [acc '()])
  (if (null? L) acc (rev-helper (cdr L) (cons (car L) acc))))

(define (rev2 L) (rev-helper L '()))

(define (sum-list L) (if (null? L) 0 (+ (car L) (sum-list (cdr L)))))

(define (sum-helper L [acc 0]) (if (null? L) acc (sum-helper (cdr L) (+ (car L) acc))))

(define (fibo n)
 (cond
  [(= n 0) 0]
  [(= n 1) 1]
  [else (+ (fibo (- n 1)) (fibo (- n 2)))])
)


(define (fibo-helper n a b)
  (if (= n 0) a (fibo-helper (- n 1) b (+ a b)))
)

(define (fibo2 n)
  (fibo-helper n 0 1))

