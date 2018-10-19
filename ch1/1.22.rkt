#lang sicp
(#%require "../include/sicp-source-code.rkt")

; Exercise 1.22
; Most Lisp implementations include a primitive called runtime that returns an
; integer that specifies the amount of time the system has been running
; (measured, for example, in microseconds). The following timed-prime-test
; procedure, when called with an integer n, prints n and checks to see if n is
; prime. If n is prime, the procedure prints three asterisks followed by the
; amount of time used in performing the test.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; Using this procedure, write a procedure search-for-primes that checks the
; primality of consecutive odd integers in a specified range. Use your procedure
; to find the three smallest primes larger than 1000; larger than 10,000;
; larger than 100,000; larger than 1,000,000. Note the time needed to test each
; prime. Since the testing algorithm has order of growth of Θ(√n), you should
; expect that testing for primes around 10,000 should take about √10 times as
; long as testing for primes around 1000. Do your timing data bear this out? How
; well do the data for 100,000 and 1,000,000 support the √n prediction? Is your
; result compatible with the notion that programs on your machine run in time
; proportional to the number of steps required for the computation?

(define (search-for-primes lower upper)
  (define (search-for-primes-iter candidate)
    (cond ((<= candidate upper)
           (timed-prime-test candidate)
           (search-for-primes-iter (+ candidate 2)))))
  (search-for-primes-iter (cond ((< lower 3) 3)
                                ((even? lower) (+ lower 1))
                                (else lower))))

; The three smallest primes
;   greater than 1000:       1009,    1013,    1019;
;   greater than 10000:     10007,   10009,   10037;
;   greater than 100000:   100003,  100019,  100043;
;   greater than 1000000: 1000003, 1000033, 1000037;
;
; Anecdotal times corroborate the hypothesis that an increase in order of
; magnitude correlates to computation times roughly √10 times as long.
