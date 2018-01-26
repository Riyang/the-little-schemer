; ----------------------------------- Part 2 -----------------------------------

; predefine:
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(or (null? '()) (atom? '(d e f g)))
; True, because the first question (null? '()) is true.
(or (null? '(a b c)) (null? '()))
; True, because the second question (null? '()) is true.
(or (null? '(a b c)) (null? '(atom)))
; False,
;   because neithor (null? '(a b c)) nor (null? '(atom)) is ture.
(newline)

; What does (or ...) do?
; "(or (...) (...)) asks two questions, one at a time.
;  If the first one is true, it stops and answer true.
;  Otherwise it asks the second question and answers
;  with whatever the second question answers."

; some examples created by myself:
(define want?
  (lambda (x)
    (cond
      ((eq? x 'daughter) #t)
      (else #f))))
(define favourite-subject?
  (lambda (x)
    (cond
      ((eq? x 'mathematics) #t)
      ((eq? x 'math) #t)
      (else #f))))

(or (want? 'son) (want? 'daughter))
(or (want? 'daughter) (want? 'mathematics))
(or (want? 'son) (favourite-subject? 'mathematics))
(or (favourite-subject? 'chemistry) (want? 'son))

; ------------------------------------------------------------------------------