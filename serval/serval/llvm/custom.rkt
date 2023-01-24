#lang rosette/safe

(provide (all-defined-out))

(require (prefix-in core: serval/lib/core)

serval/llvm
serval/ubsan)


(define (@llvm.expect.i1 %x %y)
; %start
(define-label (%start) #:merge #f
(ret %x))

(enter! %start))


(define (@_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %x %y %z)
; %start
(define-label (%start) #:merge #f
(assert #t))

(enter! %start))