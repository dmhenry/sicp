#lang sicp
(#%require "../include/sicp-source-code.rkt")

; Exercise 1.7
; ------------
; The good-enough? test used in computing square roots will not be very
; effective for finding the square roots of very small numbers. Also, in real
; computers, arithmetic operations are almost always performed with limited
; precision. This makes our test inadequate for very large numbers. Explain
; these statements, with examples showing how the test fails for small and
; large numbers. An alternative strategy for implementing good-enough? is to
; watch how guess changes from one iteration to the next and to stop when the
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
; With respect to very large numbers, the improve procedure eventually reaches
; a point where the average of guess and x/guess fails to make sufficient
; progress to cause the next iteration through sqrt-iter to pass the
; good-enough?  test. Results will be machine-dependent, but on my 2014 MacBook
; Pro, (sqrt 10000000000000000) correctly yields 100000000.0. However,
; (sqrt 100000000000000000) never terminates because improve repeatedly returns
; 316227766.01683795. This case is very specific, but is generalizable to other
; very large values. 

(define (done? guess last-guess)
  (< (/ (abs (- guess last-guess)) guess) 0.000001))

(define (better-sqrt-iter guess last-guess x)
  (if (done? guess last-guess)
    guess
    (better-sqrt-iter (improve guess x)
                      guess
                      x)))

(define (better-sqrt x)
  (better-sqrt-iter 1.0 0.5 x))

; The "better-sqrt" procedure, above, uses the same iterative process to make
; and improve guesses. However, it terminates when the ratio of the difference
; between the current guess and the last guess over the current guess is less
; than one one-millionth. This effectively calculates arbitrarily large and
; small number to a very high accuracy. For example, applying "better-sqrt" to
; 1e-97 results in 3.1622776601683796e-49 which is the same as the calculator
; application on my Mac, with one added degree of precision (the calculator app
; provides 3.162277660168379e-49). Applying "better-sqrt" to 1e+96 yields 
; 3.162277660168379e+48, which is again, one decimal more precise than the
; calculator app on my Mac (which provides 3.16227766016838e+48). In summary,
; this method is highly precise, highly accurate, and clearly superior to the
; original sqrt procedure.
