; ----------------------------------- Part 3 -----------------------------------

(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a)
       (multirember a (cdr lat)))
      (else
       (cons (car lat) (multirember a (cdr lat)))))))
; test:
(multirember 'cup
             '(coffee cup tea cup and hick cup))
(multirember 'vivi
             '(vivi I hope you always be happy vivi))

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons old
             (cons new
                   (multiinsertR new old (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertR new old (cdr lat)))))))
; test:
(multiinsertR 'vivi 'ex-girlfriend
              '(ex-girlfriend ex-girlfriend I was really like my ex-girlfriend))
(multiinsertR 'tree 'apple
              '(apple apple there is an apple))

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new
             (cons old
                   (multiinsertL new old (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertL new old (cdr lat)))))))
; test:
(multiinsertL 'the-girl 'vivi
              '(there are many times that I dreamed about vivi yes vivi))
(multiinsertL 'eat 'apples
              '(I like apples I really like apples))
(multiinsertL 'stay-with 'friends
              '(but I would rather like friends really like friends))

(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new
             (multisubst new old (cdr lat))))
      (else
       (cons (car lat)
             (multisubst new old (cdr lat)))))))
; test:
(multisubst 'vivi 'you
            '(you I hope you always be happy and healthy))
(multisubst 'vivi 'you
            '(you vivi good luck to you))
(multisubst 'vivi 'ex-girlfriend
            '(my ex-girlfriend is very intelligent optimistic positive and fat))


; ------------------------------------------------------------------------------