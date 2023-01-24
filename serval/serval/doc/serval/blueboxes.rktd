2110
((3) 0 () 6 ((q lib "serval/lib/core.rkt") (q 457 . 9) (q 1924 . 7) (q 5472 . 9) (q 993 . 7) (q 723 . 9)) () (h ! (equal) ((c def c (c (? . 0) q incr-refcnt)) c (? . 3)) ((c def c (c (? . 0) q mblock-inbounds?)) q (1431 . 5)) ((c def c (c (? . 0) q bug)) q (187 . 5)) ((c def c (c (? . 0) q mblock-size)) q (1362 . 3)) ((c def c (c (? . 0) q find-mregion-by-name)) q (2082 . 4)) ((c def c (c (? . 0) q find-mregion-by-addr)) q (2192 . 4)) ((c def c (c (? . 0) q bvsdiv-overflow?)) q (1181 . 4)) ((c def c (c (? . 0) q bug-format)) q (374 . 4)) ((c def c (c (? . 0) q bvumul-overflow?)) c (? . 4)) ((c def c (c (? . 0) q bug-clear!)) q (340 . 2)) ((c def c (c (? . 0) q check-weak-step-consistency)) q (3634 . 21)) ((c def c (c (? . 0) q bvuadd-overflow?)) c (? . 1)) ((c def c (c (? . 0) q mblock?)) q (1309 . 3)) ((c def c (c (? . 0) q refcnt-invariants)) q (5710 . 11)) ((c def c (c (? . 0) q mblock-iload)) q (1715 . 4)) ((c def c (c (? . 0) q verify-refinement)) q (2471 . 17)) ((c def c (c (? . 0) q mblock-path)) q (1577 . 5)) ((c def c (c (? . 0) q bvsadd-overflow?)) c (? . 1)) ((c def c (c (? . 0) q mregion-block)) c (? . 2)) ((c def c (c (? . 0) q check-local-respect)) q (4553 . 21)) ((c def c (c (? . 0) q mregion?)) c (? . 2)) ((c def c (c (? . 0) q make-havoc-refcnt)) q (5429 . 2)) ((c def c (c (? . 0) q gen:mblock)) q (1280 . 2)) ((c def c (c (? . 0) q bvusub-overflow?)) c (? . 5)) ((c def c (c (? . 0) q init-refcnt)) q (5392 . 2)) ((c def c (c (? . 0) q mregion-start)) c (? . 2)) ((c def c (c (? . 0) q bug-on)) q (0 . 6)) ((c def c (c (? . 0) q struct:mregion)) c (? . 2)) ((c form c (c (? . 0) q split-pc)) q (2425 . 2)) ((c def c (c (? . 0) q decr-refcnt)) c (? . 3)) ((c def c (c (? . 0) q split-cases)) q (2309 . 5)) ((c def c (c (? . 0) q bvsmul-overflow?)) c (? . 4)) ((c def c (c (? . 0) q mregion-end)) c (? . 2)) ((c def c (c (? . 0) q bvssub-overflow?)) c (? . 5)) ((c def c (c (? . 0) q check-step-consistency)) q (3179 . 11)) ((c def c (c (? . 0) q mblock-istore!)) q (1804 . 5)) ((c def c (c (? . 0) q mregion-name)) c (? . 2)) ((c def c (c (? . 0) q mregion)) c (? . 2))))
procedure
(bug-on cond [#:key key #:dbg dbg #:msg msg]) -> void?
  cond : boolean?
  key : any/c = #f
  dbg : any/c = #f
  msg : string? = "Unknown bug-on"
procedure
(bug [#:key key #:dbg dbg #:msg msg]) -> void?
  key : any/c = #f
  dbg : any/c = #f
  msg : string? = "Unknown bug"
procedure
(bug-clear!) -> void?
procedure
(bug-format data sol) -> string?
  data : dict?
  sol : sat?
procedure
(bvsadd-overflow? x y [carry]) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
  carry : boolean? = #f
(bvuadd-overflow? x y [carry]) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
  carry : boolean? = #f
procedure
(bvssub-overflow? x y [borrow]) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
  borrow : boolean? = #f
(bvusub-overflow? x y [borrow]) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
  borrow : boolean? = #f
procedure
(bvsmul-overflow? x y) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
(bvumul-overflow? x y) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
procedure
(bvsdiv-overflow? x y) -> boolean?
  x : (bitvector n)
  y : (bitvector n)
value
gen:mblock : mblock?
procedure
(mblock? v) -> boolean?
  v : any/c
procedure
(mblock-size mblock) -> integer?
  mblock : mblock?
procedure
(mblock-inbounds? mblock offset size) -> boolean?
  mblock : mblock?
  offset : (bitvector n)
  size : (bitvector n)
procedure
(mblock-path mblock offset size) -> list?
  mblock : mblock?
  offset : (bitvector n)
  size : (bitvector n)
procedure
(mblock-iload mblock path) -> any
  mblock : mblock?
  path : list
procedure
(mblock-istore! mblock value path) -> void?
  mblock : mblock?
  value : any/c
  path : list
struct
(struct mregion (start end name block)
    #:transparent)
  start : integer?
  end : integer?
  name : symbol?
  block : mblock?
procedure
(find-mregion-by-name lst name) -> mregion?
  lst : (listof mregion?)
  name : symbol?
procedure
(find-mregion-by-addr lst addr) -> mregion?
  lst : (listof mregion?)
  addr : (bitvector n)
procedure
(split-cases expr cases proc) -> any?
  expr : any/c
  cases : list?
  proc : procedure?
syntax
(split-pc [struct field] expr ...)
procedure
(verify-refinement  #:implstate impl-state     
                    #:impl impl-func           
                    #:specstate spec-state     
                    #:spec spec-func           
                    #:abs abs-function         
                    #:ri rep-invariant         
                   [args                       
                    ce-handler])           -> void?
  impl-state : any/c
  impl-func : procedure?
  spec-state : any/c
  spec-func : procedure?
  abs-function : procedure?
  rep-invariant : procedure?
  args : list? = null
  ce-handler : procedure? = (lambda (sol) (void))
procedure
(check-step-consistency  #:state-init init-state     
                         #:state-copy state-copy     
                         #:unwinding unwinding       
                         spec                        
                        [args])                  -> void?
  init-state : procedure?
  state-copy : procedure?
  unwinding : procedure?
  spec : procedure?
  args : list? = null
procedure
(check-weak-step-consistency  #:state-init init-state     
                              #:state-copy state-copy     
                              #:invariants inv            
                              #:dom dom                   
                              #:u u                       
                              #:unwinding unwinding       
                              #:flowsto flowsto           
                              action                      
                              spec                        
                             [args])                  -> void?
  init-state : procedure?
  state-copy : procedure?
  inv : procedure?
  dom : procedure?
  u : any/c
  unwinding : procedure?
  flowsto : procedure?
  action : any/c
  spec : procedure?
  args : list? = null
procedure
(check-local-respect  #:state-init init-state     
                      #:state-copy state-copy     
                      #:invariants inv            
                      #:dom dom                   
                      #:u u                       
                      #:unwinding unwinding       
                      #:flowsto flowsto           
                      action                      
                      spec                        
                     [args])                  -> void?
  init-state : procedure?
  state-copy : procedure?
  inv : procedure?
  dom : procedure?
  u : any/c
  unwinding : procedure?
  flowsto : procedure?
  action : any/c
  spec : procedure?
  args : list? = null
procedure
(init-refcnt) -> refcnt?
procedure
(make-havoc-refcnt) -> refcnt?
procedure
(incr-refcnt refcnt owner object) -> refcnt?
  refcnt : refcnt?
  owner : any/c
  object : any/c
(decr-refcnt refcnt owner object) -> refcnt?
  refcnt : refcnt?
  owner : any/c
  object : any/c
procedure
(refcnt-invariants refcnt            
                   owner-valid?      
                   object-valid?     
                   max-refs          
                   owned-by?)    -> boolean?
  refcnt : refcnt?
  owner-valid? : procedure?
  object-valid? : procedure?
  max-refs : (bitvector n)
  owned-by? : procedure?
