#lang rosette

(require (except-in rackunit fail)
         rackunit/text-ui
         rosette/lib/roseunit
         (prefix-in llvm: serval/llvm)
         serval/lib/unittest
         serval/lib/core
rosette/lib/value-browser
         )


(require rosette/lib/value-browser)
(require "gen/sumrust.map.rkt"
         "gen/sumrust.globals.rkt")

(require "gen/sumrust.code.rkt")

(define-symbolic x y i32)


(define (test-container-exists)
  (define conts (llvm:symbol->block 'containers))

  (define-symbolic i i64)
  (define-symbolic c_id i32)

  (assume (bvult c_id (bv 16 i32)))
  (assume (bvugt c_id (bv 0 i32)))
  (assume (bvult i (bv 16 i64)))

  (assert (=> (bveq (mblock-iload conts (list i 'id)) c_id) (bveq (@container_exists c_id) (bv 1 1))))

)

(define (lemma-1-prove-creation)
  (define-symbolic new_container_id i64)  
  
  (if (bveq (@init_container new_container_id) (bv 0 i8))
    (let ()
      (define contains #f)
      (for ([c 32])
        (define current_id (mblock-iload (llvm:symbol->block 'containers) (list c 'id)))
        (set! contains (or (bveq new_container_id current_id) contains))
      )

      (assert contains)
    )
    (assert #t)
  )
)

(define (lemma-2-prove-fail-on-existing)
  (define-symbolic new_container_id i32)
  
  (if (bveq (@container_exists new_container_id) (bv 1 i8))
    (assert (bveq (@init_container new_container_id) (bv 0 i8)))
    (assert #t)
  )
)

(define (test-container-exists-sym)

  (define-symbolic i i64)
  (define-symbolic c_id i32)
  (assume (bvugt c_id (bv 0 i32)))
  (assume (bvult c_id (bv 32 i32)))
  (@init_memory)
  (@init_container c_id)

  (define result (@container_exists c_id))

  (assert (bveq result (bv 1 1)))
)

(define (inv-region-count-pre containers n_containers regions n_regions)
  (println containers)
  (println regions)

  (for ([c n_containers])
    (define-symbolic current-id (mblock-iload containers (list (bv c i64) 'id)))

    ;(when (not (bveq current-id (bv 0 i32)))
      (define expected-count (mblock-iload containers (list (bv c i64) 'region_count)))
      (define actual-count (bv 0 i32))

      (for ([r n_regions])
        (when (and (bveq (mblock-iload regions (list (bv r i64) 'valid)) (bv 1 8)) (bveq (mblock-iload regions (list (bv r i64) 'container_id)) current-id))
          (set! actual-count (bvadd actual-count (bv 1 i32)))
        )     
      )

      (println current-id)
      (println (not (bveq current-id (bv 0 i32))))
      (println actual-count)
      (println expected-count)
      (assume (=> (not (bveq current-id (bv 0 i32))) (bveq expected-count actual-count)))
      (println "")

    ;)
  )

  (println "")
  (println "")
)

(define (inv-region-count containers n_containers regions n_regions)

  (for ([c n_containers])
    (define current-id (mblock-iload containers (list (bv c i64) 'id)))
    (println current-id)

    (when (not (bveq current-id (bv 0 i32)))
      (define expected-count (mblock-iload containers (list (bv c i64) 'region_count)))
      (define actual-count (bv 0 i32))

      (for ([r n_regions])
        (when (and (bveq (mblock-iload regions (list (bv r i64) 'valid)) (bv 1 8)) (bveq (mblock-iload regions (list (bv r i64) 'container_id)) current-id))
          (set! actual-count (bvadd actual-count (bv 1 i32)))
        )     
      )
    
      (println expected-count)
      (println actual-count)
      (assert (bveq expected-count actual-count))

    )
  )
)



(define (test-container-init)

(define conts (llvm:symbol->block 'containers))
(define regs (llvm:symbol->block 'regions))

(define-symbolic c_id i32)


;(@init_memory)




;(@init_container c_id)

;(println (@container_exists c_id))



;(inv-region-count conts 16 regs 16)

(define r (@add_region c_id))

(println r)

;(inv-region-count conts 16 regs 16)


)

(define (test-container-init2)

(define conts (llvm:symbol->block 'containers))
(define regs (llvm:symbol->block 'regions))

(define-symbolic c_id i32)
(define-symbolic c_id_q i32)
(define-symbolic c i64)

;(assume (bvuge c_id (bv 0 i32)))



;(@init_memory)




(define r (@init_container c_id_q))

(println r)

 ; (render-value/window r)

;(println (@container_exists c_id))

(assert (forall 
  (var c_id_q) 
  (=> 
    (not (bveq c_id_q (bv 0 i32))) 
    (|| 
      (exists (var c) (bveq (mblock-iload conts (list c 'id)) c_id_q))
      (bveq r (bv 1 1))))))

;(inv-region-count conts 16 regs 16)

;(define r (@add_region c_id))

;(println r)

;(inv-region-count conts 16 regs 16)


)




(define (test-container-doesnt-exists-sym)
; (@init_array)

(define-symbolic i i64)
(define-symbolic c_id i32)
(define-symbolic c_id2 i32)
(define conts (llvm:symbol->block 'containers))
(assume (bvugt c_id (bv 0 i32)))
(assume (bvult c_id (bv 32 i32)))
(assume (bvugt c_id2 (bv 0 i32)))
(assume (bvult c_id2 (bv 32 i32)))
(assume (not (bveq c_id c_id2)))

(@init_memory)
(@init_container c_id)

(define result (@container_exists c_id2))

(println result)
)



(define (check-function2 f x y)
  (define r (verify (f x y)))
  (assert (unsat? r) r))


(define (check-function1 f x)
  (define r (verify (f x)))
  (assert (unsat? r) r)
  )

  (define (check-function0 f )
  (define r (verify (f)))
  (assert (unsat? r) r)
  )




(define rust-tests
  (test-suite+
   "Tests for rust functions"
   (parameterize ([llvm:current-machine (llvm:make-machine symbols globals)])
   (test-case+ "container exists" (check-function0 test-container-exists-sym))
   (test-case+ "container does not exists" (check-function0 test-container-doesnt-exists-sym))
   (test-case+ "container exists forall" (check-function0 test-container-exists))
   (test-case+ "container init" (test-container-init))
   (test-case+ "container init2" (check-function0 test-container-init2))
   ;(test-case+ "sum array" (check-function1 test-array-sum v))
   )))

(module+ test
  (time (run-tests rust-tests)))
