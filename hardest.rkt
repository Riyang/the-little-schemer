;; The Hardest Concepts/Thinkings of <The Little Schemer>:
;;
; predefined:
(define make-list
  (lambda (a . l)
    (cons a l)))
;
(define hardest
  (lambda (chap)
    (cond
      ((equal? chap 'chap8)
       (make-list '(multirember&co a lat col)
                  '(multiremberLR&co new oldL oldR lat col)
                  '(evens-only*&co l col)))
      ((equal? chap 'chap9)
       (make-list '(C n)
                  '(A n m)
                  '(lambda (mk-length)
                     (mk-length mk-length))
                  'Y-combinator))
      ((equal? chap 'chap10)
       (make-list '(lookup-in-table name table table-f)
                  '(*application e table)
                  '(apply-closure closure vals)))
      (else
       (display "There's no hardest thinkings.")))))
; test:
(hardest 'chap7)
(hardest 'chap8)
(hardest 'chap9)
(hardest 'chap10)
