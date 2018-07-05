#!/usr/bin/env racket
#lang racket
(#%require sicp)
(require racket/cmdline)

; Exercise 1.3
; Define a procedure that takes three numbers as arguments and returns the sum
; of the squares of the two larger numbers.

(define (sum-of-squares-larger-two x y z)
  (define (square x)
    (* x x))
  (define (sum-of-squares x y)
    (+ (square x) (square y)))
  (sum-of-squares
    (cond ((and (<= x y) (<= x z)) (cons y z))
          ((and (<= y x) (<= y z)) (cons x z))
          (else (cons x y)))))

; Run from shell
(define parser
  (command-line
    #:program "sum-of-squares-larger-two"
    #:args (x y z)
    (printf "~a\n" (sum-of-squares-larger-two (string->number x)
                                              (string->number y)
                                              (string->number z)))))
