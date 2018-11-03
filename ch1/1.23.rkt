#lang sicp
(#%require "../include/sicp-source-code.rkt")

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
; this epxectation confirmed? If not, what is the observed ration of the speeds
; of the two algorithms, and how do you explain the fact that it is different
; from 2?

(define (search-for-primes lower upper)
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (define (divides? a b)
    (= (remainder b a) 0))
  (define (next n)
    (if (= n 2) 3 (+ n 2)))
  (define (prime? n)
    (= n (smallest-divisor n)))
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
  (define (search-for-primes-iter candidate)
    (cond ((<= candidate upper)
           (timed-prime-test candidate)
           (search-for-primes-iter (+ candidate 2)))))
  (let ((adjusted-lower (cond ((< lower 3) 3)
                         ((even? lower) (+ lower 1))
                         (else lower))))
    (search-for-primes-iter adjusted-lower)))

; | magnitude | prime            |       1.22 |       1.23 |   ratio  |
; |-------------------------------------------------------------------|
; | 10^3      | 1009             |          2 |          2 |     1.00 |
; |           | 1013             |          2 |          1 |     2.00 |
; |           | 1019             |          2 |          1 |     2.00 |
; | 10^4      | 10007            |          4 |          3 |     1.33 |
; |           | 10009            |          4 |          1 |     4.00 |
; |           | 10037            |          5 |          1 |     5.00 |
; | 10^5      | 100003           |          9 |          7 |     1.29 |
; |           | 100019           |          9 |          6 |     1.33 |
; |           | 100043           |         15 |          4 |     3.75 |
; | 10^6      | 1000003          |         41 |         20 |     2.05 |
; |           | 1000033          |         40 |         31 |     1.29 |
; |           | 1000037          |         41 |         14 |     2.93 |
; | 10^7      | 10000019         |        145 |         45 |     3.22 |
; |           | 10000079         |        134 |         43 |     3.12 |
; |           | 10000103         |        142 |         48 |     2.96 |
; | 10^8      | 100000007        |        400 |        135 |     2.96 |
; |           | 100000037        |        401 |        134 |     2.99 |
; |           | 100000039        |        401 |        133 |     3.02 |
; | 10^9      | 1000000007       |       1131 |        478 |     2.37 |
; |           | 1000000009       |       1068 |        422 |     2.53 |
; |           | 1000000021       |       1023 |        422 |     2.42 |
; | 10^10     | 10000000019      |       3666 |       4329 |     2.74 |
; |           | 10000000033      |       3370 |       1287 |     2.62 |
; |           | 10000000061      |       2840 |       1200 |     2.37 |
; | 10^11     | 100000000003     |      10102 |       4329 |     2.33 |
; |           | 100000000019     |      10168 |       3674 |     2.77 |
; |           | 100000000057     |      10384 |       3090 |     3.36 |
; | 10^12     | 1000000000039    |      33439 |      11154 |     3.00 |
; |           | 1000000000061    |      30250 |       9695 |     3.12 |
; |           | 1000000000063    |      29568 |       9424 |     3.14 |
; | 10^13     | 10000000000037   |      94156 |      31355 |     3.00 |
; |           | 10000000000051   |      91365 |      31259 |     2.92 |
; |           | 10000000000099   |      91243 |      30942 |     2.95 |
; | 10^14     | 100000000000031  |     296031 |      97702 |     3.03 |
; |           | 100000000000067  |     281417 |      95721 |     2.94 |
; |           | 100000000000097  |     287542 |      95683 |     3.01 |
; | 10^15     | 1000000000000037 |     900509 |     301098 |     2.99 |
; |           | 1000000000000091 |     889571 |     302341 |     2.94 |
; |           | 1000000000000159 |     885578 |     301260 |     2.94 |
;
; The runtimes required to find the smaller primes from exercise 1.22 are simply
; too small to provide a reliable indication of the speed-up ratio. Primes under
; 10^12 tend to have speed-up ratios all over the place. From 10^12 - 10^15,
; there's a pretty definite convergence toward a speedup ~3.0. This is clearly
; larger than the expected speedup of 2.0, by a whopping 50%. It may be that
; hardware pipeline and/or multicore processing optimizations are at play here.
; At the time of publication, single-core processors with shorter pipelines
; likely produced a more expected speed-up of somewhere around 2.0.
