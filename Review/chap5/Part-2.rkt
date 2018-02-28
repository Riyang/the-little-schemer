; ----------------------------------- Part 2 -----------------------------------

; predefine
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l))
       (car l))
      (else
       (leftmost (car l))))))
; test:
(leftmost '((potato) (chips ((with) fish) (chips))))
(leftmost '(((hot) (tuna (and))) cheese))

(define rightmost
  (lambda (l)
    (cond
      ((atom? (car l))
       (cond
         ((null? (cdr l)) (car l))
         (else (rightmost (cdr l)))))
      ((null? (cdr l))
       (rightmost (car l)))
      (else
       (rightmost (cdr l))))))
; test:
(newline)
(rightmost '((potato) (chips ((with) fish) (chips))))
(rightmost '(((hot) (tuna (and))) cheese))


; ------------------------------------------------------------------------------