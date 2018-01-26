; ----------------------------------- Part 1 -----------------------------------

; predefine:
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; Is (Jack Sprat could eat no chicken fat) a lat?
; Yes.
; Is ((Jack) Sprat could eat no chicken fat) a lat?
; No, because the first element (Jack) is a list.
; So what is a lat?
; Well, a lat is a list of atoms.
; But, how can we define a lat?
; or, how can we determine a list is a lat?
; Here it is:

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

(lat? '(bacon and eggs))
(lat? '(bacon (and eggs)))
(lat? '())
(newline)

; --------------------------------------------------------
; another definition of lat? ,
;  which use "and", which not introduced yet in chapter 2.
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      (else
       (and (atom? (car l))
            (lat? (cdr l)))))))
; --------------------------------------------------------

(lat? '(bacon and eggs))
(lat? '(bacon (and eggs)))
(lat? '())
(newline)

; some examples created by myself:
(lat? '(vivi))
(lat? '((vivi)))
(lat? '(who is vivi?))
(lat? '(my ex-girlfriend))
(lat? '(so you still miss her?))
(lat? '(no but she still has some (shadow) in my heart))
(lat? '(I have over her 95 percents))
(lat? '(the last 5 percents will be over))
(lat? '(until I start a new relationship))
(lat? '(are you ((happy)) now?))
(lat? '(I mean are you happy?))
(lat? '(no but I am not sad by the way))
(lat? '(not happy not sad just nothing feelings like the air))
(lat? '(well see you next time))
(lat? '(I hope you can be (cheer up) next time))
(lat? '(well thank you))

; some words from the book:
; (cond ...) asks questions,
; (lambda ...) creates a function, and
; (define ...) gives it a name.
;
; else is a special question, which is always true.
;
; "lat? looks at each S-expression in a list, in turn,
;  and asks if each S-expression is an atom, until it
;  runs out of S-expressions. If it runs out without
;  encountering a list, the value is #t. If it finds
;  a list, the value is #f--false."
; "(lat? l) looks at each item in its argument to see
;  if it is an atom. If it runs out of items before it
;  finds a list, as it did in the example
;  (bacon (and eggs)), the value of (lat? l) is #f."


; ------------------------------------------------------------------------------