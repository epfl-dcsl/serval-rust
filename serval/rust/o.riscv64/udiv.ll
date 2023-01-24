; ModuleID = 'udiv.c'
source_filename = "udiv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local i32 @udiv(i32 noundef %x, i32 noundef %y) local_unnamed_addr #0 !dbg !8 {
entry:
  call void @llvm.dbg.value(metadata i32 %x, metadata !15, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.value(metadata i32 %y, metadata !16, metadata !DIExpression()), !dbg !18
  %cmp = icmp eq i32 %y, 0, !dbg !19
  br i1 %cmp, label %return, label %cont, !dbg !21

cont:                                             ; preds = %entry
  %div = udiv i32 %x, %y, !dbg !22
  call void @llvm.dbg.value(metadata i32 %div, metadata !17, metadata !DIExpression()), !dbg !18
  br label %return

return:                                           ; preds = %entry, %cont
  %retval.0 = phi i32 [ %div, %cont ], [ 0, %entry ], !dbg !18
  ret i32 %retval.0, !dbg !23
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local i32 @max(i32 noundef %x, i32 noundef %y) local_unnamed_addr #0 !dbg !24 {
entry:
  call void @llvm.dbg.value(metadata i32 %x, metadata !26, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.value(metadata i32 %y, metadata !27, metadata !DIExpression()), !dbg !28
  %cmp = icmp ugt i32 %x, %y, !dbg !29
  %x.y = select i1 %cmp, i32 %x, i32 %y, !dbg !28
  ret i32 %x.y, !dbg !31
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local i32 @sum(i32 noundef %x, i32 noundef %y) local_unnamed_addr #0 !dbg !32 {
entry:
  call void @llvm.dbg.value(metadata i32 %x, metadata !34, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.value(metadata i32 %y, metadata !35, metadata !DIExpression()), !dbg !36
  %add = add i32 %y, %x, !dbg !37
  ret i32 %add, !dbg !38
}

; Function Attrs: nofree norecurse nosync nounwind
define dso_local void @sort(i32* nocapture noundef %v) local_unnamed_addr #1 !dbg !39 {
for.end:
  call void @llvm.dbg.value(metadata i32* %v, metadata !44, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i64 0, metadata !45, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i32 0, metadata !47, metadata !DIExpression()), !dbg !55
  call void @llvm.dbg.value(metadata i64 1, metadata !46, metadata !DIExpression()), !dbg !54
  %arrayidx = getelementptr inbounds i32, i32* %v, i64 1, !dbg !56
  %0 = load i32, i32* %arrayidx, align 4, !dbg !56
  %1 = load i32, i32* %v, align 4, !dbg !61
  %cmp6 = icmp ult i32 %0, %1, !dbg !62
  %spec.select = zext i1 %cmp6 to i64, !dbg !63
  call void @llvm.dbg.value(metadata i1 %cmp6, metadata !47, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !55
  call void @llvm.dbg.value(metadata i64 2, metadata !46, metadata !DIExpression()), !dbg !54
  %arrayidx.155 = getelementptr inbounds i32, i32* %v, i64 2, !dbg !56
  %2 = load i32, i32* %arrayidx.155, align 4, !dbg !56
  %idxprom4.156 = zext i1 %cmp6 to i64, !dbg !61
  %arrayidx5.157 = getelementptr inbounds i32, i32* %v, i64 %idxprom4.156, !dbg !61
  %3 = load i32, i32* %arrayidx5.157, align 4, !dbg !61
  %cmp6.158 = icmp ult i32 %2, %3, !dbg !62
  %spec.select.159 = select i1 %cmp6.158, i64 2, i64 %spec.select, !dbg !63
  call void @llvm.dbg.value(metadata i64 3, metadata !46, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i64 %spec.select.159, metadata !47, metadata !DIExpression()), !dbg !55
  %cmp7.not = icmp eq i64 %spec.select.159, 0, !dbg !64
  br i1 %cmp7.not, label %for.end.1, label %if.then8, !dbg !65

if.then8:                                         ; preds = %for.end
  %4 = load i32, i32* %v, align 4, !dbg !66
  call void @llvm.dbg.value(metadata i32 %4, metadata !51, metadata !DIExpression()), !dbg !67
  %arrayidx12 = getelementptr inbounds i32, i32* %v, i64 %spec.select.159, !dbg !68
  %5 = load i32, i32* %arrayidx12, align 4, !dbg !68
  store i32 %5, i32* %v, align 4, !dbg !69
  store i32 %4, i32* %arrayidx12, align 4, !dbg !70
  br label %for.end.1, !dbg !71

for.end.1:                                        ; preds = %if.then8, %for.end
  call void @llvm.dbg.value(metadata i64 1, metadata !45, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i32 1, metadata !47, metadata !DIExpression()), !dbg !55
  call void @llvm.dbg.value(metadata i64 2, metadata !46, metadata !DIExpression()), !dbg !54
  %arrayidx.1 = getelementptr inbounds i32, i32* %v, i64 2, !dbg !56
  %6 = load i32, i32* %arrayidx.1, align 4, !dbg !56
  %arrayidx5.1 = getelementptr inbounds i32, i32* %v, i64 1, !dbg !61
  %7 = load i32, i32* %arrayidx5.1, align 4, !dbg !61
  %cmp6.1 = icmp ult i32 %6, %7, !dbg !62
  call void @llvm.dbg.value(metadata i64 2, metadata !46, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !54
  call void @llvm.dbg.value(metadata i64 undef, metadata !47, metadata !DIExpression()), !dbg !55
  br i1 %cmp6.1, label %if.then8.1, label %if.end17.1, !dbg !65

if.then8.1:                                       ; preds = %for.end.1
  call void @llvm.dbg.value(metadata i64 2, metadata !47, metadata !DIExpression()), !dbg !55
  %arrayidx10.1 = getelementptr inbounds i32, i32* %v, i64 1, !dbg !66
  %8 = load i32, i32* %arrayidx10.1, align 4, !dbg !66
  call void @llvm.dbg.value(metadata i32 %8, metadata !51, metadata !DIExpression()), !dbg !67
  %arrayidx12.1 = getelementptr inbounds i32, i32* %v, i64 2, !dbg !68
  %9 = load i32, i32* %arrayidx12.1, align 4, !dbg !68
  store i32 %9, i32* %arrayidx10.1, align 4, !dbg !69
  store i32 %8, i32* %arrayidx12.1, align 4, !dbg !70
  br label %if.end17.1, !dbg !71

if.end17.1:                                       ; preds = %if.then8.1, %for.end.1
  call void @llvm.dbg.value(metadata i64 2, metadata !45, metadata !DIExpression()), !dbg !54
  ret void, !dbg !72
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtins" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+x87,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512fp16,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtins" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+x87,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512fp16,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "udiv.c", directory: "/home/filippo/serval/rust", checksumkind: CSK_MD5, checksum: "c3c9771a8f27b03c5d34185630f06d11")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!8 = distinct !DISubprogram(name: "udiv", scope: !1, file: !1, line: 3, type: !9, scopeLine: 4, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !14)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11}
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !12, line: 172, baseType: !13)
!12 = !DIFile(filename: "/usr/lib/llvm-14/lib/clang/14.0.0/include/stdint.h", directory: "", checksumkind: CSK_MD5, checksum: "65478c86519fc5f031066ff00d1e57d5")
!13 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!14 = !{!15, !16, !17}
!15 = !DILocalVariable(name: "x", arg: 1, scope: !8, file: !1, line: 3, type: !11)
!16 = !DILocalVariable(name: "y", arg: 2, scope: !8, file: !1, line: 3, type: !11)
!17 = !DILocalVariable(name: "idx", scope: !8, file: !1, line: 8, type: !11)
!18 = !DILocation(line: 0, scope: !8)
!19 = !DILocation(line: 6, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !8, file: !1, line: 6, column: 8)
!21 = !DILocation(line: 6, column: 8, scope: !8)
!22 = !DILocation(line: 8, column: 22, scope: !8)
!23 = !DILocation(line: 11, column: 1, scope: !8)
!24 = distinct !DISubprogram(name: "max", scope: !1, file: !1, line: 14, type: !9, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !25)
!25 = !{!26, !27}
!26 = !DILocalVariable(name: "x", arg: 1, scope: !24, file: !1, line: 14, type: !11)
!27 = !DILocalVariable(name: "y", arg: 2, scope: !24, file: !1, line: 14, type: !11)
!28 = !DILocation(line: 0, scope: !24)
!29 = !DILocation(line: 17, column: 9, scope: !30)
!30 = distinct !DILexicalBlock(scope: !24, file: !1, line: 17, column: 8)
!31 = !DILocation(line: 19, column: 1, scope: !24)
!32 = distinct !DISubprogram(name: "sum", scope: !1, file: !1, line: 23, type: !9, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !33)
!33 = !{!34, !35}
!34 = !DILocalVariable(name: "x", arg: 1, scope: !32, file: !1, line: 23, type: !11)
!35 = !DILocalVariable(name: "y", arg: 2, scope: !32, file: !1, line: 23, type: !11)
!36 = !DILocation(line: 0, scope: !32)
!37 = !DILocation(line: 25, column: 13, scope: !32)
!38 = !DILocation(line: 25, column: 4, scope: !32)
!39 = distinct !DISubprogram(name: "sort", scope: !1, file: !1, line: 30, type: !40, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !43)
!40 = !DISubroutineType(types: !41)
!41 = !{null, !42}
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!43 = !{!44, !45, !46, !47, !51}
!44 = !DILocalVariable(name: "v", arg: 1, scope: !39, file: !1, line: 30, type: !42)
!45 = !DILocalVariable(name: "i", scope: !39, file: !1, line: 32, type: !11)
!46 = !DILocalVariable(name: "j", scope: !39, file: !1, line: 32, type: !11)
!47 = !DILocalVariable(name: "jMin", scope: !48, file: !1, line: 37, type: !11)
!48 = distinct !DILexicalBlock(scope: !49, file: !1, line: 36, column: 2)
!49 = distinct !DILexicalBlock(scope: !50, file: !1, line: 35, column: 2)
!50 = distinct !DILexicalBlock(scope: !39, file: !1, line: 35, column: 2)
!51 = !DILocalVariable(name: "t", scope: !52, file: !1, line: 50, type: !11)
!52 = distinct !DILexicalBlock(scope: !53, file: !1, line: 49, column: 6)
!53 = distinct !DILexicalBlock(scope: !48, file: !1, line: 48, column: 10)
!54 = !DILocation(line: 0, scope: !39)
!55 = !DILocation(line: 0, scope: !48)
!56 = !DILocation(line: 42, column: 7, scope: !57)
!57 = distinct !DILexicalBlock(scope: !58, file: !1, line: 42, column: 7)
!58 = distinct !DILexicalBlock(scope: !59, file: !1, line: 40, column: 6)
!59 = distinct !DILexicalBlock(scope: !60, file: !1, line: 39, column: 6)
!60 = distinct !DILexicalBlock(scope: !48, file: !1, line: 39, column: 6)
!61 = !DILocation(line: 42, column: 14, scope: !57)
!62 = !DILocation(line: 42, column: 12, scope: !57)
!63 = !DILocation(line: 42, column: 7, scope: !58)
!64 = !DILocation(line: 48, column: 15, scope: !53)
!65 = !DILocation(line: 48, column: 10, scope: !48)
!66 = !DILocation(line: 52, column: 11, scope: !52)
!67 = !DILocation(line: 0, scope: !52)
!68 = !DILocation(line: 53, column: 14, scope: !52)
!69 = !DILocation(line: 53, column: 12, scope: !52)
!70 = !DILocation(line: 54, column: 15, scope: !52)
!71 = !DILocation(line: 56, column: 6, scope: !52)
!72 = !DILocation(line: 59, column: 1, scope: !39)
