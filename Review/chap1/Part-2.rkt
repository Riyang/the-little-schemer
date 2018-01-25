; ----------------------------------- Part 2 -----------------------------------

(car '(a b c))
(car '((a b c) x y z))
; (car 'hotdog)        ; no answer
; (car '())            ; no answer
(newline)

(car '(vi vi jiang))
(car '((vi vi jiang) are you happy))
(newline)

; --------------------------------
;         The Law of Car
;   The primitive car is defined
;   only for non-empty lists.
; --------------------------------

(car '(((hotdogs)) (and) (pickle) relish))
(car (car '(((hotdogs)) (and))))
(newline)

(car '(((you)) (donot) (know) me))
(car (car '(((you)) (donnot))))
(newline)

(cdr '(a b c))
(cdr '((a b c) x y z))
(cdr '(hamburger))
(cdr '((x) t r))
; (cdr 'hotdogs)        ; no answer
; (cdr '())             ; no answer
(newline)

(cdr '(vi vi jiang))
(cdr '((vi vi jiang) are you happy))
(cdr '(((you)) (donot) (know) me))
(cdr (car '(((you)) (donnot))))
(newline)

; ----------------------------------------
;             The Law of Cdr
;   The primitive cdr is defined only for
;   non-empty lists. The cdr of any non-
;   empty list is always another list.
; ----------------------------------------

(car (cdr '((b) (x y) ((c)))))
(cdr (cdr '((b) (x y) ((c)))))
; (cdr (car '(a (b (c)) d)))    ; no answer
(newline)

(car (cdr '((families) (adults children) ((me)))))
(cdr (cdr '((families) (adults children) ((me)))))
(newline)

(cons 'peanut '(butter and jelly))
; (cons a l)
; Read: "cons the atom a onto the list l."
(newline)

(cons 'daughters '(she and me))
(newline)

(cons '(banana and) '(peanut butter and jelly))
(cons '((help) this) '(is very ((hard) to learn)))
; (cons s l)
; Read: "cons the S-expression s onto the list l."
(newline)

(cons '(parents and) '(daughters wife and me))
(cons '((take) me) '(to your ((heart))))
(newline)

(cons '(a b (c)) '())
(cons 'a '())
; (cons '((a b c)) b)        ; no answer
; (cons 'a 'b)               ; no answer
(newline)

(cons '(you and (me)) '())
(cons 'you '())
(newline)

(cons 'a (car '((b) c d)))
(cons 'a (cdr '((b) c d)))
(newline)

(cons 'vivi (car '((you) with me)))
(cons 'vivi (cdr '((you) with me)))

; ------------------------------------------
;             The Law of Cons
;   The primitive cons takes two arguments.
;   The second argument to cons must be a
;   list. The result is a list.
; ------------------------------------------

; ------------------------------------------------------------------------------