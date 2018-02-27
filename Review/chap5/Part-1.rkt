; ----------------------------------- Part 1 -----------------------------------

; predefine
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2))
       (= a1 a2))
      ((or (number? a1) (number? a2))
       #f)
      (else
       (eq? a1 a2)))))
(define add1
  (lambda (n)
    (+ n 1)))

(define rember*
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eqan? (car l) a) (rember* a (cdr l)))
         (else (cons (car l) (rember* a (cdr l))))))
      (else
       (cons (rember* a (car l))
             (rember* a (cdr l)))))))
; test:
(rember* 'cup
         '((coffee) cup ((tea) cup)
           (and (hick)) cup))
(rember* 'sauce
         '(((tomato sauce))
           ((bean) sauce)
           (and ((flying)) sauce)))

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eqan? (car l) old)
          (cons old (cons new (insertR* new old (cdr l)))))
         (else
          (cons (car l) (insertR* new old (cdr l))))))
      (else
       (cons (insertR* new old (car l))
             (insertR* new old (cdr l)))))))
; test:
(newline)
(insertR* 'roast 'chuck
          '((how much (wood))
            could
            ((a (wood) chuck))
            (((chuck)))
            (if (a) ((wood chuck)))
            could chuck wood))

;   The Fourth Commandment
;         (final version)
; Always change at least one argument while recurring.
; When recurring on a list of atoms, lat, use (cdr lat).
; When recurring on a number, n, use (sub1 n).
; And when recurring on a list of S-expressions, l,
; use (car l) and (cdr l), if neither (null? l) nor (atom? (car l)) are true.
; It must be changed to be closer to termination.
; The changing argument must be tested in the termination condition:
; when using cdr, test termination with null? and
; when using sub1, test termination with zero?.


(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond
         ((eqan? (car l) a)
          (add1 (occur* a (cdr l))))
         (else
          (occur* a (cdr l)))))
      (else
       (+ (occur* a (car l))
          (occur* a (cdr l)))))))
; test:
(newline)
(occur* 'banana
        '((banana)
          (split ((((banana)))
                  (cream (banana))
                  sherbet))
          (banana)
          (bread)
          (banana brandy)))

(define subst*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eqan? (car l) old)
          (cons new (subst* new old (cdr l))))
         (else
          (cons (car l) (subst* new old (cdr l))))))
      (else
       (cons (subst* new old (car l))
             (subst* new old (cdr l)))))))
; test:
(newline)
(subst* 'orange 'banana
        '((banana)
          (split ((((banana)))
                  (cream (banana))
                  sherbet))
          (banana)
          (bread)
          (banana brandy)))

(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eqan? (car l) old)
          (cons new (cons old (insertL* new old (cdr l)))))
         (else
          (cons (car l) (insertL* new old (cdr l))))))
      (else
       (cons (insertL* new old (car l))
             (insertL* new old (cdr l)))))))
; test:
(newline)
(insertL* 'pecker 'chuck
          '((how much (wood))
            could
            ((a (wood) chuck))
            (((chuck)))
            (if (a) ((wood chuck)))
            could chuck wood))

(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (cond
         ((eqan? (car l) a) #t)
         (else (member* a (cdr l)))))
      (else
       (or (member* a (car l))
           (member* a (cdr l)))))))
; test:
(newline)
(member* 'chips
         '((potato) (chips ((with) fish) (chips))))


; ------------------------------------------------------------------------------