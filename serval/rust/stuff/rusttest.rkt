; DO NOT MODIFY.
;
; This file was automatically generated.

#lang rosette

(provide (all-defined-out))

(require (prefix-in core: serval/lib/core)
         
         (except-in serval/llvm trunc)
         serval/lib/bvarith
         serval/ubsan)



(define (@test %x %y)
; %start
  (define-label (%start) #:merge #f
    (set! %r (add %x %y))
    (ret %r))

  (define-value %r)
  (enter! %start))

(define (@double_sum %xp %yp)
; %start
  (define-label (%start) #:merge #f
    (set! %_5 (call @test %xp %xp))
    (br %bb1))

; %bb1
  (define-label (%bb1) #:merge #f
    (set! %_8 (call @test %yp %yp))
    (br %bb2))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %0 (add %_5 %_8))
    (ret %0))

  (define-value %_5)
  (define-value %_8)
  (define-value %0)
  (enter! %start))

(define (@rust_begin_unwind %_info)
; %start
  (define-label (%start) #:merge #f
    (br %bb1))

; %bb1
  (define-label (%bb1) #:merge #f
    (br %bb1))

  (enter! %start))
