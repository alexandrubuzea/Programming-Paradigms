#lang racket

'(+ 1 2)
(list (+ 1 2))

(define (generate-even n)
    (if (= n 0)
        '()
        (append (generate-even (- n 1)) (list (* n 2))))
)

(define (generate-even2 n)
    (let generate-helper ([start 2][end (* 2 n)][acc '()])
        (if (> start end)
            acc
            (generate-helper start (- end 2) (cons end acc))
        )
    )
)

(define (generate-even3 n)
    (letrec ([evens (stream-cons 2 (stream-map (lambda (x) (+ x 2)) evens))])
        (stream->list (stream-take evens n))
    )
)

(generate-even 10)
(generate-even2 10)
(generate-even3 10)