#lang reader serval/riscv/objdump

o.riscv64/udiv.elf:     file format elf64-littleriscv
architecture: riscv:rv64, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x0000000080000000


Disassembly of section .text:
0000000080000000 <udiv> 00058663          	beq	a1,zero,000000008000000c <udiv+0xc>
0000000080000004 <udiv+0x4> 02b5553b          	divuw	a0,a0,a1
0000000080000008 <udiv+0x8> 00008067          	jalr	zero,0(ra)
000000008000000c <udiv+0xc> 00000513          	addi	a0,zero,0
0000000080000010 <udiv+0x10> 00008067          	jalr	zero,0(ra)
0000000080000014 <max> 00050793          	addi	a5,a0,0
0000000080000018 <max+0x4> 00b57463          	bgeu	a0,a1,0000000080000020 <max+0xc>
000000008000001c <max+0x8> 00058793          	addi	a5,a1,0
0000000080000020 <max+0xc> 0007851b          	addiw	a0,a5,0
0000000080000024 <max+0x10> 00008067          	jalr	zero,0(ra)
0000000080000028 <sum> 00b5053b          	addw	a0,a0,a1
000000008000002c <sum+0x4> 00008067          	jalr	zero,0(ra)
0000000080000030 <sort> 00050313          	addi	t1,a0,0
0000000080000034 <sort+0x4> 00000793          	addi	a5,zero,0
0000000080000038 <sort+0x8> 00300e13          	addi	t3,zero,3
000000008000003c <sort+0xc> 00200f13          	addi	t5,zero,2
0000000080000040 <sort+0x10> 00178893          	addi	a7,a5,1
0000000080000044 <sort+0x14> 0007859b          	addiw	a1,a5,0
0000000080000048 <sort+0x18> 00058713          	addi	a4,a1,0
000000008000004c <sort+0x1c> 00088793          	addi	a5,a7,0
0000000080000050 <sort+0x20> 0008881b          	addiw	a6,a7,0
0000000080000054 <sort+0x24> 02071e93          	slli	t4,a4,0x20
0000000080000058 <sort+0x28> 00279613          	slli	a2,a5,0x2
000000008000005c <sort+0x2c> 01eed693          	srli	a3,t4,0x1e
0000000080000060 <sort+0x30> 00c50633          	add	a2,a0,a2
0000000080000064 <sort+0x34> 00d506b3          	add	a3,a0,a3
0000000080000068 <sort+0x38> 00062603          	lw	a2,0(a2)
000000008000006c <sort+0x3c> 0006a683          	lw	a3,0(a3)
0000000080000070 <sort+0x40> 00178793          	addi	a5,a5,1
0000000080000074 <sort+0x44> 00d67463          	bgeu	a2,a3,000000008000007c <sort+0x4c>
0000000080000078 <sort+0x48> 00080713          	addi	a4,a6,0
000000008000007c <sort+0x4c> 0007881b          	addiw	a6,a5,0
0000000080000080 <sort+0x50> fdc81ae3          	bne	a6,t3,0000000080000054 <sort+0x24>
0000000080000084 <sort+0x54> 02b70063          	beq	a4,a1,00000000800000a4 <sort+0x74>
0000000080000088 <sort+0x58> 02071793          	slli	a5,a4,0x20
000000008000008c <sort+0x5c> 01e7d713          	srli	a4,a5,0x1e
0000000080000090 <sort+0x60> 00e50733          	add	a4,a0,a4
0000000080000094 <sort+0x64> 00072683          	lw	a3,0(a4)
0000000080000098 <sort+0x68> 00032783          	lw	a5,0(t1)
000000008000009c <sort+0x6c> 00d32023          	sw	a3,0(t1)
00000000800000a0 <sort+0x70> 00f72023          	sw	a5,0(a4)
00000000800000a4 <sort+0x74> 00430313          	addi	t1,t1,4
00000000800000a8 <sort+0x78> 00100793          	addi	a5,zero,1
00000000800000ac <sort+0x7c> f9e89ae3          	bne	a7,t5,0000000080000040 <sort+0x10>
00000000800000b0 <sort+0x80> 00008067          	jalr	zero,0(ra)
