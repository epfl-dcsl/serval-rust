pub const RKT_HEADER: &str = r#" 
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

"#;

pub const RKT_DEFS: &str = r#"
(define (check-function0 f )
    (define r (verify (f)))
    (if (unsat? r) (assert (unsat? r)) (f))
    
)
"#;

pub const RKT_TESTS: &str = r#"
(define rust-tests
    (test-suite+
     "Tests {name}"
    (parameterize ([llvm:current-machine (llvm:make-machine symbols globals)])
        {tests}
    )))

(module+ test
    (time (run-tests rust-tests)))
"#;

pub const RKT_TEST: &str = r#"
        (test-case+ "{name}" (check-function0 {function_name}))
"#;

pub const RKT_FUNCTION: &str = r#"

(define ({function_name})
{body}
)

"#;

pub const RKT_BASE: &str = r#"
{header}

{defs}

{functions}

{tests}
"#;


