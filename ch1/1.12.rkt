#lang sicp

; Exercise 1.12
; The following pattern of numbers is called Pascal's triangle.
;
;     1
;    1 1
;   1 2 1
;  1 3 3 1
; 1 4 6 4 1
;    ...
;
; The numbers at the edge of the triangle are all 1, and each number inside the
; triangle is the sum of the two numbers above it. Write a procedure that
; computes elements of Pascal's triangle by means of a recursive process.

(define (pascal row col)
  (cond ((< row col) 0)
        ((or (= col 0) (= row col)) 1)
        (else (+ (pascal (- row 1) (- col 1))
                 (pascal (- row 1) col)))))

; (pascal 0 0)
; (pascal 1 0)
; (pascal 1 1)
; (pascal 2 0)
; (pascal 2 1)
; (pascal 2 2)
; (pascal 3 0)
; (pascal 3 1)
; (pascal 3 2)
; (pascal 3 3)
; (pascal 4 0)
; (pascal 4 1)
; (pascal 4 2)
; (pascal 4 3)
; (pascal 4 4)
