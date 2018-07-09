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
; evaluation rule for the special form if is the same whether the interpreter
; is using normal or applicative order: The predicate expression is evaluated
; first, and the result determines whether to evaluate the consequent or the
; alternative expression.)

; Applicative-order evaluation relies on reductions being performed as they are
; encountered. This requires arguments to be fully expanded and reduced before
; an evaluation can proceed. In the case above, the operation "test" cannot be
; applied until its operands have been evaluated. "test" relies on the reduction
; of (p), which recursively expands to itself, causing the interpreter to hang.
;
;     (test 0 (p))
;
;     (test 0 (p))
;
;     (test 0 (p))
;
;      ...
;
; Using normal-order evaluation, the interpreter will return 0, as demonstrated
; by the substition sequence
;
;     (test 0 (p))
;
;     (if (= 0 0) 0 (p))
;
;     (if #t 0 (p))
;
;     0
;
; This works because evaluation of (p) can be delayed until its value is
; needed, which it never is. The truth value of the predicate results in the
; consequent branch being executed; the alternate can be safely ignored.
