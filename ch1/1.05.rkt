#lang sicp

; Exercise 1.5
; Ben Bitdiddle has invented a test to determine whether the interpreter he is
; faced with is using applicative-order evaluation or normal-order evaluation.
; He defines the following two procedures:

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

; Then he evaluates the expression

(test 0 (p))

; What behavior will Ben observe with an interpreter that uses applicative-
; order evaluation? What behavior will he observe with an interpreter that
; uses normal-order evaluation? Explain your answer. (Assume that the 
; evaluation rule for the special form if is the same whetehr the interpreter
; is using normal or applicative order: The predicate expression is evaluated
; first, and the result determines whether to evaluate the consequent or the
; alternative expression.)

; Using applicative-order evaluation, the interpreter will return 0, as
; demonstrated by the substition sequence
;
;     (test 0 (p))
;
;     (if (= x 0) 0 y))
;
;     (if (= 0 0) 0 y))
;
;     (if #t 0 y)
;
;     0
;
; By contrast, using normal-order evaluation the interpreter will appear to
; hang, as it attempts to fully (and recursively) expand the procedure p before
; performing any reductions. This is demonstrated by the expansion sequence
;
;     (test 0 (p))
;
;     (test 0 ((p)))
;
;     (test 0 (((p))))
;
;      ...
;
; This may culminate in an overflow of the stack if the interpreter does not
; attempt to detect and mitigate the infinite recursion.
