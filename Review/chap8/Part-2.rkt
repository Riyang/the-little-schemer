; ----------------------------------- Part 2 -----------------------------------


; The power of abstraction

(define insertL-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) (quote ()))
        ((test? (car l) old)
         (cons new (cons old (cdr l))))
        (else
         (cons (car l)
               ((insertL-f test?) new old (cdr l))))))))
; test:
(newline)
((insertL-f =) '1 '2 '(2 3))
((insertL-f eq?) 'one 'two '(two three))

(define insertR-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) (quote ()))
        ((test? (car l) old)
         (cons old (cons new (cdr l))))
        (else
         (cons (car l)
               ((insertR-f test?) new old (cdr l))))))))
; test:
(newline)
((insertR-f =) '5 '4 '(4 6))
((insertR-f eq?) 'six 'five '(four five))
((insertR-f equal?) '(like) '(I) '((I) (my grandfather)))

(define seqL
  (lambda (new old l)
    (cons new (cons old l))))
(define seqR
  (lambda (new old l)
    (cons old (cons new l))))
(define insert-g
  (lambda (seq)
    (lambda (new old l)
      (cond
        ((null? l) (quote ()))
        ((eq? (car l) old)
         (seq new old (cdr l)))
        (else
         (cons (car l)
               ((insert-g seq) new old (cdr l))))))))
; test:
(newline)
(define insertL (insert-g seqL))
(insertL 'a 'b '(b c))
(define insertR (insert-g seqR))
(insertR 'y 'x '(x z))

(newline)
(define insertL
  (insert-g
   (lambda (new old l)
     (cons new (cons old l)))))
(insertL 'a 'b '(b c))
(define insertR
  (insert-g
   (lambda (new old l)
     (cons old (cons new l)))))
(insertR 'y 'x '(x z))

(define subst
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((eq? (car l) old)
       (cons new (cdr l)))
      (else
       (cons (car l)
             (subst new old (cdr l)))))))
; test:
(newline)
(subst 'atom 'antom '(S-expression: antom list))
(define seqS
  (lambda (new old l)
    (cons new l)))
(define subst (insert-g seqS))
; test:
(newline)
(subst 'atom 'antom '(S-expression: antom list))

(define yyy
  (lambda (a l)
    ((insert-g seqrem) #f a l)))  ; #f doesn't matter, it can be anything
(define seqrem
  (lambda (new old l)
    l))
; test:
(newline)
(yyy 'a '(a b c))

; ---------------------------------------------
;           The Ninth Commandment
; Abstract common patterns with a new function.
; ---------------------------------------------


; ------------------------------------------------------------------------------