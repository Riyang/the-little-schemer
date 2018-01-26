; ----------- Chapter 2 Do It, Do It Again, and Again, and Again ... -----------
; 
; There are three parts of Toys.
;
; Part 1:
;   (lat? l):
;              (lat? '(bacon and eggs))
;              (lat? '(bacon (and eggs)))
;
; Part 2:
;   (or (...) (...)):
;              (or (null? '()) (atom? '(d e f g)))
;              (or (null? '(a b c)) (null? '()))
;              (or (null? '(a b c)) (null? '(atom)))
; 
;
; Part 3:
;   (member? a lat):
;              (member? 'tea '(coffee tea or milk))
;              (member? 'poached '(fired eggs and scrambled eggs))
;              (member? 'meat '(mashed potatoes and meat gravy))
;              (member? 'liver '(bagels and box))
;
;
; ------------------------------------------------------------------------------
