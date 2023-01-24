; DO NOT MODIFY.
;
; This file was automatically generated.

#lang rosette

(provide (all-defined-out))

(require (prefix-in core: serval/lib/core)
         
         serval/llvm
         serval/ubsan)



(define (@udiv %x %y)
; %entry
  (define-label (%entry) #:merge #f
    (set! %cmp (icmp/eq %y (bv #x00000000 32)))
    (br %cmp %return %cont))

; %cont
  (define-label (%cont) #:merge #f
    (set! %div (udiv %x %y))
    (br %return))

; %return
  (define-label (%return) #:merge #f
    (set! %retval.0 (phi [%div %cont] [(bv #x00000000 32) %entry]))
    (ret %retval.0))

  (define-value %cmp)
  (define-value %div)
  (define-value %retval.0)
  (enter! %entry))

(define (@max %x %y)
; %entry
  (define-label (%entry) #:merge #f
    (set! %cmp (icmp/ugt %x %y))
    (set! %x.y (select %cmp %x %y))
    (ret %x.y))

  (define-value %cmp)
  (define-value %x.y)
  (enter! %entry))

(define (@sum %x %y)
; %entry
  (define-label (%entry) #:merge #f
    (set! %add (add %y %x))
    (ret %add))

  (define-value %add)
  (enter! %entry))

(define (@sort %v)
; %for.end
  (define-label (%for.end) #:merge #f
    (set! %arrayidx (getelementptr %v (array-offset (bv #x0000000000000001 64) 4)))
    (set! %0 (load %arrayidx (bitvector 32) #:align 4))
    (set! %1 (load %v (bitvector 32) #:align 4))
    (set! %cmp6 (icmp/ult %0 %1))
    (set! %spec.select (zext %cmp6 (bitvector 64)))
    (set! %arrayidx.155 (getelementptr %v (array-offset (bv #x0000000000000002 64) 4)))
    (set! %2 (load %arrayidx.155 (bitvector 32) #:align 4))
    (set! %idxprom4.156 (zext %cmp6 (bitvector 64)))
    (set! %arrayidx5.157 (getelementptr %v (array-offset %idxprom4.156 4)))
    (set! %3 (load %arrayidx5.157 (bitvector 32) #:align 4))
    (set! %cmp6.158 (icmp/ult %2 %3))
    (set! %spec.select.159 (select %cmp6.158 (bv #x0000000000000002 64) %spec.select))
    (set! %cmp7.not (icmp/eq %spec.select.159 (bv #x0000000000000000 64)))
    (br %cmp7.not %for.end.1 %if.then8))

; %if.then8
  (define-label (%if.then8) #:merge #f
    (set! %4 (load %v (bitvector 32) #:align 4))
    (set! %arrayidx12 (getelementptr %v (array-offset %spec.select.159 4)))
    (set! %5 (load %arrayidx12 (bitvector 32) #:align 4))
    (store %5 %v (bitvector 32) #:align 4)
    (store %4 %arrayidx12 (bitvector 32) #:align 4)
    (br %for.end.1))

; %for.end.1
  (define-label (%for.end.1) #:merge #f
    (set! %arrayidx.1 (getelementptr %v (array-offset (bv #x0000000000000002 64) 4)))
    (set! %6 (load %arrayidx.1 (bitvector 32) #:align 4))
    (set! %arrayidx5.1 (getelementptr %v (array-offset (bv #x0000000000000001 64) 4)))
    (set! %7 (load %arrayidx5.1 (bitvector 32) #:align 4))
    (set! %cmp6.1 (icmp/ult %6 %7))
    (br %cmp6.1 %if.then8.1 %if.end17.1))

; %if.then8.1
  (define-label (%if.then8.1) #:merge #f
    (set! %arrayidx10.1 (getelementptr %v (array-offset (bv #x0000000000000001 64) 4)))
    (set! %8 (load %arrayidx10.1 (bitvector 32) #:align 4))
    (set! %arrayidx12.1 (getelementptr %v (array-offset (bv #x0000000000000002 64) 4)))
    (set! %9 (load %arrayidx12.1 (bitvector 32) #:align 4))
    (store %9 %arrayidx10.1 (bitvector 32) #:align 4)
    (store %8 %arrayidx12.1 (bitvector 32) #:align 4)
    (br %if.end17.1))

; %if.end17.1
  (define-label (%if.end17.1) #:merge #f
    (ret))

  (define-value %arrayidx)
  (define-value %0)
  (define-value %1)
  (define-value %cmp6)
  (define-value %spec.select)
  (define-value %arrayidx.155)
  (define-value %2)
  (define-value %idxprom4.156)
  (define-value %arrayidx5.157)
  (define-value %3)
  (define-value %cmp6.158)
  (define-value %spec.select.159)
  (define-value %cmp7.not)
  (define-value %4)
  (define-value %arrayidx12)
  (define-value %5)
  (define-value %arrayidx.1)
  (define-value %6)
  (define-value %arrayidx5.1)
  (define-value %7)
  (define-value %cmp6.1)
  (define-value %arrayidx10.1)
  (define-value %8)
  (define-value %arrayidx12.1)
  (define-value %9)
  (enter! %for.end))


