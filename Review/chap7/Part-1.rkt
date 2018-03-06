; ----------------------------------- Part 1 -----------------------------------

; predefine
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else
       (or (equal? (car lat) a)
           (member? a (cdr lat)))))))
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((equal? (car lat) a)
       (multirember a (cdr lat)))
      (else
       (cons (car lat) (multirember a (cdr lat)))))))

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      (else
       (and (not (member? (car lat) (cdr lat)))
            (set? (cdr lat)))))))
; test:
(newline)
(set? '(apple peaches apple plum))
(set? '(apples peaches pears plums))
(set? '(apple 3 pear 4 9 apple 3 4))

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      (else
       (cond
         ((member? (car lat) (cdr lat))
          #f)
         (else
          (set? (cdr lat))))))))
; simplify it
(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else
       (set? (cdr lat))))))
; test:
(newline)
(set? '(apple peaches apple plum))
(set? '(apples peaches pears plums))
(set? '(apple 3 pear 4 9 apple 3 4))

(define makeset  ; recursive method
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else
       (cond
         ((member? (car lat) (cdr lat))
          (cons (car lat)
                (makeset (multirember (car lat) (cdr lat)))))
         (else
          (cons (car lat)
                (makeset (cdr lat)))))))))
; test:
(newline)
(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(apple 3 peach 4 9 apple 3 4))

(define makeset  ; iterative method
  (lambda (lat)
    (cond
      ((set? lat) lat)
      (else
       (cond
         ((member? (car lat) (cdr lat))
          (makeset (cons (car lat)
                         (multirember (car lat) (cdr lat)))))
         (else
          (cons (car lat)
                (makeset (cdr lat)))))))))
; test:
(newline)
(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(apple 3 peach 4 9 apple 3 4))

(define makeset  ; from the book
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((member? (car lat) (cdr lat))
       (makeset (cdr lat)))
      (else
       (cons (car lat)
             (makeset (cdr lat)))))))
; test:
(newline)
(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(apple 3 peach 4 9 apple 3 4))

; Rewrite makeset using multirember
(define makeset
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else
       (cons (car lat)
             (makeset (multirember (car lat) (cdr lat))))))))
; test:
(newline)
(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(apple 3 peach 4 9 apple 3 4))

; From the book:
; "The function makeset remembers to cons
;  the first atom in the lat onto the result of
;  the natural recursion, after removing all
;  occurrences of the first atom from the rest
;  of the lat."

; the final version of makeset
(define makeset
  (lambda (lat)
    (cond
      ((set? lat) lat)
      (else
       (cons (car lat)
             (makeset (multirember (car lat) (cdr lat))))))))
; test:
(newline)
(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(apple 3 peach 4 9 apple 3 4))

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      ((member? (car set1) set2)
       (subset? (cdr set1) set2))
      (else #f))))
; test:
(newline)
(subset? '(5 chicken wings)
         '(5 hamburgers
           2 pieces fried chicken and
           light duckling wings))
(subset? '(4 pounds of horseradish)
         '(four pounds chicken and
           5 ounces horseradish))
; use (and ...) to rewrite subset?
(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else
       (and (member? (car set1) set2)
            (subset? (cdr set1) set2))))))

(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2)
         (subset? set2 set1))))
; test:
(newline)
(eqset? '(6 large chickens with wings)
        '(6 chickens with large wings))

(define intersect?
  (lambda (set1 set2)
    (cond
      ((and (null? set1) (null? set2))
       #t)
      ((or (null? set1) (null? set2))
       #f)
      (else
       (or (member? (car set1) set2)
           (intersect? (cdr set1) set2))))))
; test:
(newline)
(intersect? '(stewed tomatoes and macaroni)
            '(macaroni and cheese))

(define intersect
  (lambda (set1 set2)
    (cond
      ((or (null? set1) (null? set2))
       (quote ()))
      (else
       (cond
         ((member? (car set1) set2)
          (cons (car set1) (intersect (cdr set1) set2)))
         (else
          (intersect (cdr set1) set2)))))))
; simplify it
(define intersect
  (lambda (set1 set2)
    (cond
      ((or (null? set1) (null? set2))
       (quote ()))
      ((member? (car set1) set2)
       (cons (car set1) (intersect (cdr set1) set2)))
      (else
       (intersect (cdr set1) set2)))))
; test:
(newline)
(intersect '(stewed tomatoes and macaroni)
           '(macaroni and cheese))

; what about these definations of intersect:
(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1)
       (cond
         ((null? set2) (quote ()))
         (else (quote ()))))
      (else
       (cond
         ((null? set2) (quote ()))
         (else
          (cond
            ((member? (car set1) set2)
             (cons (car set1) (intersect (cdr set1) set2)))
            (else
             (intersect (cdr set1) set2)))))))))
(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((null? set2) (quote ()))
      (else
       (cond
         ((member? (car set1) set2)
          (cons (car set1) (intersect (cdr set1) set2)))
         (else
          (intersect (cdr set1) set2)))))))
; test:
(newline)
(intersect '(stewed tomatoes and macaroni)
           '(macaroni and cheese))

; the defination of intersect from the book:
(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((member? (car set1) set2)
       (cons (car set1) (intersect (cdr set1) set2)))
      (else
       (intersect (cdr set1) set2)))))
; test:
(newline)
(intersect '(stewed tomatoes and macaroni)
           '(macaroni and cheese))

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2)
       (union (cdr set1) set2))
      (else
       (cons (car set1)
             (union (cdr set1) set2))))))
; test:
(newline)
(union '(stewed tomatoes and macaroni casserole)
       '(macaroni and cheese))
; '(stewed tomatoes casserole macaroni and cheese)

; another method, which makes the union list in another order:
(define union
  (lambda (set1 set2)
    (cond
      ((null? set2) set1)
      ((member? (car set2) set1)
       (union set1 (cdr set2)))
      (else
       (cons (car set2)
             (union set1 (cdr set2)))))))
; test:
(newline)
(union '(stewed tomatoes and macaroni casserole)
       '(macaroni and cheese))


; ------------------------------------------------------------------------------