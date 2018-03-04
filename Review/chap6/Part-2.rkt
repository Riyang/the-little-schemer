; ----------------------------------- Part 2 -----------------------------------

; predefine:
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; Let's try another representation for numbers:
; zero:  ()
; one:   (())
; two:   (() ())
; three: (() () ())
; ...

(define sero?
  (lambda (n)
    (null? n)))
; test:
(newline)
(sero? '())
(sero? '(0))
(sero? '(()))

(define edd1
  (lambda (n)
    (cons (quote ()) n)))
; test:
(newline)
(define sero '())
sero
(edd1 sero)
(edd1 (edd1 sero))
(edd1 (edd1 (edd1 sero)))

(define zub1
  (lambda (n)
    (cdr n)))
; test:
(newline)
(define one '(()))
(zub1 one)
(zub1 '(() ()))
(zub1 '(() () ()))
(zub1 '(() () () ()))

(define o+
  (lambda (n m)
    (cond
      ((sero? m) n)
      (else
       (edd1 (o+ n (zub1 m)))))))
; test:
(newline)
(o+ '() '())
(o+ '() '(()))
(o+ '(()) '(()))
(o+ '(() ()) '(()))

; the previous lat?
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

; rewrite lat? for the new representation
(define new-number?
  (lambda (l)
    (cond
      ((null? l) #t)
      (else
       (and (null? (car l))
            (new-number? (cdr l)))))))
; test:
(newline)
(number? '())
(new-number? '())
(new-number? '(()))
(new-number? '((())))

(define etom?
  (lambda (x)
    (or (and (not (pair? x)) (not (null? x)))
        (new-number? x))))

(define new-lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((etom? (car l)) (new-lat? (cdr l)))
      (else #f))))
; test:
(newline)
(lat? '((()) (() ()) (() () ())))
(new-lat? '((()) (() ()) (() () ())))
(lat? '(1 2 3))
(new-lat? '(1 2 3))
(lat? '(()))         ; (()) means (0),
(new-lat? '(()))     ; actually it can also means 1. Does it funny?


; ------------------------------------------------------------------------------