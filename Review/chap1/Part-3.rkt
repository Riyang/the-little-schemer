; ----------------------------------- Part 3 -----------------------------------
; predefine:
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(null? '())
(null? (quote ()))
(null? '(a b c))
(null? '(you and me))
; (null? 'spaghetti)    ; no answer
(newline)

; ---------------------------
;     The Law of Null?
;   The primitive null? is
;   defined only for lists.
; ---------------------------

(atom? 'Harry)
(atom? '(Harry had a heap of apples))
(newline)

(atom? 'Vivi)
(atom? '(Vivi has a heart of charming beautifull things))
(newline)

(atom? (car '(Harry had a heap of apples)))
(atom? (cdr '(Harry had a heap of apples)))
(atom? (cdr '(Harry)))
(atom? (car (cdr '(swing low sweet cherry oat))))
(atom? (car (cdr '(swing (low sweet) cherry oat))))
(newline)

(atom? (car '(Vivi has a perfect heart for me)))
(atom? (cdr '(Vivi has a perfect heart for me)))
(atom? (cdr '(Vivi)))
(atom? (car (cdr '(the teeny tiny possibility))))
(atom? (car (cdr '(the (teeny tiny) possibility))))
(newline)

(eq? 'Harry 'Harry)
(eq? 'margarine 'butter)
; (eq? '() '(strawberry))    ; no answer
; (eq? 6 7)                  ; no answer
(newline)

(eq? 'Vivi 'Vivi)
(eq? 'girlfriend 'wife)
(newline)

; ------------------------------------------
;             The Law of Eq?
;   The primitive eq? takes two arguments.
;   Each must be a non-numeric atom.
; ------------------------------------------

(eq? (car '(Mary had a little lamb chop)) 'Mary)
; (eq? (cdr '(soured milk)) 'milk)    ; no answer
(eq? (car '(beans beans we need jelly beans))
     (car (cdr '(beans beans we need jelly beans))))
(newline)

(eq? (car '(Vivi has a pair of bright eyes.)) 'Vivi)
(eq? (car '(daugters daugters I need little daugters))
     (car (cdr '(daugters daugters I need little daugters))))

; ------------------------------------------------------------------------------