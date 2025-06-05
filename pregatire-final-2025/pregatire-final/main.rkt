#lang racket

(define y 10)

(define E ((λ (x) (λ (y) (x y))) y))