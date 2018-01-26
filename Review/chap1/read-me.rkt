; ------------------------------- Chapter 1 Toys -------------------------------
;
; 
; There are three parts of Toys.
;
; Part 1:
;   (atom? x) 
;   If x is an atom, it will return #t; otherwise, #f.
; 
;   (list? x)
;   If x is a list, it will return #t; otherwise, #f.
;
;   (S-expression? x)
;   If x is an S-expression, it will return #t; otherwise, #f.
;
;   (how-many-S-expressions x)
;   If x is an atom, it will return 1, cause an atom is one S-expression.
;   If x is a list, it will return the number of elements of the list x.
;
;   (display-sub-S-expressions x)
;   It is defined only for lists, so x should always be a list.
;   It will display every elements of the list x, line by line.; 
;
;
; Part 2:
;   (car l)
;   It is defined only for non-empty lists.
;   It will return the first element of the non-empty list l.
; 
;   (cdr l)
;   It is defined only for non-empty lists.
;   It will return a list, which is almost the same as the list l,
;   but without the first element of l.
;
;   (cons s l)
;   It accepts two arguments s and l, which l should be any list,
;   and s can be any S-expression.
;   It will return a new list, which almost the same like l,
;   but adds s to be the first element of l. 
; 
;
; Part 3:
;   (null? l)
;   It is defined only for lists, so l can only be any list.
;   If l is the empty list, it will return #t; otherwise, #f.
; 
;   (eq? a1 a2)
;   It accepts two arguments a1 and a2, which should be two non-numeric atoms.
;   If a1 and a2 are totally one same atom, it will return #t;
;   otherwise, #f.
;
; 
; ------------------------------------------------------------------------------
