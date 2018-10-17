#lang sicp

; Exercise 1.17
; The exponentiation algorithms in this section are based on performing
; exponentiation by means of repeated multiplication. In a similar way, one can
; perform integer multiplication by means of repeated addition. The following
; multiplication procedure (in which it is assumed that our language can only
; add, not multiply) is analogous to the expt procedure:

(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

; This algorithm takes a number of steps that is linear in b. Now suppose we
; include, together with addition, operations double, which doubles an integer,
; and halve, which divides an (even) integer by 2. Using these, design a
; multiplication procedure analogous to fast-expt that uses a logarithmic number
; of steps.

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (fast-mult a b)
    (cond ((= b 0) 0)
          ((even? b) (double (fast-mult a (halve b))))
          ((> b 0) (+ a (fast-mult a (- b 1))))
          (else (- (fast-mult a (+ b 1)) a))))

; This process grows logarithmically with b in both space and number of steps.
; Computing (fast-mult a 2b) requires only one more step than (fast-mult a b)
; and one more deferred opteration, yielding a growth in both complexity and
; space of Θ(log₂(n)). This is demonstrated below:
;
; (fast-mult 3 -9)
; (- (fast-mult 3 -8) 3)
; (- (double (fast-mult 3 -4)) 3)
; (- (double (double (fast-mult 3 -2))) 3)
; (- (double (double (double (fast-mult 3 -1)))) 3)
; (- (double (double (double (- (fast-mult 3 0) 3)))) 3)
; (- (double (double (double (- 0 3)))) 3)
; (- (double (double (double -3))) 3)
; (- (double (double -6)) 3)
; (- (double -12) 3)
; (- -24 3)
; -27

; (fast-mult 3 -18)
; (double (fast-mult 3 -9))
; (double (- (fast-mult 3 -8) 3))
; (double (- (double (fast-mult 3 -4)) 3))
; (double (- (double (double (fast-mult 3 -2))) 3))
; (double (- (double (double (double (fast-mult 3 -1)))) 3))
; (double (- (double (double (double (- (fast-mult 3 0) 3)))) 3))
; (double (- (double (double (double (- 0 3)))) 3))
; (double (- (double (double (double -3))) 3))
; (double (- (double (double -6)) 3))
; (double (- (double -12) 3))
; (double (- -24 3))
; (double -27)
; -54
