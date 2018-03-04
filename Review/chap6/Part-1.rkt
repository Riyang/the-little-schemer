; ----------------------------------- Part 1 -----------------------------------

; predefine
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp)
       (number? aexp))
      ((eq? (car (cdr aexp)) (quote +))
       (and (numbered? (car aexp))
            (numbered? (caddr aexp))))
      ((eq? (car (cdr aexp)) (quote -))
       (and (numbered? (car aexp))
            (numbered? (caddr aexp))))
      (else
       (and (numbered? (car aexp))
            (numbered? (caddr aexp)))))))
; test:
(newline)
(numbered? 0)
(numbered? '(1 + 2))
(numbered? '(3 * 4))
(numbered? '(5 expt 6))
(numbered? '((1 + 2) + (3 * 4)))
; numbered? is true only for: numbers or two numbers combined by +, -, or expt.
; simplify it
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp)
       (number? aexp))
      ((or (eq? (cadr aexp) (quote +))
           (eq? (cadr aexp) (quote *)))
       (and (numbered? (car aexp))
            (numbered? (caddr aexp))))
      (else
       (and (numbered? (car aexp))
            (numbered? (car aexp)))))))
; test:
(newline)
(numbered? 0)
(numbered? '(1 + 2))
(numbered? '(3 * 4))
(numbered? '(5 expt 6))
(numbered? '((1 + 2) + (3 * 4)))
; simplify again
(define first car)
(define second cadr)
(define third caddr)
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp)
       (number? aexp))
      ((or (eq? (second aexp) (quote +))
           (eq? (second aexp) (quote *)))
       (and (numbered? (first aexp))
            (numbered? (third aexp))))
      (else
       (and (numbered? (first aexp))
            (numbered? (third aexp)))))))
; test:
(newline)
(numbered? 0)
(numbered? '(1 + 2))
(numbered? '(3 * 4))
(numbered? '(5 expt 6))
(numbered? '((1 + 2) + (3 * 4)))
; generalized numbered?
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp)
       (number? aexp))
      ((= (length aexp) 3)
       (cond
         ((or (eq? (second aexp) (quote +))
              (eq? (second aexp) (quote *))
              (eq? (second aexp) (quote expt)))
          (and (numbered? (first aexp))
               (numbered? (third aexp))))
         (else #f)))
      (else #f))))
; test:
(newline)
(numbered? 0)
(numbered? '(1 + 2))
(numbered? '(3 * 4))
(numbered? '(5 expt 6))
(numbered? '((1 + 2) + (3 * 4)))
(numbered? 'a)
(numbered? '(a + b))
(numbered? '(1))
(numbered? '(2 3))
(numbered? '(1 +))
(numbered? '(+ 2))
(numbered? '((1 + 2) 3))

; Well, when aexp is an arithmetic expression in (numbered? aexp),
; then we can simply numbered?
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp)
       (number? aexp))
      (else
       (and (numbered? (first aexp))
            (numbered? (third aexp)))))))

;
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (second nexp) (quote +))
       (+ (value (first nexp))
          (value (third nexp))))
      ((eq? (second nexp) (quote *))
       (* (value (first nexp))
          (value (third nexp))))
      (else
       (expt (value (first nexp))
             (value (third nexp)))))))
; test:
(newline)
(value 0)
(value '(1 + 2))
(value '(3 * 4))
(value '(2 expt 4))

; value for number S-expressions
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (first nexp) (quote +))
       (+ (value (second nexp))
          (value (third nexp))))
      ((eq? (first nexp) (quote *))
       (* (value (second nexp))
          (value (third nexp))))
      (else
       (expt (value (second nexp))
             (value (third nexp)))))))
; test:
(newline)
(value 0)
(value '(+ 1 2))
(value '(* 3 4))
(value '(expt 2 4))

; use help-functions to simplify value
(define opterator
  (lambda (aexp)
    (car aexp)))
(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))
(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) (quote +))
       (+ (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp))))
      ((eq? (operator nexp) (quote *))
       (* (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp))))
      (else
       (expt (value (1st-sub-exp nexp))
             (value (2nd-sub-exp nexp)))))))


; ------------------------------------------------------------------------------