#!/usr/bin/env racket
#lang sicp

; Exercise 1.4
; Observe that our model of evaluation allows for combinations whose operators
; are compound expressions. Use this observation to describe the behavior of
; the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; My Solution:
; This procedure dynamically chooses one of two operators {+,-} to apply to its
; operands, a and b, based on the result of the predicate (b > 0). In this case,
; the procedure applies the + operation when the second operand is a positive
; number; or the - operation otherwise. The effect is that the first argument's
; value (a) is added to the second argument's (b) absolute value. Note that the
; ability to choose operators dynamically requires that a language have
; first-class functions.
