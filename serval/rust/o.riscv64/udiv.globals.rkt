#lang reader serval/lang/dwarf

o.riscv64/udiv.elf:     file format elf64-littleriscv

Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x1a2 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><c>: Abbrev Number: 6 (DW_TAG_compile_unit)
    <d>   DW_AT_producer    : (indirect string, offset: 0x0): GNU C17 11.2.0 -mstrict-align -mno-relax -mcmodel=medany -mabi=lp64 -march=rv64imafd -g -O2 -ffreestanding -fno-stack-protector -fno-strict-aliasing -fno-jump-tables -ffunction-sections -fdata-sections -fno-PIE
    <11>   DW_AT_language    : 29	(C11)
    <12>   DW_AT_name        : (indirect line string, offset: 0x1a): udiv.c
    <16>   DW_AT_comp_dir    : (indirect line string, offset: 0x0): /home/filippo/serval/rust
    <1a>   DW_AT_ranges      : 0x40
    <1e>   DW_AT_low_pc      : 0x0
    <26>   DW_AT_stmt_list   : 0x0
 <1><2a>: Abbrev Number: 1 (DW_TAG_base_type)
    <2b>   DW_AT_byte_size   : 4
    <2c>   DW_AT_encoding    : 7	(unsigned)
    <2d>   DW_AT_name        : (indirect string, offset: 0xf0): unsigned int
 <1><31>: Abbrev Number: 1 (DW_TAG_base_type)
    <32>   DW_AT_byte_size   : 1
    <33>   DW_AT_encoding    : 6	(signed char)
    <34>   DW_AT_name        : (indirect string, offset: 0xdf): signed char
 <1><38>: Abbrev Number: 1 (DW_TAG_base_type)
    <39>   DW_AT_byte_size   : 2
    <3a>   DW_AT_encoding    : 5	(signed)
    <3b>   DW_AT_name        : (indirect string, offset: 0x110): short int
 <1><3f>: Abbrev Number: 7 (DW_TAG_base_type)
    <40>   DW_AT_byte_size   : 4
    <41>   DW_AT_encoding    : 5	(signed)
    <42>   DW_AT_name        : int
 <1><46>: Abbrev Number: 1 (DW_TAG_base_type)
    <47>   DW_AT_byte_size   : 8
    <48>   DW_AT_encoding    : 5	(signed)
    <49>   DW_AT_name        : (indirect string, offset: 0x123): long int
 <1><4d>: Abbrev Number: 1 (DW_TAG_base_type)
    <4e>   DW_AT_byte_size   : 1
    <4f>   DW_AT_encoding    : 8	(unsigned char)
    <50>   DW_AT_name        : (indirect string, offset: 0xdd): unsigned char
 <1><54>: Abbrev Number: 1 (DW_TAG_base_type)
    <55>   DW_AT_byte_size   : 2
    <56>   DW_AT_encoding    : 7	(unsigned)
    <57>   DW_AT_name        : (indirect string, offset: 0xfd): short unsigned int
 <1><5b>: Abbrev Number: 8 (DW_TAG_typedef)
    <5c>   DW_AT_name        : (indirect string, offset: 0x11a): uint32_t
    <60>   DW_AT_decl_file   : 2
    <61>   DW_AT_decl_line   : 52
    <62>   DW_AT_decl_column : 25
    <63>   DW_AT_type        : <0x2a>
 <1><67>: Abbrev Number: 1 (DW_TAG_base_type)
    <68>   DW_AT_byte_size   : 8
    <69>   DW_AT_encoding    : 7	(unsigned)
    <6a>   DW_AT_name        : (indirect string, offset: 0xeb): long unsigned int
 <1><6e>: Abbrev Number: 9 (DW_TAG_subprogram)
    <6f>   DW_AT_external    : 1
    <6f>   DW_AT_name        : (indirect string, offset: 0xd8): sort
    <73>   DW_AT_decl_file   : 1
    <74>   DW_AT_decl_line   : 30
    <75>   DW_AT_decl_column : 6
    <76>   DW_AT_prototyped  : 1
    <76>   DW_AT_low_pc      : 0x80000030
    <7e>   DW_AT_high_pc     : 0x84
    <86>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <88>   DW_AT_call_all_calls: 1
    <88>   DW_AT_sibling     : <0xe7>
 <2><8c>: Abbrev Number: 2 (DW_TAG_formal_parameter)
    <8d>   DW_AT_name        : v
    <8f>   DW_AT_decl_file   : 1
    <8f>   DW_AT_decl_line   : 30
    <90>   DW_AT_decl_column : 20
    <91>   DW_AT_type        : <0xe7>
    <95>   DW_AT_location    : 1 byte block: 5a 	(DW_OP_reg10 (a0))
 <2><97>: Abbrev Number: 3 (DW_TAG_variable)
    <98>   DW_AT_name        : i
    <9a>   DW_AT_decl_file   : 1
    <9a>   DW_AT_decl_line   : 32
    <9b>   DW_AT_decl_column : 11
    <9c>   DW_AT_type        : <0x5b>
    <a0>   DW_AT_location    : 0xc (location list)
 <2><a4>: Abbrev Number: 3 (DW_TAG_variable)
    <a5>   DW_AT_name        : j
    <a7>   DW_AT_decl_file   : 1
    <a7>   DW_AT_decl_line   : 32
    <a8>   DW_AT_decl_column : 13
    <a9>   DW_AT_type        : <0x5b>
    <ad>   DW_AT_location    : 0x49 (location list)
 <2><b1>: Abbrev Number: 10 (DW_TAG_lexical_block)
    <b2>   DW_AT_ranges      : 0xc
 <3><b6>: Abbrev Number: 11 (DW_TAG_variable)
    <b7>   DW_AT_name        : (indirect string, offset: 0x12c): jMin
    <bb>   DW_AT_decl_file   : 1
    <bc>   DW_AT_decl_line   : 37
    <bd>   DW_AT_decl_column : 15
    <be>   DW_AT_type        : <0x5b>
    <c2>   DW_AT_location    : 0x87 (location list)
 <3><c6>: Abbrev Number: 12 (DW_TAG_lexical_block)
    <c7>   DW_AT_low_pc      : 0x80000088
    <cf>   DW_AT_high_pc     : 0x1c
 <4><d7>: Abbrev Number: 3 (DW_TAG_variable)
    <d8>   DW_AT_name        : t
    <da>   DW_AT_decl_file   : 1
    <da>   DW_AT_decl_line   : 50
    <db>   DW_AT_decl_column : 16
    <dc>   DW_AT_type        : <0x5b>
    <e0>   DW_AT_location    : 0xae (location list)
 <4><e4>: Abbrev Number: 0
 <3><e5>: Abbrev Number: 0
 <2><e6>: Abbrev Number: 0
 <1><e7>: Abbrev Number: 13 (DW_TAG_pointer_type)
    <e8>   DW_AT_byte_size   : 8
    <e9>   DW_AT_type        : <0x5b>
 <1><ed>: Abbrev Number: 5 (DW_TAG_subprogram)
    <ee>   DW_AT_external    : 1
    <ee>   DW_AT_name        : sum
    <f2>   DW_AT_decl_file   : 1
    <f2>   DW_AT_decl_line   : 23
    <f3>   DW_AT_decl_column : 10
    <f3>   DW_AT_prototyped  : 1
    <f3>   DW_AT_type        : <0x5b>
    <f7>   DW_AT_low_pc      : 0x80000028
    <ff>   DW_AT_high_pc     : 0x8
    <107>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <109>   DW_AT_call_all_calls: 1
    <109>   DW_AT_sibling     : <0x126>
 <2><10d>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <10e>   DW_AT_name        : x
    <110>   DW_AT_decl_file   : 1
    <110>   DW_AT_decl_line   : 23
    <111>   DW_AT_decl_column : 23
    <112>   DW_AT_type        : <0x5b>
    <116>   DW_AT_location    : 0xd6 (location list)
 <2><11a>: Abbrev Number: 2 (DW_TAG_formal_parameter)
    <11b>   DW_AT_name        : y
    <11d>   DW_AT_decl_file   : 1
    <11d>   DW_AT_decl_line   : 23
    <11e>   DW_AT_decl_column : 35
    <11f>   DW_AT_type        : <0x5b>
    <123>   DW_AT_location    : 1 byte block: 5b 	(DW_OP_reg11 (a1))
 <2><125>: Abbrev Number: 0
 <1><126>: Abbrev Number: 5 (DW_TAG_subprogram)
    <127>   DW_AT_external    : 1
    <127>   DW_AT_name        : max
    <12b>   DW_AT_decl_file   : 1
    <12b>   DW_AT_decl_line   : 14
    <12c>   DW_AT_decl_column : 10
    <12c>   DW_AT_prototyped  : 1
    <12c>   DW_AT_type        : <0x5b>
    <130>   DW_AT_low_pc      : 0x80000014
    <138>   DW_AT_high_pc     : 0x14
    <140>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <142>   DW_AT_call_all_calls: 1
    <142>   DW_AT_sibling     : <0x15f>
 <2><146>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <147>   DW_AT_name        : x
    <149>   DW_AT_decl_file   : 1
    <149>   DW_AT_decl_line   : 14
    <14a>   DW_AT_decl_column : 23
    <14b>   DW_AT_type        : <0x5b>
    <14f>   DW_AT_location    : 0x100 (location list)
 <2><153>: Abbrev Number: 2 (DW_TAG_formal_parameter)
    <154>   DW_AT_name        : y
    <156>   DW_AT_decl_file   : 1
    <156>   DW_AT_decl_line   : 14
    <157>   DW_AT_decl_column : 35
    <158>   DW_AT_type        : <0x5b>
    <15c>   DW_AT_location    : 1 byte block: 5b 	(DW_OP_reg11 (a1))
 <2><15e>: Abbrev Number: 0
 <1><15f>: Abbrev Number: 14 (DW_TAG_subprogram)
    <160>   DW_AT_external    : 1
    <160>   DW_AT_name        : (indirect string, offset: 0xd3): udiv
    <164>   DW_AT_decl_file   : 1
    <165>   DW_AT_decl_line   : 3
    <166>   DW_AT_decl_column : 10
    <167>   DW_AT_prototyped  : 1
    <167>   DW_AT_type        : <0x5b>
    <16b>   DW_AT_low_pc      : 0x80000000
    <173>   DW_AT_high_pc     : 0x14
    <17b>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <17d>   DW_AT_call_all_calls: 1
 <2><17d>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <17e>   DW_AT_name        : x
    <180>   DW_AT_decl_file   : 1
    <180>   DW_AT_decl_line   : 3
    <181>   DW_AT_decl_column : 24
    <182>   DW_AT_type        : <0x5b>
    <186>   DW_AT_location    : 0x12a (location list)
 <2><18a>: Abbrev Number: 2 (DW_TAG_formal_parameter)
    <18b>   DW_AT_name        : y
    <18d>   DW_AT_decl_file   : 1
    <18d>   DW_AT_decl_line   : 3
    <18e>   DW_AT_decl_column : 36
    <18f>   DW_AT_type        : <0x5b>
    <193>   DW_AT_location    : 1 byte block: 5b 	(DW_OP_reg11 (a1))
 <2><195>: Abbrev Number: 3 (DW_TAG_variable)
    <196>   DW_AT_name        : idx
    <19a>   DW_AT_decl_file   : 1
    <19a>   DW_AT_decl_line   : 8
    <19b>   DW_AT_decl_column : 14
    <19c>   DW_AT_type        : <0x5b>
    <1a0>   DW_AT_location    : 0x17d (location list)
 <2><1a4>: Abbrev Number: 0
 <1><1a5>: Abbrev Number: 0

