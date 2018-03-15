; ----------------------------------- Part 3 -----------------------------------


; predefine
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
(define operator
  (lambda (nexp)
    (car nexp)))
(define 1st-sub-exp
  (lambda (nexp)
    (car (cdr nexp))))
(define 2nd-sub-exp
  (lambda (nexp)
    (car (cdr (cdr nexp)))))
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))
(define add1
  (lambda (n)
    (+ n 1)))

; the previous value function from chapter 6
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp)
            (quote +))
       (+ (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp))))
      ((eq? (operator nexp)
            (quote *))
       (* (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp))))
      (else
       (expt (value (1st-sub-exp nexp))
             (value (2nd-sub-exp nexp)))))))
; test:
(newline)
(value '(+ 1 1))
(value '(+ (+ 0 2) (+ 2 0)))
(value '(* 1 1))
(value '(* (+ 0 2) (+ 2 0)))
(value '(expt 2 2))
(value '(expt 2 (expt 4 1)))

; use abstraction to rewrite value
(define atom-to-function
  (lambda (x)
    (cond
      ((eq? x (quote +)) +)
      ((eq? x (quote *)) *)
      (else expt))))
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
       ((atom-to-function (operator nexp))
        (value (1st-sub-exp nexp))
        (value (2nd-sub-exp nexp)))))))
; test:
(newline)
(value '(+ 1 1))
(value '(+ (+ 0 2) (+ 2 0)))
(value '(* 1 1))
(value '(* (+ 0 2) (+ 2 0)))
(value '(expt 2 2))
(value '(expt 2 (expt 4 1)))

(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a)
       (multirember a (cdr lat)))
      (else
       (cons (car lat) (multirember a (cdr lat)))))))
(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        ((null? lat) (quote ()))
        ((test? (car lat) a)
         ((multirember-f test?) a (cdr lat)))
        (else
         (cons (car lat)
               ((multirember-f test?) a (cdr lat))))))))
; test:
(newline)
((multirember-f eq?) 'tuna '(shrimp salad tuna salad and tuna))
((multirember-f =) 4 '(1 2 3 4))
((multirember-f equal?) '() '(one () (two) () ((three)) (())))

; combine test? and a
(define eq?-tuna
  (eq?-c (quote tuna)))
(define multirember-f
  (lambda (test?)
    (lambda (lat)
      (cond
        ((null? lat) (quote ()))
        ((test? (car lat))
         ((multirember-f test?) (cdr lat)))
        (else
         (cons (car lat)
               ((multirember-f test?) (cdr lat))))))))
; test:
(newline)
((multirember-f eq?-tuna) '(shrimp salad tuna salad and tuna))

(define multiremberT
  (lambda (test? lat)  ; test? is a one-argument function, like eq?-tuna
    (cond
      ((null? lat) (quote ()))
      ((test? (car lat))
       (multiremberT test? (cdr lat)))
      (else
       (cons (car lat)
             (multiremberT test? (cdr lat)))))))
; test:
(newline)
(multiremberT eq?-tuna '(shrimp salad tuna salad and tuna))

; a complicated function
(define multirember&co
  (lambda (a lat col)  ; col is a two-arguments(2 lists) function
    (cond
      ((null? lat)
       (col (quote ()) (quote ())))
      ((eq? (car lat) a)
       (multirember&co a (cdr lat)
                       (lambda (newlat seen)
                         (col newlat
                              (cons (car lat) seen)))))
      (else
       (multirember&co a (cdr lat)
                       (lambda (newlat seen)
                         (col (cons (car lat) newlat)
                              seen)))))))

;
(define a-friend
  (lambda (x y)
    (null? y)))
(define last-friend
  (lambda (x y)
    (length x)))
; test:
(newline)
(multirember&co 'tuna '() a-friend)
(multirember&co 'tuna '(tuna) a-friend)
(multirember&co 'tuna '(and tuna) a-friend)
(multirember&co 'tuna '(strawberries tuna and swordfish) a-friend)
(multirember&co 'tuna '(strawberries tuna and swordfish) last-friend)

;
(define first-list
  (lambda (l1 l2)
    l1))
(define second-list
  (lambda (l1 l2)
    l2))
(define collector
  (lambda (l1 l2)
    (list 'col l1 l2)))
; test:
(newline)
(multirember&co 'tuna '(tuna) first-list)
(multirember&co 'tuna '(tuna) second-list)
(multirember&co 'tuna '(tuna) collector)
(multirember&co 'tuna '(and tuna) collector)
(multirember&co 'tuna '(tuna and) collector)
(multirember&co 'tuna '(and tuna and) collector)
(multirember&co 'tuna '(... and tuna and ...) collector)
(multirember&co 'tuna '(strawberries tuna and swordfish) collector)
(multirember&co 'tuna '(strawberries tuna and swordfish and tuna) collector)

; ---------------------------------------
; What does (multirember&co a lat f) do?
; It looks at every atom of the lat to see whether it is eq? to a.
; Those atoms that are not are collected in one list ls1;
; the others for which the answer is true are collected in a second list ls2.
; Finally, it determines the value of (f ls1 ls2).
; -------------------------------------------------

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new
             (cons old
                   (multiinsertL new old (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertL new old (cdr lat)))))))
(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons old
             (cons new
                   (multiinsertR new old (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertR new old (cdr lat)))))))
;
(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) oldL)
       (cons new
             (cons oldL
                   (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? (car lat) oldR)
       (cons oldR
             (cons new
                   (multiinsertLR new oldL oldR (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertLR new oldL oldR (cdr lat)))))))
; test:
(newline)
(multiinsertLR 'new 'oldL 'oldR '(oldL and oldR))

;
(define multiinsertLR&co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat)
       (col (quote ()) 0 0))
      ((eq? (car lat) oldL)
       (multiinsertLR&co new oldL oldR (cdr lat)
                         (lambda (newlat L R)
                           (col (cons new (cons oldL newlat))
                                (add1 L)
                                R))))
      ((eq? (car lat) oldR)
       (multiinsertLR&co new oldL oldR (cdr lat)
                         (lambda (newlat L R)
                           (col (cons oldR (cons new newlat))
                                L
                                (add1 R)))))
      (else
       (multiinsertLR&co new oldL oldR (cdr lat)
                         (lambda (newlat L R)
                           (col (cons (car lat) newlat)
                                L
                                R)))))))
; test:
(newline)
(define col-2
  (lambda (x y z)
    (list 'col x y z)))
(multiinsertLR&co 'salty 'fish 'chips
                  '(chips and fish or fish and chips) col-2)

;
(define evens-only*
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (cons (car l) (evens-only* (cdr l))))
         (else
          (evens-only* (cdr l)))))
      (else
       (cons (evens-only* (car l))
             (evens-only* (cdr l)))))))
; test:
(newline)
(evens-only* '(1 2 3 4))
(evens-only* '((1 2) (3 4)))
(evens-only* '(((1) 2) 3 (((4)))))
(evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))

; this is a evens-only*&co made by myself,
;   which definition is totally different than the one from the book.
(define evens-only*&co
  (lambda (l col)
    (cond
      ((null? l)
       (col (quote ()) (quote ())))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (evens-only*&co (cdr l)
                         (lambda (evens odds)
                           (col (cons (car l) evens)
                                odds))))
         (else
          (evens-only*&co (cdr l)
                         (lambda (evens odds)
                           (col evens
                                (cons (car l) odds)))))))
      (else
       (evens-only*&co (append (car l) (cdr l))
                       col)))))
; test:
(newline)
(evens-only*&co '() collector)
(evens-only*&co '(1 2 3 4) collector)
(evens-only*&co '((1) ((2)) (((3))) ((((4))))) collector)

; this is from the book
(define evens-only*&co
  (lambda (l col)
    (cond
      ((null? l)
       (col (quote ()) 1 0))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (evens-only*&co (cdr l)
                          (lambda (newl p s)
                            (col (cons (car l) newl)
                                 (* (car l) p) s))))
         (else
          (evens-only*&co (cdr l)
                          (lambda (newl p s)
                            (col newl
                                 p (+ (car l) s)))))))
      (else
       (evens-only*&co (cdr l)
                       (lambda (al ap as)
                         (evens-only*&co (cdr l)
                                         (lambda (dl dp ds)
                                           (col (cons al dl)
                                                (* ap dp)
                                                (+ as ds))))))))))
; test:
(newline)
(evens-only*&co '() col-2)       ; (col () 1 0)
(evens-only*&co '(1) col-2)      ; (col () 1 1)
(evens-only*&co '(1 2) col-2)    ; (col (2) 2 1)
(evens-only*&co '(1 2 3) col-2)  ; (col (2) 2 4)
(evens-only*&co '(()) col-2)     ; (col '(()) 1 0)


; ------------------------------------------------------------------------------