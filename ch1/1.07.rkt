#lang sicp

(define (abs x)
  (if (< x 0)
    (- x)
    x))

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
;  (display "improve       = ")
;  (display (average guess (/ x guess))) (newline)
  (average guess (/ x guess)))

(define (determinant guess x)
  (abs (- (square guess) x)))

(define (good-enough? guess x)
;  (display "guess^2       = ")
;  (display (square guess)) (newline)
;  (display "guess^2 - x   = ")
;  (display (- (square guess) x)) (newline)
;  (display "|guess^2 - x| = ")
;  (display (abs (- (square guess) x))) (newline)
;  (display "good-enough?  = ")
;  (display (< (determinant guess x) 0.001)) (newline)
  (< (determinant guess x) 0.001))

(define (sqrt-iter guess x)
;  (display "==========================================") (newline)
;  (display "guess         = ")
;  (display guess) (newline)
;  (display "x             = ")
;  (display x) (newline)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; Exercise 1.7
; ------------
; The "good-enough?" test used in computing square roots will not be very
; effective for finding the square roots of very small numbers. Also, in real
; computers, arithmetic operations are almost always performed with limited
; precision. This makes our test inadequate for very large numbers. Explain
; these statements, with examples showing how the test fails for small and
; large numbers. An alternative strategy for implementing "good-enough?" is to
; watch how "guess" changes from one iteration to the next and to stop when the
; change is a very small fraction of the guess. Design a square-root procedure
; that uses this kind of end test. Does this work better for small and large
; numbers?

; With regard to small numbers, the 0.001 threshold proves far too large for
; many cases. For example, (sqrt 0.01) yields the value 0.10032578510960605,
; while the true square root in this case is 0.1. Already the result has an
; error of over 3%. (sqrt 0.001) yields 0.04124542607499115 with an error of
; over 30% from the expected 0.0316227766. Obviously, the error increases
; dramatically with each successive increase in the order of magnitude.
;
; With respect to very large numbers, the "improve" procedure eventually reaches
; a point where the average of guess and x/guess fails to make sufficient
; progress to cause the next iteration through "sqrt-iter" to pass the
; "good-enough?" test. Results will be machine-dependent, but on my 2014 MacBook
; Pro, (sqrt 10000000000000000) correctly yields 100000000.0. However,
; (sqrt 100000000000000000) never terminates because "improve" repeatedly
; returns 316227766.01683795. This case is very specific, but is generalizable
; to other very large values. Commenting in the "display" lines, above, will
; demonstrate the behavior.
