; ModuleID = 'rusty_risc.05da1a70-cgu.0'
source_filename = "rusty_risc.05da1a70-cgu.0"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-gnu"

%"core::panic::panic_info::PanicInfo" = type { { {}*, [3 x i64]* }, i64*, %"core::panic::location::Location"*, i8, [7 x i8] }
%"core::panic::location::Location" = type { { [0 x i8]*, i64 }, i32, i32 }

; Function Attrs: mustprogress nofree norecurse nosync nounwind nonlazybind readnone willreturn
define signext i32 @test(i32 signext %x, i32 signext %y) unnamed_addr #0 {
start:
  %r = add i32 %y, %x
  ret i32 %r
}

; Function Attrs: nofree norecurse noreturn nosync nounwind nonlazybind readnone
define hidden void @rust_begin_unwind(%"core::panic::panic_info::PanicInfo"* noalias nocapture noundef readonly align 8 dereferenceable(40) %_info) unnamed_addr #1 {
start:
  br label %bb1

bb1:                                              ; preds = %bb1, %start
  br label %bb1
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind nonlazybind readnone willreturn "target-cpu"="generic-rv64" "target-features"="+m,+a,+f,+d,+c" }
attributes #1 = { nofree norecurse noreturn nosync nounwind nonlazybind readnone "target-cpu"="generic-rv64" "target-features"="+m,+a,+f,+d,+c" }

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 1, !"Code Model", i32 3}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
