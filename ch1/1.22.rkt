#lang sicp

; Provided procedures

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

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
  (define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))
  (define (start-prime-test n start-time)
    (if (prime? n)
      (report-prime (- (runtime) start-time))
      (cons 0 0)))
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
    (cons elapsed-time 1))
  (define (search-for-primes-iter candidate prime-time prime-count)
    (cond ((<= candidate upper)
           (let ((time-count-pair (timed-prime-test candidate)))
                 (search-for-primes-iter (+ candidate 2) 
                                         (+ (car time-count-pair) prime-time) 
                                         (+ (cdr time-count-pair) prime-count))))
           ((> prime-count 0) (exact->inexact (/ prime-time prime-count)))
           (else 0)))
  (let ((adjusted-lower (cond ((< lower 3) 3)
                         ((even? lower) (+ lower 1))
                         (else lower))))
    (search-for-primes-iter adjusted-lower 0 0)))

; The provided procedures were redefined in search-for-primes, above, to allow
; for collecting average computation times for prime numbers within a given
; range.
;
; The three smallest primes
;   greater than 1000:       1009,    1013,    1019;
;   greater than 10000:     10007,   10009,   10037;
;   greater than 100000:   100003,  100019,  100043;
;   greater than 1000000: 1000003, 1000033, 1000037;

(define (display-prime-stats)
    (define (show-stat stat-tuple)
      (newline)
      (display (string-append "Mean computation time for primes in ["
                          (number->string (car stat-tuple)) ","
                          (number->string (cadr stat-tuple)) "]: "
                          (number->string (caddr stat-tuple)))))
    (define (show-stats stat-list)
      (cond ((not (null? stat-list))
             (show-stat (car stat-list))
             (show-stats (cdr stat-list)))
            (else (newline))))
    (show-stats (list (list 1000 9999 (search-for-primes 1000 9999))
                      (list 10000 99999 (search-for-primes 10000 99999))
                      (list 100000 999999 (search-for-primes 100000 999999))
                      (list 1000000 9999999 (search-for-primes 1000000 9999999))
                      (list 10000000 99999999 (search-for-primes 10000000 99999999)))))

; display-prime-stats, above, runs search-for-primes on five orders of 
; magnitude: 10^3, 10^4, 10^5, 10^6, 10^7

; [1000,9999]         : 2.7954759660697457
; [10000,99999]       : 6.559607796245366
; [100000,999999]     : 20.74404260877137
; [1000000,9999999]   : 65.24800838109408
; [10000000,99999999] : 202.92511373633576
;
; Ratios:
;
; 10^4    6.559607796245366
; ---- : ------------------ = 2.34650838564
; 10^3   2.7954759660697457
;
; 10^5   20.74404260877137
; ---- : -----------------  = 3.16239068754
; 10^4   6.559607796245366
;
; 10^6   65.24800838109408
; ---- : -----------------  = 3.1453853818
; 10^5   20.74404260877137
;
; 10^7   202.92511373633576
; ---- : ------------------ = 3.11005835689
; 10^6    65.24800838109408
;
; The runtimes, above, do corroborate the hypothesis that an increase in order
; of magnitude correlates to computation times roughly √10 = 3.16227766017 times
; as long as the prior order of magnitude. Note that the display lines for
; individual candidates were commented out during collection of this data, as
; they disproportionately increased runtimes for larger ranges.
