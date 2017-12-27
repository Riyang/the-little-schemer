;;the value function, an interpreter for little scheme programming language

;;predefine
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
(define build
  (lambda (x y)
    (cons x (cons y (quote ())))))
(define first
  (lambda (l)
    (car l)))
(define second
  (lambda (l)
    (car (cdr l))))
(define third
  (lambda (l)
    (car (cdr (cdr l)))))
(define add1
  (lambda (n)
    (+ n 1)))
(define sub1
  (lambda (n)
    (- n 1)))

;;the value:
(define value
  (lambda (e)
    (meaning e (quote ()))))

;;the meaning:
(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

;;the expression-to-action:
(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))

;;the atom-to-action:
(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *const)
      ((eq? e #t) *const)
      ((eq? e #f) *const)
      ((eq? e (quote cons)) *const)
      ((eq? e (quote car)) *const)
      ((eq? e (quote cdr)) *const)
      ((eq? e (quote null?)) *const)
      ((eq? e (quote eq?)) *const)
      ((eq? e (quote atom?)) *const)
      ((eq? e (quote zero?)) *const)
      ((eq? e (quote add1)) *const)
      ((eq? e (quote sub1)) *const)
      ((eq? e (quote number?)) *const)
      (else *identifier))))

;;the list-to-action:
(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? (car e) (quote quote))
          *quote)
         ((eq? (car e) (quote lambda))
          *lambda)
         ((eq? (car e) (quote cond))
          *cond)
         (else *application)))
      (else *application))))

;;the type *const
(define *const
  (lambda (e table)
    (cond
     ((number? e) e)
     ((eq? e #t) #t)
     ((eq? e #f) #f)
     (else
      (build (quote primitive) e)))))

;;the type *quote
(define *quote
  (lambda (e table)
    (test-of e)))        ;;why?
(define test-of second)

;;the type *identifier
(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))
;the initial-table
(define initial-table
  (lambda (name)
    (car (quote ()))))    ;;why?
; the lookup-in-table function
(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else
       (lookup-in-entry name
                        (car table)
                        (lambda (name)
                          (lookup-in-table name
                                           (cdr table)
                                           table-f)))))))
; the lookup-in-entry function
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help name
                          (first entry)
                          (second entry)
                          entry-f)))
(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
      ((null? names) (entry-f name))
      ((eq? (car names) name)
       (car values))
      (else
       (lookup-in-entry-help name
                             (cdr names)
                             (cdr values)
                             entry-f)))))

;; the type *lambda, which make a closure
(define *lambda
  (lambda (e table)
    (build (quote non-primitive)
           (cons table (cdr e)))))

;; the type *cond
(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))
; the cond-lines-of
(define cond-lines-of second)
; the evcon function
(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
       (meaning (answer-of (car lines)) table))
      ((meaning (question-of (car lines)) table)
       (meaning (answer-of (car lines)) table))
      (else
       (evcon (cdr lines) table)))))
;
(define question-of first)
(define answer-of second)

;; the type *application
(define *application
  (lambda (e table)
    (apply-f
     (meaning (function-of e) table)
     (evlis (arguments-of e) table))))
; the function-of
(define function-of car)
; the arguments-of
(define arguments-of cdr)
; the evlis function
(define evlis
  (lambda (args table)
    (cond
      ((null? args) (quote ()))  ;;why?
      (else
       (cons (meaning (car args) table)
             (evlis (cdr args) table))))))
; the apply function
(define apply-f
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive (second fun)
                        vals))
      ((non-primitive? fun)
       (apply-closure (second fun)
                      vals)))))

; the apply-primitive function
(define apply-primitive
  (lambda (name vals)
    (cond
      ((eq? name (quote cons))
       (cons (first vals) (second vals)))
      ((eq? name (quote car))
       (car (first vals)))
      ((eq? name (quote cdr))
       (cdr (first vals)))
      ((eq? name (quote null?))
       (null? (first vals)))
      ((eq? name (quote eq?))
       (eq? (first vals) (second vals)))
      ((eq? name (quote atom?))
       (atom? (first vals)))    ;; in the book it is :atom?, why?
      ((eq? name (quote zero?))
       (zero? (first vals)))
      ((eq? name (quote add1))
       (add1 (first vals)))
      ((eq? name (quote sub1))
       (sub1 (first vals)))
      ((eq? name (quote number?))
       (number? (first vals))))))

;; the apply-closure function
(define apply-closure
  (lambda (closure vals)
    (meaning (body-of closure)
             (extend-table (new-entry (formals-of closure)
                                      vals)
                           (table-of closure)))))

;
(define table-of first)
(define formals-of second)
(define body-of third)
;
(define new-entry build)
;
(define extend-table cons)

; the primitive?
(define primitive?
  (lambda (fun)
    (eq? (first fun) (quote primitive))))

; the non-primitive?
(define non-primitive?
  (lambda (fun)
    (eq? (first fun) (quote non-primitive))))

;;-------------------------------------------
;; The Final Test
;;-------------------------------------------
; *const:
(value '4)
(value '#t)
(value '#f)

; *quote:
(value '(quote apple))

; *identifier:
; ...

; *lambda:
(value '(lambda (x) x))

; *cond:
; ...

; *application:
(value '(add1 0))
(value '(car (quote (a b c))))

; apply-closure:
(apply-closure '((((u v w) (1 2 3))
                  ((x y z) (4 5 6)))
                 (x y)
                 (cons z x))
               '((a b c) (d e f)))
