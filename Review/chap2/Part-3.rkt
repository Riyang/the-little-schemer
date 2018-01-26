; ----------------------------------- Part 3 -----------------------------------

; predefine:
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; Is it true or false that a is a member of lat
; where a is tea and lat is (coffee tea or milk)?
; True.
; So, what is the value of (member? 'tea '(coffee tea or milk))?
; #t
; And, what about (member? 'poached '(fired eggs and scrambled eggs))?
; Well, it is #f--false.

; This is the function member? :
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else
       (or (eq? (car lat) a)
           (member? a (cdr lat)))))))

(member? 'meat '(mashed potatoes and meat gravy))
; follow the definition of member? :
;    (member? 'meat '(mashed potatoes and meat gravy))
; -> (member? 'meat '(potatoes and meat gravy))
; -> (member? 'meat '(and meat gravy))
; -> (member? 'meat '(meat gravy))
; -> (eq? (car '(meat gravy)) 'meat)
; -> #t

(member? 'liver '(bagels and box))
;    (member? 'liver '(bagels and box))
; -> (member? 'liver '(and box))
; -> (member? 'liver '(box))
; -> (member? 'liver '())
; -> (null? '())  ; the value of it is #t
; -> #f  ; the final answer

(newline)

; my definition of member? ,
; which I think is more easy-understanding:
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? (car lat) a) #t)
      (else
       (member? a (cdr lat))))))


; some examples created by myself:
(member? 'friends '(me families friends strangers))
(member? 'money '(me families friends strangers))
(member? 'vivi '(my ex-girlfriends: vivi no-one alin))
(member? 'xia '(my ex-girlfriends: vivi no-one alin))
(member? 'xiao-pang '(my best-friends: a-du xiao-pang sheng-xian etc))
(member? 'liu-guang-hai '(my bosses: liu-guang-hai))
(member? 'wang-wen-yue '(my head-of-house: wang-wen-yue))


; ------------------------------------------------------------------------------
