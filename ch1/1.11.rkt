#lang sicp

; Exercise 1.11
; A function f is defined by the rulle that f(n) = n if n < 3 and 
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3. Write a procedure that computes f
; by means of a recursive process. Write a  procedure that computes f by means
; of an iterative process.

(define (f n)
  (if (< n 3)
    n
    (+ (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))))

(define (g n)
  (define (g-iter a b c count)
    (if (= count 0)
      c
      (g-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (- count 1))))
  (g-iter 2 1 0 n))

; Think of the iterative version as a sliding window that contains the three
; most recently computed values. The n-th value is the least recently
; computed value (c); the one which will "fall off" during the next computation.
