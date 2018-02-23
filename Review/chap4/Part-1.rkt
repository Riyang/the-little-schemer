; ----------------------------------- Part 1 -----------------------------------

; predefine:
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

;
(atom? 14)
(number? -3)
(number? 3.14159)

;
(define add1
  (lambda (n)
    (+ n 1)))
; test:
(newline)
(add1 0)
(add1 4)
(add1 2017)
(add1 19)
(add1 1313)

;
(define sub1
  (lambda (n)
    (- n 1)))
; test:
(newline)
(sub1 1)
(sub1 234)
(sub1 251)
(sub1 405)
(sub1 2018)

;
(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else
       (add1 (o+ n (sub1 m)))))))
; test:
(newline)
(o+ 46 12)
(define vi 6)
(o+ vi vi)
(define I-miss-you 14)
I-miss-you
(define happy-new-year 2004)
(o+ I-miss-you happy-new-year)

;
(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else
       (sub1 (o- n (sub1 m)))))))
; test:
(newline)
(o- 46 12)
(o- vi vi)
(define move-on 123)
(define forget-about 100)
(define and (o- move-on 122))
(o- forget-about vi)
(o+ and move-on)

(newline)
(display "Happy New Year!")
(display "    ---- 2018-2-16 00:05:23")

; some words from The Little Schemer:
;   1. the only numbers we use here are
;      the nonnegative integers (i.e., 0, 1, 2, 3, ...)
;   2. we can treat zero? like null?
;      since zero? asks if a number is empty
;      and null? asks if a list is empty
;   3. cons builds lists and add1 builds numbers


; ------------------------------------------------------------------------------
