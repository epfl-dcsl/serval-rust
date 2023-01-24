
 
#lang rosette

(require (except-in rackunit fail)
         rackunit/text-ui
         rosette/lib/roseunit
         (prefix-in llvm: serval/llvm)
         serval/lib/unittest
         serval/lib/core)


(require rosette/lib/value-browser)
(require "gen/sumrust.map.rkt"
         "gen/sumrust.globals.rkt")
(require "gen/sumrust.code.rkt")




(define (check-function0 f )
    (define r (verify (f)))
    (if (unsat? r) (assert (unsat? r)) (f))
    
)




(define (aaaa)
(define-symbolic x i32)
(define-symbolic y i32)
(define result (@equality x y ))
(cond 
[(bveq x y) (assert (bveq result (bv 1 i8)) )
]
[else (assert (bveq result (bv 0 i8)) )
]

)

)



(define (bello x y)

(print "x = " )
(println x )
(print "y = " )
(println y )

)



(define (lemma1)
(define-symbolic new_container_id i32)
(cond 
[(bveq (@init_container new_container_id ) (bv 0 i8)) (define result #f)
(for ([c 32])
(set! result (or result (mblock-iload (llvm:symbol->block 'containers) (list (bv c 64 ) 'id ))))

)
]

)

)



(define (bbbb)
(define-symbolic x i32)
(define-symbolic y i32)
(set! x (bvadd (bv 3 i32) x))
(bello x y )
(println (@example x y ) )

)



(define (sum_array)
(for ([i 4])
(println (mblock-iload (llvm:symbol->block 'array_to_sum_2) (list (bv i 64 ) )) )

)

)



(define (signed)
(define z (bvsub (bv 3 i8) (bv 5 i8)))
(define t (bvult z (bv 0 i8)))
(define q (bvslt z (bv 0 i8)))
(println t )

)



(define (test)
(define-symbolic a i32)
(define-symbolic b i32)
(assert (bveq (@test a b ) ((bvadd a b))) )

)



(define (container_exists)
(@init_memory )
(@init_container (bv 3 i32) )
(define-symbolic x i32)
(println (@container_exists x ) )

)




(define rust-tests
    (test-suite+
     "Tests rust-generated"
    (parameterize ([llvm:current-machine (llvm:make-machine symbols globals)])
        
        (test-case+ "aaaa" (check-function0 aaaa))

        (test-case+ "lemma1" (check-function0 lemma1))

        (test-case+ "bbbb" (check-function0 bbbb))

        (test-case+ "sum_array" (check-function0 sum_array))

        (test-case+ "signed" (check-function0 signed))

        (test-case+ "test" (check-function0 test))

        (test-case+ "container_exists" (check-function0 container_exists))

    )))

(module+ test
    (time (run-tests rust-tests)))

