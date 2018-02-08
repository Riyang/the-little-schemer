; ----------------------- Chapter 3 Cons the Magnificent -----------------------
; 
; There are three parts of chapter 3.
;
; Part 1:
;   (rember a lat)
;   (firsts l)
;   (seconds l)
;   (lasts l)
;   (real-lasts l)
;
; Part 2:
;   (insertR new old lat)
;   (insertL new old lat)
;   (subst new old lat)
;   (subst2 new o1 o2 lat)
;
; Part 3: Done!
;   (multirember a lat)
;   (multiinsertR new old lat)
;   (multiinsertL new old lat)
;   (multisubst new old lat)
;
;
; ------------------------------------------------------------------------------

(define who
  (lambda ()
    (display 'my-ex-girlfriend:)))
(who)

(newline)

(define who
  (lambda ()
    (define my-ex-girlfriend
      (lambda ()
        (display 'ViVi)))
    (my-ex-girlfriend)))
(who)

(newline)

(define who
  (lambda ()
    (newline)
    (display 'who?)
    (newline)
    (display 'my-ex-girlfriend:)
    (newline)
    (display 'ViVi)
    (newline)))
(who)
