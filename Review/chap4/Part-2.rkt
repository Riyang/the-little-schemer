; ----------------------------------- Part 2 -----------------------------------

; predefine
(define add1
  (lambda (n)
    (+ n 1)))
(define sub1
  (lambda (n)
    (- n 1)))
(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else
       (add1 (o+ n (sub1 m)))))))
(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else
       (sub1 (o- n (sub1 m)))))))

;
(define tup?
  (lambda (l)
    (cond
      ((null? l) #t)
      (else
       (and (number? (car l))
            (tup? (cdr l)))))))
; test:
(tup? '(2 11 3 79 47 6))
(tup? '(8 55 5 555))
(tup? '(1 2 8 apple 4 3))
(tup? '(3 (7 4) 18 9))
(tup? '())

;
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else
       (o+ (car tup)
           (addtup (cdr tup)))))))
; test:
(newline)
(addtup '(3 5 2 8))
(addtup '(15 6 7 12 3))
(addtup '(40 4 360))

;
(define o*
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else
       (o+ n (o* n (sub1 m)))))))
; test:
(newline)
(o* 5 3)
(o* 13 4)
(o+ (o* 11 21) 2)

;
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) (quote ()))
      (else
       (cons (o+ (car tup1) (car tup2))
             (tup+ (cdr tup1) (cdr tup2)))))))
; test:
(newline)
(tup+ '(5 3)
      '(13 4))
(tup+ '(3 6 9 11 4)
      '(8 5 2 0 7))
(tup+ '(2 3)
      '(4 6))
(define single 0)
(define dog 1)
(define all-the-way 2)
(define make-list
  (lambda (a . l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (car l)  (make-list (cdr l)))))))
(define make-list
  (lambda (a . l)
    (cons a l)))
(tup+ (make-list single dog single dog single all-the-way)
      (make-list 2 2 3 1 3 1))

; ------------------------------------------------------------------------------
