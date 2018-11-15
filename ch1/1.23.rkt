#lang sicp
(#%require racket/format)

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

(define (timed-prime-test n)
  (define (start-prime-test n start-time)
    (if (prime? n)
      (- (runtime) start-time)))
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
  (start-prime-test n (runtime)))

(define (timed-prime-test-orig n)
  (define (start-prime-test n start-time)
    (if (prime? n)
      (- (runtime) start-time)))
  (define (prime? n)
    (= n (smallest-divisor n)))
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ 1 test-divisor)))))
  (start-prime-test n (runtime)))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

; ================== Draw Table Output =========================================

(define (table-draw prime-list)
  (define (table-draw-column-headers)
    (display "|       PRIME        |    1.22    |    1.23    |   RATIO    |")
    (newline))
  (define (table-draw-horizontal-line)
    (display "+--------------------+------------+------------+------------+")
    (newline))
  (define (table-entry-draw prime runtime-orig runtime)
      (display (string-append
                 "|"
                 (~a (number->string prime) " " #:width 20 #:align 'right #:limit-marker "...")
                 "|"
                 (~a (number->string runtime) " " #:width 12 #:align 'right #:limit-marker "...")
                 "|"
                 (~a (number->string runtime-orig) " " #:width 12 #:align 'right #:limit-marker "...")
                 "|"
                 (~a " " #:width 12 #:align 'right #:limit-marker "...")
                 "|"))
      (newline))
  (define (table-draw-iter prime-list)
    (if (not (null? prime-list))
      (table-entry-draw
        (car prime-list)
        (timed-prime-test (car prime-list))
        (timed-prime-test-orig (car prime-list))))
   (if (not (null? (cdr prime-list)))
     (table-draw-iter (cdr prime-list))))
  (table-draw-horizontal-line)
  (table-draw-column-headers)
  (table-draw-horizontal-line)
  (table-draw-iter prime-list)
  (table-draw-horizontal-line))

(table-draw '(37
              1009
              1013
              1019
              10007
              10009
              10037
              100003
              100019
              100043
              1000003
              1000033
              1000037
              10000019
              10000079
              10000103
              100000007
              100000037
              100000039
              1000000007
              1000000009
              1000000021
              10000000019
              10000000033
              10000000061
              100000000003
              100000000019
              100000000057
              1000000000039
              1000000000061
              1000000000063
              10000000000037
              10000000000051
              10000000000099
              100000000000031
              100000000000067
              100000000000097
              1000000000000037
              1000000000000091))

; The runtimes required to find the smaller primes from exercise 1.22 are simply
; too small to provide a reliable indication of the speed-up ratio. Primes under
; 10^12 tend to have speed-up ratios all over the place. From 10^12 - 10^15,
; there's a pretty definite convergence toward a speedup ~3.0. This is clearly
; larger than the expected speedup of 2.0, by a whopping 50%. It may be that
; hardware pipeline and/or multicore processing optimizations are at play here.
; At the time of publication, single-core processors with shorter pipelines
; likely produced a more expected speed-up of somewhere around 2.0.
