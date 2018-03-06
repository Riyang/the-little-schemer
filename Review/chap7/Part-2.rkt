; ----------------------------------- Part 2 -----------------------------------

; predefine
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else
       (or (equal? (car lat) a)
           (member? a (cdr lat)))))))
(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((member? (car set1) set2)
       (cons (car set1) (intersect (cdr set1) set2)))
      (else
       (intersect (cdr set1) set2)))))

(define xxx
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((member? (car set1) set2)
       (xxx (cdr set1) set2))
      (else
       (cons (car set1)
             (xxx (cdr set1) set2))))))
; test:
(newline)
(xxx '(a b) '(b c d))
(xxx '(a b c) '(b c d))

; what is the function xxx?
; --------
; My answer:
; It makes a list,
; and its elements are any element which in set1 but not in set2.
; --------
; From the book:
; "It is a function that returns all the atoms
;  in set1 that are not in set2."
; That is, xxx is the (set) difference function.
; --------

(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set))
       (car l-set))
      (else
       (intersectall (cons (intersect (car l-set) (cadr l-set))
                           (cddr l-set)))))))
; test:
(newline)
(intersectall '((a b)))
(intersectall '((a b)
                (b c)))
(intersectall '((a b c)
                (c a d e)
                (e f g h a b)))

; the defination of intersectall from the book:
(define intersectall  ; better than mine
  (lambda (l-set)
    (cond
      ((null? (cdr l-set))
       (car l-set))
      (else
       (intersect (car l-set)
                  (intersectall (cdr l-set)))))))
; test:
(newline)
(intersectall '((a b)))
(intersectall '((a b)
                (b c)))
(intersectall '((a b c)
                (c a d e)
                (e f g h a b)))






; ------------------------------------------------------------------------------