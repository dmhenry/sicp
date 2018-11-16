#lang sicp

; Provided procedure
(define (square x)
  (* x x))

; Exercise 1.16
; Design a procedure that evolves an iterative exponentiation process that uses
; successive squaring and uses a logarithmic number of steps, as does fast-expt.
; (Hint: Using the observation that (b^(n/2))^2 = (b^2)^(n/2), keep, along with
; the exponent n and the base b, an additional state variable a, and define the
; state transformation in such a way that the product ab^n is unchanged from
; state to state. At the beginning of the process a is taken to be 1, and the
; answer is given by the value of a at the end of the process. In general the
; technique of defining an invariant quantity that remains unchanged from state
; to state is a powerful way to think about the design of iterative algorithms.)

(define (quick-expt b n)
  (define (quick-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (quick-expt-iter (square b) (/ n 2) a))
          ((> n 0) (quick-expt-iter b (- n 1) (* a b)))
          (else (quick-expt-iter b (+ n 1) (/ a b)))))
  (quick-expt-iter b n 1))

; In the optimal case, the exponent n is a power of 2, which results in each
; subsequent halving of the exponent n resulting in an even number until n=2. In
; these cases, n=1 is the sole odd exponent encountered. These cases require
; sqrt(n) squaring operations + 1 multiplication of a*b, when n=1. Observe that,
; in these optimal cases, a=1 until n=1, at which point a=b and the process 
; quickly terminates. Hence, the asymptotic lower bound is Ω(log₂(n)). This is
; demonstrated below with 2^16:
;
; (quick-expt-iter 2 16 1)
; (quick-expt-iter 4 8 1)
; (quick-expt-iter 16 4 1)
; (quick-expt-iter 256 2 1)
; (quick-expt-iter 65536 1 1)
; (quick-expt-iter 65536 0 65536)
;
; In the worst case, each halving of the exponent is preceded by a
; multiplication of a*b due to the presence of an odd integer exponent (n).
; (Note that this occurs when the exponent n is one less than a power of 2.)
; This worst-case scenario effectively doubles the number of steps involving
; changes to the values of a and b in the invariant quantity ab^n (which holds
; until the base case is encountered). The worst case, then, is represented by
; O(2log₂(n)) complexity growth. This is demonstrated below with 2^15:
;
; (quick-expt-iter 2 15 1)
; (quick-expt-iter 2 14 2)
; (quick-expt-iter 4 7 2)
; (quick-expt-iter 4 6 8)
; (quick-expt-iter 16 3 8)
; (quick-expt-iter 16 2 128)
; (quick-expt-iter 256 1 128)
; (quick-expt-iter 256 0 32768)
;
; Because we are only interested in the most significant term in our complexity
; growth, coefficients and logarithmic bases can be discarded, resulting in a 
; general complexity of Θ(log(n)). The recursive quick-expt-iter procedure is
; interpreted as an iterative process, which is to say that it results in a
; linear recursive process, i.e., it is tail-recursive. This is because the
; state of the process is captured entirely in its state variables (rather than
; relying on a stack of deferred operations, as with a recursive process). For 
; this reason, space complexity is constant in every case, i.e., Θ(1).
