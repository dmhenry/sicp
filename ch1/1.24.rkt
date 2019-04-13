#lang sicp

; Provided procedures
(define (square x)
  (* x x))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n)
         (fast-prime? n (- times 1)))
        (else false)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
           (square (expmod base (/ exp 2) m))
           m))
        (else
          (remainder
            (* base (expmod base (- exp 1) m))
            m))))

; Exercise 1.24
; Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime? (the
; Fermat method), and test each of the 12 primes you found in that exercise.
; Since the Fermat test has Θ(log n) growth, how would you expect the time to
; test primes near 1,000,000 to compare with the times near 1000? Do your data
; bear this out? Can you explain any discrepancy you find?

(define (timed-prime-test n)
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))
  (define (start-prime-test n start-time)
    (if (fast-prime? n 100)
      (report-prime (- (runtime) start-time))))
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(timed-prime-test 101)
(timed-prime-test 1009)
(timed-prime-test 1013)
(timed-prime-test 1019)
(timed-prime-test 10007)
(timed-prime-test 10009)
(timed-prime-test 10037)
(timed-prime-test 100003)
(timed-prime-test 100019)
(timed-prime-test 100043)
(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)
(timed-prime-test 10000019)
(timed-prime-test 10000079)
(timed-prime-test 10000103)
(timed-prime-test 100000007)
(timed-prime-test 100000037)
(timed-prime-test 100000039)
(timed-prime-test 1000000007)
(timed-prime-test 1000000009)
(timed-prime-test 1000000021)

(newline)

; Considering the Fermat test exhibits Θ(log n) complexity, runtime should
; roughly double as the exponent doubles (given the same base), as in going 
; from 10^3 to 10^6. In practice, a trial run (below) shows a ratio of 
; (95+85+105)/(59+52+53)=1.738 for 10^6 primes over 10^3 primes. 

; +-----------+------------+-------------+
; | magnitude | prime      | 1.24, n=100 |
; |-----------+------------+-------------+
; | 10^3      | 1009       |          59 |
; |           | 1013       |          52 |
; |           | 1019       |          53 |
; |-----------+------------+-------------+
; | 10^4      | 10007      |          93 |
; |           | 10009      |          61 |
; |           | 10037      |          63 |
; |-----------+------------+-------------+
; | 10^5      | 100003     |          74 |
; |           | 100019     |          94 |
; |           | 100043     |          84 |
; |-----------+------------+-------------+
; | 10^6      | 1000003    |          95 |
; |           | 1000033    |          85 |
; |           | 1000037    |         105 |
; |-----------+------------+-------------+
; | 10^7      | 10000019   |         122 |
; |           | 10000079   |         125 |
; |           | 10000103   |         125 |
; |-----------+------------+-------------+
; | 10^8      | 100000007  |         139 |
; |           | 100000037  |         138 |
; |           | 100000039  |         131 |
; |-----------+------------+-------------+
; | 10^9      | 1000000007 |         132 |
; |           | 1000000009 |         131 |
; |           | 1000000021 |         132 |
; +-----------+------------+-------------+
