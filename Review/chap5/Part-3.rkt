; ----------------------------------- Part 3 -----------------------------------

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


(newline)
(and (atom? (car '(mozzarella pizza)))
     (eq? (car '(mozzarella pizza)) 'pizza))
(and (atom? (car '((mozzarella mushroom) pizza)))
     (eq? (car '((mozzarella mushroom))) 'pizza))
(and (atom? (car '(pizza)))
     (eq? (car '(pizza)) 'pizza))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((null? l1) #f)
      ((null? l2) #f)
      (else
       (cond
         ((and (atom? (car l1)) (atom? (car l2)))
          (and (eq? (car l1) (car l2))
               (eqlist? (cdr l1) (cdr l2))))
         ((atom? (car l1)) #f)
         ((atom? (car l2)) #f)
         (else
          (and (eqlist? (car l1) (car l2))
               (eqlist? (cdr l1) (cdr l2)))))))))
; test:
(newline)
(eqlist? '(strawberry ice cream)
         '(strawberry ice cream))
(eqlist? '(banana ((split)))
         '((banana) (split)))
(eqlist? '(beef ((sausage)) (and (soda)))
         '(beef ((salami)) (and (soda))))
(eqlist? '(beef ((sausage)) (and (soda)))
         '(beef ((sausage)) (and (soda))))

; the 9 full conditions of eqlist?
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((null? l1)
       (cond
         ((null? l2) #t)
         ((atom? (car l2)) #f)
         (else #f)))
      ((atom? (car l1))
       (cond
         ((null? l2) #f)
         ((atom? (car l2))
          (and (eq? (car l1) (car l2))
               (eqlist? (cdr l1) (cdr l2))))
         (else #f)))
      (else
       (cond
         ((null? l2) #f)
         ((atom? l2) #f)
         (else
          (and (eqlist? (car l1) (car l2))
               (eqlist? (cdr l1) (cdr l2)))))))))
; simplify 9 conditions to 5 questions
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)  ; one condition
      ((or (null? l1) (null? l2)) #f)   ; four conditions
      ((and (atom? (car l1)) (atom? (car l2)))
       (and (eq? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2))))  ; one condition
      ((or (atom? l1) (atom? l2)) #f)      ; two conditions
      (else                                ; one condition
       (and (eqlist? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2)))))))

(define equal?
  (lambda (s1 s2)
    (cond
      ((atom? s1)
       (cond
         ((atom? s2) (eqan? s1 s2))
         (else #f)))
      (else
       (cond
         ((atom? s2) #f)
         (else (eqlist? s1 s2)))))))
; simplify it:
(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2))
       (eqan? s1 s2))
      ((or (atom? s1) (atom? s2))
       #f)
      (else
       (eqlist? s1 s2)))))

; rewrite eqlist? using equal?
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else
       (and (equal? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2)))))))

(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote ()))
      ((equal? (car l) s) (cdr l))
      (else
       (cons (car l) (rember s (cdr l)))))))

; --------------------------------------------
; The Sixth Comandment
; Simplify only after the function is correct.
; --------------------------------------------

; ------------------------------------------------------------------------------