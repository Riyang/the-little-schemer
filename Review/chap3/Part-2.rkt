; ----------------------------------- Part 2 -----------------------------------

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons old (cons new (cdr lat))))
      (else
       (cons (car lat) (insertR new old (cdr lat)))))))
; test:
(insertR 'one 'plus
         '(one plus equals two))
(insertR '26 'or
         '(are you 25 or ?))

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new (cons old (cdr lat))))
      (else
       (cons (car lat) (insertL new old (cdr lat)))))))
; test:
(newline)
(insertL 'important 'of
         '(what is the most of your heart?))
(insertL 'and 'friends
         '(of course my families friends))


(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new (cdr lat)))
      (else
       (cons (car lat) (subst new old (cdr lat)))))))
; test:
(newline)
(subst 'warm 'f**k
       '(vivi I want to f**k you))
(subst 'vivi 'the-girl
       '(I miss the girl the-girl))
(subst 'my-future-daughter 'you
       '(you will be my angel))
(subst 'beautiful-flowers 'flowers
       '(my students you are the little flowers in my life))

(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) (quote ()))
      ((or (eq? (car lat) o1)
           (eq? (car lat) o2))
       (cons new (cdr lat)))
      (else
       (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))
; test:
(newline)
(subst2 'yourself 'her 'vivi
        '(make vivi better))
(subst2 'better 'best 'and
        '(best for your families and your friends))

; ------------------------------------------------------------------------------