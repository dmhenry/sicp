#lang sicp

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

; Exercise 1.20
; The process that a procedure generates is of course dependent on the rules
; used by the interpreter. As an example, consider the iterative gcd procedure
; given above. Suppose we were to interpret this procedure using normal-order
; evaluation, as discussed in section 1.1.5. (The normal-order-evaluation rule
; for if is described in exercise 1.5.) Using the substitution method (for
; normal order), illustrate the process generated in evaluating (gcd 206 40) and
; indicate the remainder operations that are actually performed. How many
; remainder operations are actually performed in the normal-order evaluation of
; (gcd 206 40)? In applicative-order evaluation?

; Normal-order evaluation requires 18 calls to the remainder procedure: 14 where
; b!=0 and the alternate statement is reduced, and 4 when b==0 and the
; consequent is reduced. Note that remainder operations in normal-order
; evaluation occur on an as-needed basis, i.e., when the predicate (= b 0) is
; tested. This is demonstrated below:
;
; (gcd 206 40)
;   (if (= 40 0) ...)
; (gcd 40 (rem 206 40))
;   (if (= (rem 206 40) 0) ...)
;   (if (= 6 0) ...)
; (gcd (rem 206 40) (rem 40 (rem 206 40)))
;   (if (= (rem 40 (rem 206 40)) 0) ...)
;   (if (= (rem 40 6) 0) ...)
;   (if (= 4 0) ...)
; (gcd (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))
;   (if (= (rem (rem 206 40) (rem 40 (rem 206 40))) 0) ...)
;   (if (= (rem (rem 206 40) (rem 40 6)) 0) ...)
;   (if (= (rem (rem 206 40) 4) 0) ...)
;   (if (= (rem 6 4) 0) ...)
;   (if (= 2 0) ...)
; (gcd (rem (rem 206 40) (rem 40 (rem 206 40))) (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))))
;   (if (= (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))) 0) ...)
;   (if (= (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 6))) 0) ...)
;   (if (= (rem (rem 40 (rem 206 40)) (rem (rem 206 40) 4)) 0) ...)
;   (if (= (rem (rem 40 (rem 206 40)) (rem 6 4)) 0) ...)
;   (if (= (rem (rem 40 (rem 206 40)) 2) 0) ...)
;   (if (= (rem (rem 40 6) 2) 0) ...)
;   (if (= (rem 4 2) 0) ...)
;   (if (= 0 0) (rem (rem 206 40) (rem 40 (rem 206 40))))
;   (if (= 0 0) (rem (rem 206 40) (rem 40 6)))
;   (if (= 0 0) (rem (rem 206 40) 4))
;   (if (= 0 0) (rem 6 4))
;   (if (= 0 0) 2)
; 2
;
; By contrast, applicative-order evaluation requires only 4 calls to the
; remainder procedure. In applicative-order evaluation, remainder operations are
; performed before making the next linear recursive (iterative) call to gcd.
; This is demonstrated below:
;
; (gcd 206 40)
;   (if (= 40 0) ...)
; (gcd 40 (rem 206 40))
; (gcd 40 6)
;   (if (= 6 0) ...)
; (gcd 6 (rem 40 6))
; (gcd 6 4)
;   (if (= 4 0) ...)
; (gcd 4 (rem 6 4))
; (gcd 4 2)
;   (if (= 2 0) ...)
; (gcd 2 (rem 4 2))
; (gcd 2 0)
;   (if (= 2 0) ...)
; 2
