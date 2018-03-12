; ----------------------------------- Part 1 -----------------------------------


; Functions as arguments, as values.
(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) (quote ()))
      ((test? (car l) a)
       (cdr l))
      (else
       (cons (car l)
             (rember-f test? a (cdr l)))))))
; test:
(newline)
(rember-f = 5 '(6 2 5 3))
(rember-f eq? 'jelly '(jelly beans are good))
(rember-f equal? '(pop corn)
                 '(lemonade (pop corn) and (cake)))

; Functions as return-values.
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))
; test:
(newline)
(define eq?-salad (eq?-c 'salad))
(eq?-salad 'sala)
(eq?-salad 'salad)
(eq?-salad 'tuna)

(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) (quote ()))
        ((test? (car l) a)
         (cdr l))
        (else
         (cons (car l)
               ((rember-f test?) a (cdr l))))))))
; test:
(newline)
(define rember-eq? (rember-f eq?))
(rember-eq? 'tuna '(tuna salad is good))
((rember-f eq?) 'tuna '(shrimp salad and tuna salad))
((rember-f eq?) 'eq? '(equal? eq? eqan? eqlist? eqpair?))


; ------------------------------------------------------------------------------
