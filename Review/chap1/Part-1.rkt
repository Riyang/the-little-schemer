; ----------------------------------- Part 1 -----------------------------------

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(atom? 'atom)
(atom? 'turkey)
(atom? 'r.yang)
(atom? 'vivi)
(newline)

(atom? '1492)
(atom? 'u)
(atom? '*abc$)
(newline)

(atom? '(atom))
(atom? '())
(newline)

(define test-list?
  (lambda (x)
    (if (null? x)
        #t
        (test-list? (cdr x)))))
(test-list? '())
(test-list? '(atom))
; (test-list? 'atom)    ; wrong! cdr is expected an pair or a list.

; (define list?
;   (lambda (x)
;     (cond
;       ((atom? x) #f)
;       ((null? x) #t)
;       (else (list? (cdr x))))))
; Cause list? is a primitive procedure(function) here.
; There's no need to redefine it.
; And if you did, DrRacket will give you a bug message.

(newline)
(list? '(atom))
(list? '(vivi))
(list? '(atom turkey or))
(list? '(vivi good luck))
(newline)

(list? '((atom turkey) or))
(list? '((vivi good) luck))
(newline)

(define S-expression?
  (lambda (x)
    (or (atom? x) (list? x))))

(S-expression? 'xyz)
(S-expression? '(x y z))
(newline)

(define how-many-S-expressions?
  (lambda (x)
    (cond
      ((atom? x) 1)
      ((list? x)
       (cond
         ((null? x) 0)
         (else (+ 1
                  (how-many-S-expressions? (cdr x)))))))))
(S-expression? '(how are you doing so far))
(how-many-S-expressions? '(how are you doing so far))
(list? '(((how) are) ((you) (doing so)) far))
(how-many-S-expressions? '(((how) are) ((you) (doing so)) far))
(newline)

(define oneline-print
  (lambda (x)
    (display x)
    (newline)))
(define display-sub-S-expressions
  (lambda (x)
    (cond
      ((atom? x) (oneline-print x))
      ((list? x)
       (cond
         ((null? x) (oneline-print '()))
         ((null? (cdr x)) (oneline-print (car x)))
         (else (oneline-print (car x))
               (display-sub-S-expressions (cdr x))))))))
(display-sub-S-expressions '(a b c))
(display-sub-S-expressions '(((how) are) ((you) (doing so)) far))
(newline)

(list? '())
(atom? '())
(list? '(() () () ()))

; ------------------------------------------------------------------------------
