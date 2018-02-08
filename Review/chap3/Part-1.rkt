; ----------------------------------- Part 1 -----------------------------------

(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a) (cdr lat))
      (else
       (cons (car lat)
             (rember a (cdr lat)))))))
; test:
(rember 'mint
        '(lamb chops and mint jelly))
(rember 'mint
        '(lamb chops and mint flavored mint jelly))
(rember 'toast
        '(bacon lettuce and tomato))
(rember 'cup
        '(coffee cup tea cup and hick cup))
(newline)
(rember 'vivi
        '(good luck vivi))
(rember 'f**k
        '(to f**k you))
;

(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (car (car l))
             (firsts (cdr l)))))))
; test:
(newline)
(firsts '((apple peach pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant)))
(firsts '((five plums)
          (four)
          (eleven green oranges)))
(firsts '(((five plums) four)
          (eleven green oranges)
          ((no) more)))
(newline)
(firsts '((yesterday I miss her)
          (today I miss her)
          (tomorrow I miss her)))
(firsts '((you are a good man)
          (are you okay)
          (the point is that you are not the)
          (one I want)))
(firsts '((no no do not do that)
          ((one) man can be happly)
          (else couple is better)))
;

(define second
  (lambda (l)
    (car (cdr l))))
(define seconds
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (second (car l))
             (seconds (cdr l)))))))
; test:
(newline)
(seconds '((a b) (c d) (e f)))
(seconds '((is here or there?)
           (who are you)
           (what the hell are you talking about)
           (the seconds is not the ones)))
;

(define last
  (lambda (l)
    (cond
      ((null? (cdr l)) (car l))
      (else
       (last (cdr l))))))
(define lasts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (last (car l))
             (lasts (cdr l)))))))
; test:
(newline)
(lasts '((1 2)
         (3)
         (4 5 6)))
(lasts '((the thirty-nine step)
         (that is not the steps I went by)
         (move on a step)))
(lasts '((there is nothing to forget)
         (there are some people you care about)
         (what about her)))
;
; --------
(define pick
  (lambda (n lat)
    (cond
      ((= n 1) (car lat))
      (else
       (pick (- n 1) (cdr lat))))))
(define min-length-of-sublists
  (lambda (l)
    (cond
      ((null? (cdr l)) (length (car l)))
      (else
       (min (length (car l))
            (min-length-of-sublists (cdr l)))))))
(define real-lasts-recur
  (lambda (min-length l)
    (cond
      ((null? l) (quote ()))
      (else
       (cons (pick min-length
                   (car l))
             (real-lasts-recur min-length (cdr l)))))))
(define real-lasts
  (lambda (l)
    (real-lasts-recur (min-length-of-sublists l) l)))

; test:
(newline)
(real-lasts '((1 2 3)
              (4)
              (5 6)))
(real-lasts '((1 2 3)
              (4 5)
              (6 7)
              (8 9 10)))
(real-lasts '((I think you should not)
              (upset but cheer youself)
              (you can up)))
(real-lasts '((you still confused?)
              (will you gonna)
              (meet)
              (your friends or)
              (future-wife or future-daugters?)))
(real-lasts '((and)
              (your)
              (lovely-adorable)
              (daugters)))
; --------

; ------------------------------------------------------------------------------