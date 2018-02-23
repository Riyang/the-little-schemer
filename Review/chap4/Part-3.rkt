; ----------------------------------- Part 3 -----------------------------------

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
(define o*
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else
       (o+ n (o* n (sub1 m)))))))

;
(define o>
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #f)
      ((zero? n) #f)
      ((zero? m) #t)
      (else
       (o> (sub1 n) (sub1 m))))))
; test:
(newline)
(o> 12 133)
(o> 120 11)
(o> 13 14)
(o> 14 13)
(o> 233 250)

(define o<
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #f)
      ((zero? n) #t)
      ((zero? m) #f)
      (else
       (o< (sub1 n) (sub1 m))))))
; test:
(newline)
(o< 4 6)
(o< 8 3)
(o< 6 6)
(o< 0 0)
(o< 1 0)
(o< 2 4)

(define o=
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #t)
      ((zero? n) #f)
      ((zero? m) #f)
      (else
       (o= (sub1 n) (sub1 m))))))
; test:
(newline)
(o= 0 0)
(o= 0 1)
(o= 1 0)
(o= 1 1)

; rewrite o= using o< and o>
(define o=
  (lambda (n m)
    (cond
      ((o> n m) #f)
      ((o< n m) #f)
      (else #t))))

(define ^
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else
       (o* n (^ n (sub1 m)))))))
; test:
(newline)
(^ 1 1)
(^ 2 3)
(^ 5 3)
(o- (^ 4 4) (expt 4 4))

(define o/
  (lambda (n m)
    (cond
      ((o< n m) 0)
      (else
       (add1 (o/ (o- n m) m))))))
; test:
(newline)
(o/ 15 4)
(o/ 16 4)
(o/ 60 5)
(o/ 44 4)


; ------------------------------------------------------------------------------