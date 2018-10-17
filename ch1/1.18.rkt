#lang sicp

; Exercise 1.18
; Using the results of exercises 1.16 and 1.17, devise a procedure that
; generates an iterative process for multiplaying two integers in terms of
; adding, doubling, and halving and uses a logarithmic number of steps.

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (quick-mult a b)
  (define (quick-mult-iter a b c)
    (cond ((= b 0) c)
          ((even? b) (quick-mult-iter (double a) (halve b) c))
          ((> b 0) (quick-mult-iter a (- b 1) (+ c a)))
          (else (quick-mult-iter a (+ b 1) (- c a)))))
  (quick-mult-iter a b 0))

; In the optimal case, the multiplicand b is a power of 2, which results in each
; subsequent halving of b resulting in an even number until b=2. In these cases,
; b=1 is the sole odd multiplicand encountered. These cases require sqrt(b)
; doubling operations + 1 addition of c+a, when b=1. Observe that, in these
; optimal cases, c=0 until b=1, at which point c=a and the process quickly
; terminates. Hence, the asymptotic lower bound is Ω(log₂(n)). This is
; demonstrated below with 5*16:
;
; (quick-mult-iter 5 16 0)
; (quick-mult-iter 10 8 0)
; (quick-mult-iter 20 4 0)
; (quick-mult-iter 40 2 0)
; (quick-mult-iter 80 1 0)
; (quick-mult-iter 80 0 80)
;
; In the worst case, each halving of the b is preceded by a subtraction, b=b-1
; due to the presence of an odd integer multiplicand (b). (Note that this occurs
; when b is one less than a power of 2.) This worst-case scenario effectively
; doubles the number of steps involving changes to the values of a and c in the
; invariant quantity ab+c (which holds until the base case is encountered). The
; worst case, then, is represented by O(2log₂(n)) complexity growth. This is
; demonstrated below with 5^15:
;
; (quick-mult-iter 5 15 0)
; (quick-mult-iter 5 14 5)
; (quick-mult-iter 10 7 5)
; (quick-mult-iter 10 6 15)
; (quick-mult-iter 20 3 15)
; (quick-mult-iter 20 2 35)
; (quick-mult-iter 40 1 35)
; (quick-mult-iter 40 0 75)
;
; Because we are only interested in the most significant term in our complexity
; growth, coefficients and logarithmic bases can be discarded, resulting in a 
; general complexity of Θ(log(n)). The recursive quick-expt-iter procedure is
; interpreted as an iterative process, which is to say that it results in a
; linear recursive process, i.e., it is tail-recursive. This is because the
; state of the process is captured entirely in its state variables (rather than
; relying on a stack of deferred operations, as with a recursive process). For 
; this reason, space complexity is constant in every case, i.e., Θ(1).
