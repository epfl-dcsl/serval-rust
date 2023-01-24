#lang rosette

(require (except-in rackunit fail)
         rackunit/text-ui
         rosette/lib/roseunit
         (prefix-in llvm: serval/llvm)
         serval/lib/unittest
         serval/lib/core)

(require "generated/racket/test/udiv.ll.rkt")

(define-symbolic x y i32)

(define (check-udiv x y result)
  (check-equal? (@udiv (bv x i32) (bv y i32)) (bv result i32)))

(define (check-udiv-concrete)
  (check-udiv 1 5 0)
  (check-udiv 42 5 8)
  (check-true (vc-true? (vc))))

(define (spec-udiv x y)
  (if (bvzero? y) (bv 0 i32) (bvudiv x y)))

(define (check-udiv-symbolic)
  (check-equal? (@udiv x y) (bvudiv x y))
  (check-true (vc-true? (vc))))


(define udiv-tests
  (test-suite+
   "Tests for udiv.c"

   (parameterize ([llvm:current-machine (llvm:make-machine)])
     (test-case+ "udiv-concrete" (check-udiv-concrete))
     (test-case+ "udiv-symbolic" (check-udiv-symbolic))
)))

(module+ test
  (time (run-tests udiv-tests)))
