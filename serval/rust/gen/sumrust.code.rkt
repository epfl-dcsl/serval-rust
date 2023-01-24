; DO NOT MODIFY.
;
; This file was automatically generated.

#lang rosette

(provide (all-defined-out))

(require (prefix-in core: serval/lib/core)
         
         serval/llvm
         serval/llvm/custom
         serval/ubsan)

(define-global @array_to_sum)
(define-global @array_to_sum_2)
(define-global @regions)
(define-global @containers)
(define-global @alloc64)
(define-global @alloc41)
(define-global @alloc43)
(define-global @alloc45)
(define-global @alloc47)
(define-global @alloc49)
(define-global @alloc51)
(define-global @alloc53)
(define-global @alloc55)
(define-global @alloc57)
(define-global @alloc59)
(define-global @alloc61)
(define-global @alloc63)
(define-global @alloc65)
(define-global @alloc66)
(define-global @alloc67)
(define-global @__rustc_debug_gdb_scripts_section__)

(define (@double_sum %xp %yp)
; %start
  (define-label (%start) #:merge #f
    (set! %yp.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %xp.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %y (alloca (core:mcell 4) #:align 4))
    (set! %x (alloca (core:mcell 4) #:align 4))
    (store %xp %xp.dbg.spill (bitvector 32) #:align 4)
    (store %yp %yp.dbg.spill (bitvector 32) #:align 4)
    (store %xp %x (bitvector 32) #:align 4)
    (store %yp %y (bitvector 32) #:align 4)
    (set! %_6 (load %x (bitvector 32) #:align 4))
    (set! %_5 (icmp/uge %_6 (bv #x00989680 32)))
    (br %_5 %bb1 %bb2))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %_8 (load %y (bitvector 32) #:align 4))
    (set! %_7 (icmp/uge %_8 (bv #x00989680 32)))
    (br %_7 %bb3 %bb4))

; %bb1
  (define-label (%bb1) #:merge #f
    (store (bv #x00000000 32) %x (bitvector 32) #:align 4)
    (br %bb2))

; %bb4
  (define-label (%bb4) #:merge #f
    (set! %_10 (load %x (bitvector 32) #:align 4))
    (set! %_11 (load %x (bitvector 32) #:align 4))
    (set! %_9 (call @test %_10 %_11))
    (set! %_13 (load %y (bitvector 32) #:align 4))
    (set! %_14 (load %y (bitvector 32) #:align 4))
    (set! %_12 (call @test %_13 %_14))
    (set! %0 (add %_9 %_12))
    (ret %0))

; %bb3
  (define-label (%bb3) #:merge #f
    (store (bv #x00000000 32) %y (bitvector 32) #:align 4)
    (br %bb4))

  (define-value %yp.dbg.spill)
  (define-value %xp.dbg.spill)
  (define-value %y)
  (define-value %x)
  (define-value %_6)
  (define-value %_5)
  (define-value %_8)
  (define-value %_7)
  (define-value %_10)
  (define-value %_11)
  (define-value %_9)
  (define-value %_13)
  (define-value %_14)
  (define-value %_12)
  (define-value %0)
  (enter! %start))

(define (@rust_begin_unwind %_info)
; %start
  (define-label (%start) #:merge #f
    (set! %_info.dbg.spill (alloca (core:mcell 8) #:align 8))
    (store %_info %_info.dbg.spill pointer #:align 8)
    (br %bb1))

; %bb1
  (define-label (%bb1) #:merge #f
    (br %bb1))

  (define-value %_info.dbg.spill)
  (enter! %start))

(define (@init_array)
; %start
  (define-label (%start) #:merge #f
    (store (bv #x00000001 32) (getelementptr (bitcast @array_to_sum_2) (array-offset (bv #x0000000000000000 64) 20) (array-offset (bv #x0000000000000000 64) 4)) (bitvector 32) #:align 4)
    (store (bv #x00000002 32) (getelementptr (bitcast @array_to_sum_2) (array-offset (bv #x0000000000000000 64) 20) (array-offset (bv #x0000000000000001 64) 4)) (bitvector 32) #:align 4)
    (store (bv #x00000003 32) (getelementptr (bitcast @array_to_sum_2) (array-offset (bv #x0000000000000000 64) 20) (array-offset (bv #x0000000000000002 64) 4)) (bitvector 32) #:align 4)
    (store (bv #x00000004 32) (getelementptr (bitcast @array_to_sum_2) (array-offset (bv #x0000000000000000 64) 20) (array-offset (bv #x0000000000000003 64) 4)) (bitvector 32) #:align 4)
    (store (bv #x00000005 32) (getelementptr (bitcast @array_to_sum_2) (array-offset (bv #x0000000000000000 64) 20) (array-offset (bv #x0000000000000004 64) 4)) (bitvector 32) #:align 4)
    (ret))

  (enter! %start))

(define (@init_memory)
; %start
  (define-label (%start) #:merge #f
    (set! %i (alloca (core:mcell 8) #:align 8))
    (store (bv #x0000000000000000 64) %i (bitvector 64) #:align 8)
    (br %bb1))

; %bb1
  (define-label (%bb1) #:merge #f
    (set! %_3 (load %i (bitvector 64) #:align 8))
    (set! %_2 (icmp/ult %_3 (bv #x0000000000000010 64)))
    (br %_2 %bb2 %bb5))

; %bb5
  (define-label (%bb5) #:merge #f
    (store (bv #x0000000000000000 64) %i (bitvector 64) #:align 8)
    (br %bb6))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %_5 (load %i (bitvector 64) #:align 8))
    (set! %_7 (icmp/ult %_5 (bv #x0000000000000020 64)))
    (set! %0 (call @llvm.expect.i1 %_7 (bv #b1 1)))
    (br %0 %bb3 %panic))

; %bb3
  (define-label (%bb3) #:merge #f
    (set! %1 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_5 8)))
    (set! %2 (bitcast %1))
    (store (bv #x00000000 32) %2 (bitvector 32) #:align 4)
    (set! %_9 (load %i (bitvector 64) #:align 8))
    (set! %_11 (icmp/ult %_9 (bv #x0000000000000020 64)))
    (set! %3 (call @llvm.expect.i1 %_11 (bv #b1 1)))
    (br %3 %bb4 %panic1))

; %panic
  (define-label (%panic) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_5 (bv #x0000000000000020 64) (bitcast @alloc41))
    (unreachable))

; %bb4
  (define-label (%bb4) #:merge #f
    (set! %4 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_9 8)))
    (set! %5 (getelementptr %4 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (store (bv #x00000000 32) %5 (bitvector 32) #:align 4)
    (set! %_12 (load %i (bitvector 64) #:align 8))
    (set! %6 (add %_12 (bv #x0000000000000001 64)))
    (store %6 %i (bitvector 64) #:align 8)
    (br %bb1))

; %panic1
  (define-label (%panic1) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_9 (bv #x0000000000000020 64) (bitcast @alloc43))
    (unreachable))

; %bb6
  (define-label (%bb6) #:merge #f
    (set! %_14 (load %i (bitvector 64) #:align 8))
    (set! %_13 (icmp/ult %_14 (bv #x0000000000000010 64)))
    (br %_13 %bb7 %bb10))

; %bb10
  (define-label (%bb10) #:merge #f
    (ret))

; %bb7
  (define-label (%bb7) #:merge #f
    (set! %_16 (load %i (bitvector 64) #:align 8))
    (set! %_18 (icmp/ult %_16 (bv #x0000000000000020 64)))
    (set! %7 (call @llvm.expect.i1 %_18 (bv #b1 1)))
    (br %7 %bb8 %panic2))

; %bb8
  (define-label (%bb8) #:merge #f
    (set! %8 (getelementptr (bitcast @regions) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_16 8)))
    (set! %9 (bitcast %8))
    (store (bv #x00000000 32) %9 (bitvector 32) #:align 4)
    (set! %_20 (load %i (bitvector 64) #:align 8))
    (set! %_22 (icmp/ult %_20 (bv #x0000000000000020 64)))
    (set! %10 (call @llvm.expect.i1 %_22 (bv #b1 1)))
    (br %10 %bb9 %panic3))

; %panic2
  (define-label (%panic2) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_16 (bv #x0000000000000020 64) (bitcast @alloc45))
    (unreachable))

; %bb9
  (define-label (%bb9) #:merge #f
    (set! %11 (getelementptr (bitcast @regions) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_20 8)))
    (set! %12 (getelementptr %11 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (store (bv #x00 8) %12 (bitvector 8) #:align 4)
    (set! %_23 (load %i (bitvector 64) #:align 8))
    (set! %13 (add %_23 (bv #x0000000000000001 64)))
    (store %13 %i (bitvector 64) #:align 8)
    (br %bb6))

; %panic3
  (define-label (%panic3) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_20 (bv #x0000000000000020 64) (bitcast @alloc47))
    (unreachable))

  (define-value %i)
  (define-value %_3)
  (define-value %_2)
  (define-value %_5)
  (define-value %_7)
  (define-value %0)
  (define-value %1)
  (define-value %2)
  (define-value %_9)
  (define-value %_11)
  (define-value %3)
  (define-value %4)
  (define-value %5)
  (define-value %_12)
  (define-value %6)
  (define-value %_14)
  (define-value %_13)
  (define-value %_16)
  (define-value %_18)
  (define-value %7)
  (define-value %8)
  (define-value %9)
  (define-value %_20)
  (define-value %_22)
  (define-value %10)
  (define-value %11)
  (define-value %12)
  (define-value %_23)
  (define-value %13)
  (enter! %start))

(define (@init_container %container_id)
; %start
  (define-label (%start) #:merge #f
    (set! %container_id.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %i (alloca (core:mcell 8) #:align 8))
    (set! %0 (alloca (core:mcell 1) #:align 1))
    (store %container_id %container_id.dbg.spill (bitvector 32) #:align 4)
    (store (bv #x0000000000000000 64) %i (bitvector 64) #:align 8)
    (set! %_3 (call @container_exists %container_id))
    (br %_3 %bb2 %bb3))

; %bb3
  (define-label (%bb3) #:merge #f
    (set! %_6 (load %i (bitvector 64) #:align 8))
    (set! %_5 (icmp/ult %_6 (bv #x0000000000000004 64)))
    (br %_5 %bb4 %bb10))

; %bb2
  (define-label (%bb2) #:merge #f
    (store (bv #x00 8) %0 (bitvector 8) #:align 1)
    (br %bb11))

; %bb11
  (define-label (%bb11) #:merge #f
    (set! %1 (load %0 (bitvector 8) #:align 1))
    (set! %2 (trunc %1 (bitvector 1)))
    (ret %2))

; %bb10
  (define-label (%bb10) #:merge #f
    (store (bv #x00 8) %0 (bitvector 8) #:align 1)
    (br %bb11))

; %bb4
  (define-label (%bb4) #:merge #f
    (set! %_9 (load %i (bitvector 64) #:align 8))
    (set! %_11 (icmp/ult %_9 (bv #x0000000000000020 64)))
    (set! %3 (call @llvm.expect.i1 %_11 (bv #b1 1)))
    (br %3 %bb5 %panic))

; %bb5
  (define-label (%bb5) #:merge #f
    (set! %4 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_9 8)))
    (set! %5 (bitcast %4))
    (set! %_7 (load %5 (bitvector 32) #:align 4))
    (set! %6 (icmp/eq %_7 (bv #x00000000 32)))
    (br %6 %bb6 %bb9))

; %panic
  (define-label (%panic) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_9 (bv #x0000000000000020 64) (bitcast @alloc49))
    (unreachable))

; %bb6
  (define-label (%bb6) #:merge #f
    (set! %_14 (load %i (bitvector 64) #:align 8))
    (set! %_16 (icmp/ult %_14 (bv #x0000000000000020 64)))
    (set! %7 (call @llvm.expect.i1 %_16 (bv #b1 1)))
    (br %7 %bb7 %panic1))

; %bb9
  (define-label (%bb9) #:merge #f
    (set! %_21 (load %i (bitvector 64) #:align 8))
    (set! %8 (add %_21 (bv #x0000000000000001 64)))
    (store %8 %i (bitvector 64) #:align 8)
    (br %bb3))

; %bb7
  (define-label (%bb7) #:merge #f
    (set! %9 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_14 8)))
    (set! %10 (bitcast %9))
    (store %container_id %10 (bitvector 32) #:align 4)
    (set! %_18 (load %i (bitvector 64) #:align 8))
    (set! %_20 (icmp/ult %_18 (bv #x0000000000000020 64)))
    (set! %11 (call @llvm.expect.i1 %_20 (bv #b1 1)))
    (br %11 %bb8 %panic2))

; %panic1
  (define-label (%panic1) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_14 (bv #x0000000000000020 64) (bitcast @alloc51))
    (unreachable))

; %bb8
  (define-label (%bb8) #:merge #f
    (set! %12 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_18 8)))
    (set! %13 (getelementptr %12 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (store (bv #x00000000 32) %13 (bitvector 32) #:align 4)
    (store (bv #x01 8) %0 (bitvector 8) #:align 1)
    (br %bb11))

; %panic2
  (define-label (%panic2) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_18 (bv #x0000000000000020 64) (bitcast @alloc53))
    (unreachable))

  (define-value %container_id.dbg.spill)
  (define-value %i)
  (define-value %0)
  (define-value %_3)
  (define-value %_6)
  (define-value %_5)
  (define-value %1)
  (define-value %2)
  (define-value %_9)
  (define-value %_11)
  (define-value %3)
  (define-value %4)
  (define-value %5)
  (define-value %_7)
  (define-value %6)
  (define-value %_14)
  (define-value %_16)
  (define-value %7)
  (define-value %_21)
  (define-value %8)
  (define-value %9)
  (define-value %10)
  (define-value %_18)
  (define-value %_20)
  (define-value %11)
  (define-value %12)
  (define-value %13)
  (enter! %start))

(define (@container_position %container_id)
; %start
  (define-label (%start) #:merge #f
    (set! %container_id.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %_7 (alloca (core:mcell 1) #:align 1))
    (set! %i (alloca (core:mcell 8) #:align 8))
    (set! %0 (alloca (core:mcell 8) #:align 8))
    (store %container_id %container_id.dbg.spill (bitvector 32) #:align 4)
    (store (bv #x0000000000000000 64) %i (bitvector 64) #:align 8)
    (set! %_3 (icmp/ule %container_id (bv #x00000000 32)))
    (br %_3 %bb1 %bb2))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %_6 (load %i (bitvector 64) #:align 8))
    (set! %_5 (icmp/ult %_6 (bv #x0000000000000004 64)))
    (br %_5 %bb3 %bb11))

; %bb1
  (define-label (%bb1) #:merge #f
    (store (bv #xffffffffffffffff 64) %0 (bitvector 64) #:align 8)
    (br %bb12))

; %bb12
  (define-label (%bb12) #:merge #f
    (set! %1 (load %0 (bitvector 64) #:align 8))
    (ret %1))

; %bb11
  (define-label (%bb11) #:merge #f
    (store (bv #xffffffffffffffff 64) %0 (bitvector 64) #:align 8)
    (br %bb12))

; %bb3
  (define-label (%bb3) #:merge #f
    (set! %_11 (load %i (bitvector 64) #:align 8))
    (set! %_13 (icmp/ult %_11 (bv #x0000000000000020 64)))
    (set! %2 (call @llvm.expect.i1 %_13 (bv #b1 1)))
    (br %2 %bb7 %panic))

; %bb7
  (define-label (%bb7) #:merge #f
    (set! %3 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_11 8)))
    (set! %4 (bitcast %3))
    (set! %_9 (load %4 (bitvector 32) #:align 4))
    (set! %_8 (icmp/eq %_9 %container_id))
    (br %_8 %bb5 %bb4))

; %panic
  (define-label (%panic) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_11 (bv #x0000000000000020 64) (bitcast @alloc55))
    (unreachable))

; %bb4
  (define-label (%bb4) #:merge #f
    (store (bv #x00 8) %_7 (bitvector 8) #:align 1)
    (br %bb6))

; %bb5
  (define-label (%bb5) #:merge #f
    (set! %_18 (load %i (bitvector 64) #:align 8))
    (set! %_20 (icmp/ult %_18 (bv #x0000000000000020 64)))
    (set! %5 (call @llvm.expect.i1 %_20 (bv #b1 1)))
    (br %5 %bb8 %panic1))

; %bb8
  (define-label (%bb8) #:merge #f
    (set! %6 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_18 8)))
    (set! %7 (bitcast %6))
    (set! %_16 (load %7 (bitvector 32) #:align 4))
    (set! %_15 (icmp/ne %_16 (bv #x00000000 32)))
    (set! %8 (zext %_15 (bitvector 8)))
    (store %8 %_7 (bitvector 8) #:align 1)
    (br %bb6))

; %panic1
  (define-label (%panic1) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_18 (bv #x0000000000000020 64) (bitcast @alloc57))
    (unreachable))

; %bb6
  (define-label (%bb6) #:merge #f
    (set! %9 (load %_7 (bitvector 8) #:align 1))
    (set! %10 (trunc %9 (bitvector 1)))
    (br %10 %bb9 %bb10))

; %bb10
  (define-label (%bb10) #:merge #f
    (set! %_21 (load %i (bitvector 64) #:align 8))
    (set! %11 (add %_21 (bv #x0000000000000001 64)))
    (store %11 %i (bitvector 64) #:align 8)
    (br %bb2))

; %bb9
  (define-label (%bb9) #:merge #f
    (set! %12 (load %i (bitvector 64) #:align 8))
    (store %12 %0 (bitvector 64) #:align 8)
    (br %bb12))

  (define-value %container_id.dbg.spill)
  (define-value %_7)
  (define-value %i)
  (define-value %0)
  (define-value %_3)
  (define-value %_6)
  (define-value %_5)
  (define-value %1)
  (define-value %_11)
  (define-value %_13)
  (define-value %2)
  (define-value %3)
  (define-value %4)
  (define-value %_9)
  (define-value %_8)
  (define-value %_18)
  (define-value %_20)
  (define-value %5)
  (define-value %6)
  (define-value %7)
  (define-value %_16)
  (define-value %_15)
  (define-value %8)
  (define-value %9)
  (define-value %10)
  (define-value %_21)
  (define-value %11)
  (define-value %12)
  (enter! %start))

(define (@add_region %container_id)
; %start
  (define-label (%start) #:merge #f
    (set! %container_id.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %i (alloca (core:mcell 8) #:align 8))
    (set! %0 (alloca (core:mcell 4) #:align 4))
    (store %container_id %container_id.dbg.spill (bitvector 32) #:align 4)
    (set! %_3 (call @container_exists %container_id))
    (set! %_2 (xor %_3 (bv #b1 1)))
    (br %_2 %bb2 %bb3))

; %bb3
  (define-label (%bb3) #:merge #f
    (store (bv #x0000000000000000 64) %i (bitvector 64) #:align 8)
    (br %bb4))

; %bb2
  (define-label (%bb2) #:merge #f
    (store (bv #xffffffff 32) %0 (bitvector 32) #:align 4)
    (br %bb14))

; %bb14
  (define-label (%bb14) #:merge #f
    (set! %1 (load %0 (bitvector 32) #:align 4))
    (ret %1))

; %bb4
  (define-label (%bb4) #:merge #f
    (set! %_7 (load %i (bitvector 64) #:align 8))
    (set! %_6 (icmp/ult %_7 (bv #x0000000000000004 64)))
    (br %_6 %bb5 %bb13))

; %bb13
  (define-label (%bb13) #:merge #f
    (store (bv #xffffffff 32) %0 (bitvector 32) #:align 4)
    (br %bb14))

; %bb5
  (define-label (%bb5) #:merge #f
    (set! %_11 (load %i (bitvector 64) #:align 8))
    (set! %_13 (icmp/ult %_11 (bv #x0000000000000020 64)))
    (set! %2 (call @llvm.expect.i1 %_13 (bv #b1 1)))
    (br %2 %bb6 %panic))

; %bb6
  (define-label (%bb6) #:merge #f
    (set! %3 (getelementptr (bitcast @regions) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_11 8)))
    (set! %4 (getelementptr %3 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (set! %5 (load %4 (bitvector 8) #:align 4))
    (set! %_9 (trunc %5 (bitvector 1)))
    (set! %_8 (xor %_9 (bv #b1 1)))
    (br %_8 %bb7 %bb12))

; %panic
  (define-label (%panic) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_11 (bv #x0000000000000020 64) (bitcast @alloc59))
    (unreachable))

; %bb12
  (define-label (%bb12) #:merge #f
    (set! %_29 (load %i (bitvector 64) #:align 8))
    (set! %6 (add %_29 (bv #x0000000000000001 64)))
    (store %6 %i (bitvector 64) #:align 8)
    (br %bb4))

; %bb7
  (define-label (%bb7) #:merge #f
    (set! %_16 (load %i (bitvector 64) #:align 8))
    (set! %_18 (icmp/ult %_16 (bv #x0000000000000020 64)))
    (set! %7 (call @llvm.expect.i1 %_18 (bv #b1 1)))
    (br %7 %bb8 %panic1))

; %bb8
  (define-label (%bb8) #:merge #f
    (set! %8 (getelementptr (bitcast @regions) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_16 8)))
    (set! %9 (bitcast %8))
    (store %container_id %9 (bitvector 32) #:align 4)
    (set! %_20 (load %i (bitvector 64) #:align 8))
    (set! %_22 (icmp/ult %_20 (bv #x0000000000000020 64)))
    (set! %10 (call @llvm.expect.i1 %_22 (bv #b1 1)))
    (br %10 %bb9 %panic2))

; %panic1
  (define-label (%panic1) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_16 (bv #x0000000000000020 64) (bitcast @alloc61))
    (unreachable))

; %bb9
  (define-label (%bb9) #:merge #f
    (set! %11 (getelementptr (bitcast @regions) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_20 8)))
    (set! %12 (getelementptr %11 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (store (bv #x01 8) %12 (bitvector 8) #:align 4)
    (set! %_24 (call @container_position %container_id))
    (set! %_27 (icmp/ult %_24 (bv #x0000000000000020 64)))
    (set! %13 (call @llvm.expect.i1 %_27 (bv #b1 1)))
    (br %13 %bb11 %panic3))

; %panic2
  (define-label (%panic2) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_20 (bv #x0000000000000020 64) (bitcast @alloc63))
    (unreachable))

; %bb11
  (define-label (%bb11) #:merge #f
    (set! %14 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_24 8)))
    (set! %15 (getelementptr %14 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (set! %16 (getelementptr (bitcast @containers) (array-offset (bv #x0000000000000000 64) 256) (array-offset %_24 8)))
    (set! %17 (getelementptr %16 (array-offset (bv #x00000000 32) 8) (struct-offset 4)))
    (set! %18 (load %17 (bitvector 32) #:align 4))
    (set! %19 (add %18 (bv #x00000001 32)))
    (store %19 %15 (bitvector 32) #:align 4)
    (set! %_28 (load %i (bitvector 64) #:align 8))
    (set! %20 (trunc %_28 (bitvector 32)))
    (store %20 %0 (bitvector 32) #:align 4)
    (br %bb14))

; %panic3
  (define-label (%panic3) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_24 (bv #x0000000000000020 64) (bitcast @alloc65))
    (unreachable))

  (define-value %container_id.dbg.spill)
  (define-value %i)
  (define-value %0)
  (define-value %_3)
  (define-value %_2)
  (define-value %1)
  (define-value %_7)
  (define-value %_6)
  (define-value %_11)
  (define-value %_13)
  (define-value %2)
  (define-value %3)
  (define-value %4)
  (define-value %5)
  (define-value %_9)
  (define-value %_8)
  (define-value %_29)
  (define-value %6)
  (define-value %_16)
  (define-value %_18)
  (define-value %7)
  (define-value %8)
  (define-value %9)
  (define-value %_20)
  (define-value %_22)
  (define-value %10)
  (define-value %11)
  (define-value %12)
  (define-value %_24)
  (define-value %_27)
  (define-value %13)
  (define-value %14)
  (define-value %15)
  (define-value %16)
  (define-value %17)
  (define-value %18)
  (define-value %19)
  (define-value %_28)
  (define-value %20)
  (enter! %start))

(define (@test %x %y)
; %start
  (define-label (%start) #:merge #f
    (set! %r.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %y.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %x.dbg.spill (alloca (core:mcell 4) #:align 4))
    (store %x %x.dbg.spill (bitvector 32) #:align 4)
    (store %y %y.dbg.spill (bitvector 32) #:align 4)
    (set! %r (add %x %y))
    (store %r %r.dbg.spill (bitvector 32) #:align 4)
    (ret %r))

  (define-value %r.dbg.spill)
  (define-value %y.dbg.spill)
  (define-value %x.dbg.spill)
  (define-value %r)
  (enter! %start))

(define (@equality %x %y)
; %start
  (define-label (%start) #:merge #f
    (set! %y.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %x.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %_7 (alloca (core:mcell 1) #:align 1))
    (set! %_3 (alloca (core:mcell 1) #:align 1))
    (set! %0 (alloca (core:mcell 1) #:align 1))
    (store %x %x.dbg.spill (bitvector 32) #:align 4)
    (store %y %y.dbg.spill (bitvector 32) #:align 4)
    (set! %_4 (icmp/eq %x %y))
    (br %_4 %bb1 %bb2))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %1 (icmp/eq %x (bv #x00000000 32)))
    (br %1 %bb5 %bb4))

; %bb1
  (define-label (%bb1) #:merge #f
    (store (bv #x01 8) %_3 (bitvector 8) #:align 1)
    (br %bb3))

; %bb3
  (define-label (%bb3) #:merge #f
    (set! %2 (load %_3 (bitvector 8) #:align 1))
    (set! %3 (trunc %2 (bitvector 1)))
    (br %3 %bb7 %bb8))

; %bb5
  (define-label (%bb5) #:merge #f
    (set! %_9 (icmp/eq %y (bv #x00000001 32)))
    (set! %4 (zext %_9 (bitvector 8)))
    (store %4 %_7 (bitvector 8) #:align 1)
    (br %bb6))

; %bb4
  (define-label (%bb4) #:merge #f
    (store (bv #x00 8) %_7 (bitvector 8) #:align 1)
    (br %bb6))

; %bb6
  (define-label (%bb6) #:merge #f
    (set! %5 (load %_7 (bitvector 8) #:align 1))
    (set! %6 (trunc %5 (bitvector 1)))
    (set! %7 (zext %6 (bitvector 8)))
    (store %7 %_3 (bitvector 8) #:align 1)
    (br %bb3))

; %bb8
  (define-label (%bb8) #:merge #f
    (store (bv #x00 8) %0 (bitvector 8) #:align 1)
    (br %bb9))

; %bb7
  (define-label (%bb7) #:merge #f
    (store (bv #x01 8) %0 (bitvector 8) #:align 1)
    (br %bb9))

; %bb9
  (define-label (%bb9) #:merge #f
    (set! %8 (load %0 (bitvector 8) #:align 1))
    (ret %8))

  (define-value %y.dbg.spill)
  (define-value %x.dbg.spill)
  (define-value %_7)
  (define-value %_3)
  (define-value %0)
  (define-value %_4)
  (define-value %1)
  (define-value %2)
  (define-value %3)
  (define-value %_9)
  (define-value %4)
  (define-value %5)
  (define-value %6)
  (define-value %7)
  (define-value %8)
  (enter! %start))

(define (@example %a %b)
; %start
  (define-label (%start) #:merge #f
    (set! %b.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %a.dbg.spill (alloca (core:mcell 4) #:align 4))
    (set! %c (alloca (core:mcell 4) #:align 4))
    (store %a %a.dbg.spill (bitvector 32) #:align 4)
    (store %b %b.dbg.spill (bitvector 32) #:align 4)
    (store %a %c (bitvector 32) #:align 4)
    (set! %_3 (urem %a (bv #x00000002 32)))
    (set! %0 (icmp/eq %_3 (bv #x00000000 32)))
    (br %0 %bb1 %bb2))

; %bb1
  (define-label (%bb1) #:merge #f
    (store (bv #x00000001 32) %c (bitvector 32) #:align 4)
    (br %bb2))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %_5 (icmp/ugt %b (bv #x0000000a 32)))
    (br %_5 %bb3 %bb4))

; %bb4
  (define-label (%bb4) #:merge #f
    (set! %1 (load %c (bitvector 32) #:align 4))
    (ret %1))

; %bb3
  (define-label (%bb3) #:merge #f
    (set! %2 (add %b (bv #x00000001 32)))
    (store %2 %c (bitvector 32) #:align 4)
    (br %bb4))

  (define-value %b.dbg.spill)
  (define-value %a.dbg.spill)
  (define-value %c)
  (define-value %_3)
  (define-value %0)
  (define-value %_5)
  (define-value %1)
  (define-value %2)
  (enter! %start))

(define (@sum_array)
; %start
  (define-label (%start) #:merge #f
    (set! %i (alloca (core:mcell 8) #:align 8))
    (set! %result (alloca (core:mcell 8) #:align 8))
    (store (bv #x0000000000000000 64) %result (bitvector 64) #:align 8)
    (store (bv #x0000000000000000 64) %i (bitvector 64) #:align 8)
    (br %bb1))

; %bb1
  (define-label (%bb1) #:merge #f
    (set! %_3 (load %i (bitvector 64) #:align 8))
    (set! %_2 (icmp/ult %_3 (bv #x0000000000000005 64)))
    (br %_2 %bb2 %bb4))

; %bb4
  (define-label (%bb4) #:merge #f
    (set! %0 (load %result (bitvector 64) #:align 8))
    (ret %0))

; %bb2
  (define-label (%bb2) #:merge #f
    (set! %_7 (load %i (bitvector 64) #:align 8))
    (set! %_9 (icmp/ult %_7 (bv #x0000000000000005 64)))
    (set! %1 (call @llvm.expect.i1 %_9 (bv #b1 1)))
    (br %1 %bb3 %panic))

; %bb3
  (define-label (%bb3) #:merge #f
    (set! %2 (getelementptr (bitcast @array_to_sum_2) (array-offset (bv #x0000000000000000 64) 20) (array-offset %_7 4)))
    (set! %_5 (load %2 (bitvector 32) #:align 4))
    (set! %_4 (zext %_5 (bitvector 64)))
    (set! %3 (load %result (bitvector 64) #:align 8))
    (set! %4 (add %3 %_4))
    (store %4 %result (bitvector 64) #:align 8)
    (set! %_10 (load %i (bitvector 64) #:align 8))
    (set! %5 (add %_10 (bv #x0000000000000001 64)))
    (store %5 %i (bitvector 64) #:align 8)
    (br %bb1))

; %panic
  (define-label (%panic) #:merge #f
    (call @_ZN4core9panicking18panic_bounds_check17ha7c05f42395e6192E %_7 (bv #x0000000000000005 64) (bitcast @alloc67))
    (unreachable))

  (define-value %i)
  (define-value %result)
  (define-value %_3)
  (define-value %_2)
  (define-value %0)
  (define-value %_7)
  (define-value %_9)
  (define-value %1)
  (define-value %2)
  (define-value %_5)
  (define-value %_4)
  (define-value %3)
  (define-value %4)
  (define-value %_10)
  (define-value %5)
  (enter! %start))

(define (@container_exists %container_id)
; %start
  (define-label (%start) #:merge #f
    (set! %container_id.dbg.spill (alloca (core:mcell 4) #:align 4))
    (store %container_id %container_id.dbg.spill (bitvector 32) #:align 4)
    (set! %_2 (call @container_position %container_id))
    (set! %0 (icmp/ne %_2 (bv #xffffffffffffffff 64)))
    (ret %0))

  (define-value %container_id.dbg.spill)
  (define-value %_2)
  (define-value %0)
  (enter! %start))






