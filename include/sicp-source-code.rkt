; Subset of the code provided in SICP necessary to complete the exercises.

#lang sicp

; 1.1.5
(#%provide square)

(define (square x)
  (* x x))

(#%provide sum-of-squares)

(define (sum-of-squares x y)
  (+ (square x) (square y)))

; 1.1.7 
(#%provide improve)

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(#%provide good-enough?)
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; 1.2.6
(#%provide smallest-divisor)

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(#%provide prime?)

(define (prime? n)
  (= n (smallest-divisor n)))
