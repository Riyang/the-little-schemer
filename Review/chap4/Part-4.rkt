; ----------------------------------- Part 4 -----------------------------------

; predefine
(define add1
  (lambda (n)
    (+ n 1)))
(define sub1
  (lambda (n)
    (- n 1)))
(define o=
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #t)
      ((zero? n) #f)
      ((zero? m) #f)
      (else
       (o= (sub1 n) (sub1 m))))))

;
;(define length  ; length is primitive
;  (lambda (lat)
;    (cond
;      ((null? lat) 0)
;      (else
;       (add1 (length (cdr lat)))))))
; test:
(length '(hotdogs with mustard sauerkraut and pickles))
(length '(ham and cheese on rye))
(length '(a girl and a boy))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else
       (pick (sub1 n) (cdr lat))))))
; test:
(newline)
(pick 4
      '(lasagna spaghetti ravioli macaroni meatball))
(pick 6
      '(u v w x y z))
(pick 8
      '(happy new year my friends my classmates my roomates))

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else
       (cons (car lat)
             (rempick (sub1 n) (cdr lat)))))))
; test:
(newline)
(rempick 3
         '(hotdogs with hot mustard))
(rempick 4
         '(apple banana orange peach strawberry))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat))
       (no-nums (cdr lat)))
      (else
       (cons (car lat)
             (no-nums (cdr lat)))))))
; test:
(newline)
(no-nums '(5 pears 6 prunes 9 dates))
(no-nums '(1 one 2 two 3 three 4 four))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat))
       (cons (car lat)
             (all-nums (cdr lat))))
      (else
       (all-nums (cdr lat))))))
; test:
(newline)
(all-nums '(5 pears 6 prunes 9 dates))
(all-nums '(1 one 2 two 3 three 4 four))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2))
       (= a1 a2))
      ((or (number? a1) (number? a2))
       #f)
      (else
       (eq? a1 a2)))))
; test:
(newline)
(eqan? 'atom 'atom)
(eqan? 0 0)
(eqan? 1 2)
(eqan? 'ato 'atom)

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eqan? (car lat) a)
       (add1 (occur a (cdr lat))))
      (else
       (occur a (cdr lat))))))
; test:
(newline)
(occur 'a
       '(a cat a dog and an apple))
(occur 'apple
       '(an apple two apples three apples the apple))

(define one?
  (lambda (n)
    (o= n 1)))
; test:
(newline)
(one? 1)
(one? 0)
(one? 2)

(define rempick
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else
       (cons (car lat)
             (rempick (sub1 n) (cdr lat)))))))
; test:
(newline)
(rempick 3
         '(hotdogs with hot mustard))
(rempick 4
         '(apple banana orange peach strawberry))


; ------------------------------------------------------------------------------