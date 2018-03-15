; ----------------------------------- Part 1 -----------------------------------


; predefine
(define pick
  (lambda (n lat)
    (cond
      ((= n 1) (car lat))
      (else
       (pick (- n 1) (cdr lat))))))

; this is made by myself
(define looking
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else
       (eq? (looking-help 1 lat) a)))))
(define looking-help
  (lambda (n lat)
    (cond
      ((not (number? (pick n lat)))
       (pick n lat))
      (else
       (looking-help (pick n lat) lat)))))

; test:
(newline)
(looking-help 1 '(2 3 4 5 6 7 8 9 zero))
(looking 'caviar '(6 2 4 caviar 5 7 3))
(looking 'caviar '(6 2 grits caviar 5 7 3))
(looking 'caviar '(6 2 4 caviar 5 7 3))

; this is from the book, maybe better
(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))
(define keep-looking
  (lambda (a n lat)
    (cond
      ((not (number? (pick n lat)))
       (eq? (pick n lat) a))
      (else
       (keep-looking a (pick n lat) lat)))))
; test:
(newline)
(looking 'caviar '(6 2 4 caviar 5 7 3))
(looking 'caviar '(6 2 grits caviar 5 7 3))
(looking 'caviar '(6 2 4 caviar 5 7 3))

; an interesting question:
; What kind of lats will make the looking an endless recursion?
; The answer is:
; when it can't get an non-numeric atom.
;   a circl loop, the values of numeric atoms of the lat and its sequences.
; let's see some examples:
; (looking 'zero '(1 zero))
; (looking 'zero '(2 1 zero))
; (looking 'zero '(2 3 1 zero))
; (looking 'zero '(3 zero 4 1))



; ------------------------------------------------------------------------------
