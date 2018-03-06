; ----------------------------------- Part 3 -----------------------------------

; predefine
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else
       (or (equal? (car lat) a)
           (member? a (cdr lat)))))))
(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else
       (set? (cdr lat))))))
(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (car (car l))
             (firsts (cdr l)))))))

; the pair function, which is primitive:
;(define pair?
;  (lambda (l)
;    (cond
;      ((null? l) #f)
;      ((null? (cdr l)) #f)
;      ((null? (cddr l))
;       (and (atom? (car l))
;            (atom? (cadr l))))
;      (else #f))))

(define a-pair?  ; a list which contains only two S-expressions
  (lambda (x)
    (cond
      ((atom? x) #f)
      ((null? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))
; test:
(newline)
(a-pair? 'atom)
(a-pair? '())
(a-pair? '(list))
(a-pair? '(pear pear))
(a-pair? '(3 7))
(a-pair? '((2) (pair)))
(a-pair? '(full (house)))
(a-pair? '(what do you want))

(define first
  (lambda (p)
    (car p)))
(define second
  (lambda (p)
    (car (cdr p))))
(define build
  (lambda (s1 s2)
    (cons s1
          (cons s2 (quote ())))))
(define third
  (lambda (l)
    (car (cdr (cdr l)))))

(define rel?
  ; rel stands for relation, which is a set of pairs.
  (lambda (l)
    (cond
      ((null? l) #f)
      ((null? (cdr l))
       (a-pair? (car l)))
      (else
       (and (set? l)
            (and (a-pair? (first l))
                 (rel? (cdr l))))))))  ; my code is ugly :(
; test:
(newline)
(rel? '(apples peaches pumpkin pie))
(rel? '((apples peaches) (pumpkin pie) (apples peaches)))
(rel? '((apples peaches) (pumpkin pie)))
(rel? '((4 3) (4 2) (7 6) (6 2) (3 4)))
(rel? '((0 1) 2))

; simplify rel?
(define rel?
  (lambda (l)
    (cond
      ((null? l) #f)
      ((null? (cdr l))
       (a-pair? (car l)))
      ((set? l)
       (and (a-pair? (car l))
            (rel? (cdr l))))
      (else #f))))
; test:
(newline)
(rel? '(apples peaches pumpkin pie))
(rel? '((apples peaches) (pumpkin pie) (apples peaches)))
(rel? '((apples peaches) (pumpkin pie)))
(rel? '((4 3) (4 2) (7 6) (6 2) (3 4)))
(rel? '((0 1) 2))

(define fun?  ; fun stands for function
  (lambda (rel)
    (set? (firsts rel))))
; test:
(newline)
(fun? '((4 3) (4 2) (7 6) (6 2) (3 4)))
(fun? '((8 3) (4 2) (7 6) (6 2) (3 4)))
(fun? '((d 4) (b 0) (b 9) (e 5) (g 4)))

; How do we represent a finite function?
; For us, a finite function is a list of pairs in
; which no first element of any pair is the same
; as any other first element.

(define rev-pair
  (lambda (pair)
    (build (second pair) (first pair))))
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) (quote ()))
      (else
       (cons (rev-pair (car rel))
             (revrel (cdr rel)))))))
; test:
(newline)
(revrel '((8 a) (pumpkin pie) (got sick)))

(define seconds
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (second (car l))
             (seconds (cdr l)))))))
(define fullfun?
  (lambda (fun)
    (set? (seconds fun))))
; test:
(newline)
(fullfun? '((8 3) (4 2) (7 6) (6 2) (3 4)))
(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4)))
(fullfun? '((grap raisin)
            (plum prune)
            (stewed prune)))
(fullfun? '((grap raisin)
            (plum prune)
            (stewed grap)))
(fullfun? '((1 3)
            (2 1)
            (3 2)))

(define one-to-one
  (lambda (fun)
    (fun? (revrel fun))))
; test:
(newline)
(one-to-one '((chocolate chip)
              (doughy cookie)))


; ------------------------------------------------------------------------------