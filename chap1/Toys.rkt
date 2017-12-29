; Chapter 1. Toys

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; ---- about atom ----
(atom? 'atom)                ; Yes, cause 'atom is a string.
(atom? 'turkey)              ; Yes, cause 'turkey is a string.
(atom? '1492)                ; Yes, cause 1492 is a number.
(atom? 'u)                   ; Yes, cause 'u is single string.
(atom? '*abc$)               ; Yes, cause '*abc$ is an ugly string.

; ---- about list ----
(list? '(atom))              ; Yes, cause (atom) ia an atom enclosed by parentheses.
(list? '(atom turkey or))    ; Yes, because it is a collection of atoms
                             ; enclosed by pareentheses.
; '(atom turkey) or   is a list?  ;No
(list? '((atom turkey) or))  ; Yes, because the two S-expressions
                             ; are now enclosed by parentheses.
; something more:
(list? '())                  ; Yes, it is the empty list.
(atom? '())                  ; No, it is just a list, not an atom.
                             ; Every list is not an atom.
(list? '(() () () ()))       ; Yes, it is a list of four empty lists.

; ---- about car ----
; what is:
(car '(a b c))               ; a, because a is the first atom of (a b c).
(car '((a b c) x y z))       ; (a b c),
                             ; because (a b c) is the first S-expression of this list.
; What is (car 'hotdog)?     ; No answer, because
                             ; you can not ask for the car of an atom.
; What is (car '())?         ; No answer, because
                             ; you can not ask for the car of the empty list.
; So, in general:
; if l is a non-empty list, then (car l) is the first S-expression of l.
; Otherwise, (car l) is no answer.
; Thus, we got:
; The Law of Car:
; The primitive car is defined only for non-empty lists.

; ---- about cdr ----
; what is:
(cdr '(a b c))               ; (b c),
                             ;   because (b c) is the list l without (car l).
(cdr '((a b c) x y z))       ; (x y z)
(cdr '(hamburger))           ; ()
; What is (cdr 'hotdog)?     ; No answer, because
                             ; you can not ask for the cdr of an atom.
; What is (cdr '())?         ; No answer, because
                             ; you can not ask for the cdr of the null list.
; So, in general:
; if l is a non-empty list, then (cdr l) is the list l without (car l).
; Otherwise, (car l) is no answer.
; Thus, we got:
; The Law of Cdr:
; The primitive cdr is defined only for non-empty lists.
; The cdr of any non-empty list is always another list.
;
;
; try something more about car and cdr:
; what are they:
(car (cdr '((b) (x y) ((c)))))
(cdr (cdr '((b) (x y) ((c)))))
; (cdr (car '(a (b (c)) d)))
(car (car (cdr '(a (b (c)) d))))
(car (cdr (car (cdr '(a (b (c)) d)))))

; ---- about cons ----
; what is:
(cons 'a '(b c))             ; (a b c),
                             ;   because cons adds any S-expression to
                             ;   the front of a list
(cons 'peanut '(butter and jelly))  ; (peanut butter and jelly)
(cons '(banana and)
      '(peanut butter and jelly))   ; ((banana and) peanut butter and jelly)
(cons '((help) this)
      '(is very ((hard) to learn))) ; (((help) this) is very ((hard) to learn))
; something special:
(cons 'atom '())             ; (atom)
(cons '(atom) '())           ; ((atom))
(cons '((atom)) '())         ; (((atom)))
(cons 'atom '(()))           ; (atom ())
(cons '(atom) '(()))         ; ((atom) ())
(cons '() '())               ; (())
(cons '() '(()))             ; (() ())
; (cons '() 'atom)           ; No answer,
                             ;   since the second argument must be a list.
; So, in general:
; if l is a list,
; then (cons s l) is a new list that adds s to the front of l.
; Otherwise, (cons s l) is no answer.
; Thus, we got:
; The Law of Cons:
; The primitive cons takes two arguments.
; The second argument to cons must be a list. The result is a list.

; ---- about null? ----
; There is one, only one special list: the empty list, or, the null list.
; It looks like: (). But we use two method to express it:
; '() or (quote ()), well they are totally the same thing: ().
; If there is a list l, we ask whether it is the empty list or not.
; So, how could we do it?
; Well, we use the function null? to do it, just like this:
; (null? l)
; So, what is:
(null? '())                  ; True, since '() is the null list.
(null? (quote ()))           ; True, the same reason as above.
(null? '(a b c))             ; False, because it is a non-empty list.
(null? 'atom)                ; No answer,
                             ;   because you cannot ask null? of an atom.
; Thus, we got:
; The Law of null?:
; The primitive null? is defined only for lists.

; ---- about eq? ----
; True or false: a1 and a2 are the same atom
; where a1 is ViVi
; and a2 is ViVi
; True,
; because a1 is the atom ViVi and a2 is the atom ViVi.
; So,
(eq? 'ViVi 'ViVi)            ; True.
(eq? 'ViVi 'girlfriend)      ; False. They are different.
(eq? 'ViVi 'wife)            ; False again.
;
; How many arguments does eq? take  ; It takes two arguments.
; and what are they?                ; Both of them must be non-numeric atoms.

(eq? '() '(vivi))            ; No answer,
                             ;   () and (vivi) are lists.
(eq? 1 2)                    ; No answer,
                             ;   6 and 7 are numbers.

; -------- readme --------
;
; All the things above are come from the book <The Little schemer>,
; but I changed a little things on my understanding.
; Enjoy the book,
; enjoy the pictures of little elephants.
; :)
;
; -------- readme --------
