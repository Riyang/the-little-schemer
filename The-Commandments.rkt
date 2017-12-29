; The Commandments
;
; The First Commandment
; (preliminary)
; Always ask null? as the first question in expressing any function.
;
; The Second Commandment
; Use cons to build lists.
;
; The Third Commandment
; When building a list, describe the first typical element,
; and then cons it onto the natural recursion.
;
; The Fourth Commandment
; (preliminary)
; Always change at least one argument while recurring.
; It must be changed to be closer to termination.
; The changing argument must be tested in the termination condition:
; when using cdr, test termination with null?.
;
; The First Commandment
; (first revision)
; When recurring on a list of atoms, lat,
; ask two questions about it: (null? lat) and else.
; When recurring on a number, n,
; ask two questions about it: (zero? n) and else.
;
; The Fourth Commandment
; (first revision)
; Always change at least one argument while recurring.
; It must be changed to be closer to termination.
; The changing argument must be tested in the termination condition:
; when using cdr, test termination with null?.
; when using sub1, test termination with zero?.
;
; The Fifth Commandment
; When building a value with +, always use 0 for the value of
; the terminating line, for adding 0 does not change the value of
; an addition.
; When building a value with *, always use 1 for the value of
; the terminating line, for multiplying by 1 does not change
; the value of an multiplication.
; When building a value with cons, always consider () for the value of
; the terminating line.
;
; The Seventh Commandment
; Recur on the subparts that are of the same nature:
; On the sublists of a list.
; On the subexpressions of an arithmetic expression.
;
; The Eighth Commandment
; Use help functions to abstract from representations.
;
; The Ninth Commandment
; Abstract common patterns with a new function.
;
; The Tenth Commandment
; Build functions to collect more than one value at a time.
