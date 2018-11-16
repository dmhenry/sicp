#lang sicp

; Provided procedures
(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

; Exercise 1.23
; The smallest-divisor procedure shown at the start of this section does lots of
; needless testing: After it checks to see if the number is divisible by 2 there
; is no point in checking to see if it is divisible by any larger even numbers.
; This suggests that the values used for test-divisor should not be 2, 3, 4, 5,
; 6,..., but rather 2, 3, 5, 7, 9 .... To implement this change, define a
; procedure next that returns 3 if its input is equal to 2 and otherwise returns
; its input plus 2. Modify the smallest-divisor procedure to use
; (next test-divisor) instead of (+ test-divisor 1). With timed-prime-test
; incorporating this modified version of smallest-divisor, run the test for each
; of the 12 primes you found in exercise 1.22. Since this modification halves
; the number of test steps, you should expect it to run about twice as fast. Is
; this epxectation confirmed? If not, what is the observed ratio of the speeds
; of the two algorithms, and how do you explain the fact that it is different
; from 2?

(define (timed-prime-test n)
  (define (start-prime-test n start-time)
    (if (prime? n)
      (report-prime (- (runtime) start-time))))
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))
  (define (prime? n)
    (= n (smallest-divisor n)))
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (define (next n)
    (if (= n 2) 3 (+ n 2)))
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (timed-prime-test-orig n)
  (define (start-prime-test n start-time)
    (if (prime? n)
      (report-prime (- (runtime) start-time))))
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))
  (define (prime? n)
    (= n (smallest-divisor n)))
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ 1 test-divisor)))))
  (newline)
  (display n)
  (start-prime-test n (runtime)))

; =========== Output ===========================================================

(newline)
(display "=== timed-prime-test, version 1.23 ====================")
(newline)
(newline)

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
(timed-prime-test 10000000019)
(timed-prime-test 10000000033)
(timed-prime-test 10000000061)
(timed-prime-test 100000000003)
(timed-prime-test 100000000019)
(timed-prime-test 100000000057)
(timed-prime-test 1000000000039)
(timed-prime-test 1000000000061)
(timed-prime-test 1000000000063)
(timed-prime-test 10000000000037)
(timed-prime-test 10000000000051)
(timed-prime-test 10000000000099)
(timed-prime-test 100000000000031)
(timed-prime-test 100000000000067)
(timed-prime-test 100000000000097)
(timed-prime-test 1000000000000037)
(timed-prime-test 1000000000000091)
(timed-prime-test 1000000000000159)

(newline)
(newline)
(display "=== timed-prime-test, version 1.22 ====================")
(newline)

(timed-prime-test-orig 101)
(timed-prime-test-orig 1009)
(timed-prime-test-orig 1013)
(timed-prime-test-orig 1019)
(timed-prime-test-orig 10007)
(timed-prime-test-orig 10009)
(timed-prime-test-orig 10037)
(timed-prime-test-orig 100003)
(timed-prime-test-orig 100019)
(timed-prime-test-orig 100043)
(timed-prime-test-orig 1000003)
(timed-prime-test-orig 1000033)
(timed-prime-test-orig 1000037)
(timed-prime-test-orig 10000019)
(timed-prime-test-orig 10000079)
(timed-prime-test-orig 10000103)
(timed-prime-test-orig 100000007)
(timed-prime-test-orig 100000037)
(timed-prime-test-orig 100000039)
(timed-prime-test-orig 1000000007)
(timed-prime-test-orig 1000000009)
(timed-prime-test-orig 1000000021)
(timed-prime-test-orig 10000000019)
(timed-prime-test-orig 10000000033)
(timed-prime-test-orig 10000000061)
(timed-prime-test-orig 100000000003)
(timed-prime-test-orig 100000000019)
(timed-prime-test-orig 100000000057)
(timed-prime-test-orig 1000000000039)
(timed-prime-test-orig 1000000000061)
(timed-prime-test-orig 1000000000063)
(timed-prime-test-orig 10000000000037)
(timed-prime-test-orig 10000000000051)
(timed-prime-test-orig 10000000000099)
(timed-prime-test-orig 100000000000031)
(timed-prime-test-orig 100000000000067)
(timed-prime-test-orig 100000000000097)
(timed-prime-test-orig 1000000000000037)
(timed-prime-test-orig 1000000000000091)
(timed-prime-test-orig 1000000000000159)

(newline)

; +------------+--------------------+------------+------------+-----------+
; | MAGNITUDE  |       PRIME        |    1.22    |    1.23    |   RATIO   |
; +------------+--------------------+------------+------------+-----------+
; |  10^3      |               1009 |          1 |          1 |     1.000 |
; |            |               1013 |          1 |          0 |       NaN |
; |            |               1019 |          0 |          1 |     0.000 |
; +------------+--------------------+------------+------------+-----------+
; |  10^4      |              10007 |          1 |          0 |       NaN |
; |            |              10009 |          2 |          1 |     2.000 |
; |            |              10037 |          1 |          1 |     1.000 |
; +------------+--------------------+------------+------------+-----------+
; |  10^5      |             100003 |          4 |          3 |     1.333 |
; |            |             100019 |          4 |          2 |     2.000 |
; |            |             100043 |          4 |          2 |     2.000 |
; +------------+--------------------+------------+------------+-----------+
; |  10^6      |            1000003 |         14 |          7 |     2.000 |
; |            |            1000033 |         13 |          7 |     1.857 |
; |            |            1000037 |         14 |          7 |     2.000 |
; +------------+--------------------+------------+------------+-----------+
; |  10^7      |           10000019 |         48 |         22 |     2.181 |
; |            |           10000079 |         42 |         23 |     1.826 |
; |            |           10000103 |         43 |         22 |     1.954 |
; +------------+--------------------+------------+------------+-----------+
; |  10^8      |          100000007 |        141 |         70 |     2.014 |
; |            |          100000037 |        140 |         80 |     1.750 |
; |            |          100000039 |        140 |         80 |     1.750 |
; +------------+--------------------+------------+------------+-----------+
; |  10^9      |         1000000007 |        411 |        236 |     1.742 |
; |            |         1000000009 |        408 |        238 |     1.714 |
; |            |         1000000021 |        472 |        237 |     1.992 |
; +------------+--------------------+------------+------------+-----------+
; |  10^10     |        10000000019 |       1326 |        702 |     1.889 |
; |            |        10000000033 |       1267 |        724 |     1.750 |
; |            |        10000000061 |       1301 |        729 |     1.785 |
; +------------+--------------------+------------+------------+-----------+
; |  10^11     |       100000000003 |       4177 |       2199 |     1.899 |
; |            |       100000000019 |       4153 |       2217 |     1.873 |
; |            |       100000000057 |       4521 |       2197 |     2.058 |
; +------------+--------------------+------------+------------+-----------+
; |  10^12     |      1000000000039 |      13509 |       7445 |     1.815 |
; |            |      1000000000061 |      14122 |       7201 |     1.961 |
; |            |      1000000000063 |      13622 |       7024 |     1.939 |
; +------------+--------------------+------------+------------+-----------+
; |  10^13     |     10000000000037 |      42166 |      23471 |     1.797 |
; |            |     10000000000051 |      42315 |      23571 |     1.795 |
; |            |     10000000000099 |      43467 |      22776 |     1.908 |
; +------------+--------------------+------------+------------+-----------+
; |  10^14     |    100000000000031 |     133008 |      72151 |     1.843 |
; |            |    100000000000067 |     131507 |      71521 |     1.839 |
; |            |    100000000000097 |     130749 |      70215 |     1.862 |
; +------------+--------------------+------------+------------+-----------+
; |  10^15     |   1000000000000037 |     432361 |     217246 |     1.990 |
; |            |   1000000000000091 |     452145 |     236020 |     1.916 |
; |            |   1000000000000159 |     417055 |     218686 |     1.907 |
; +------------+--------------------+------------+------------+-----------+
;
; Above is a tabulated sample of primes from 10^3 to 10^15 magnitudes. With the
; exception of very small values in the 10^3 and 10^4 magnitudes, all of the
; speed-up ratios of version 1.22 to 1.23 are close to 2.0, most of them just
; shy, at 1.7+ speed-up. This is perhaps accounted for by the extra condition in
; the "next" procedure which exists in version 1.23.
