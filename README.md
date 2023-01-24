This repository contains the artifact for my Master Semester Project (Autumn 2022) at Data Center Systems Lab, EPFL.

The scope is to explore ways to integrate [Serval](https://github.com/uw-unsat/serval), a formal verification framework tailored for system code, with Rust, and to be able to express properties directly in this programming language.


### Overview
- ``serval`` directory contains the original Serval code, modified in some parts to allow compatibility with Rust lemmas.
- ``serval_rust`` directory contains the code used for parsing and translation from Rust to Racket.
- ``serval_rust_examples`` directory contains a sample project and some simple properties expressed in Rust.

### Prerequisites
- The tested environment is Ubuntu 22.04 LTS.
- [Racket](https://download.racket-lang.org/). Version 8.6 should work, other versions are untested. 
- A working RISC-V gcc/GNU toolchain for Rust: [Cross-compilation](https://danielmangum.com/posts/risc-v-bytes-rust-cross-compilation/) and [GNU toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain/).
- [Serval](https://github.com/uw-unsat/serval) has to be compiled and installed, but you should use the code provided in the ``serval`` directory of this repository. 


### Usage

- Before any further step, you may need to change the variables defined in it with the correct ones for your environment. Also ``serval_rust/.cargo/config.toml`` and ``serval_rust_examples/.cargo/config.toml`` may contain some paths that must be updated, depending on how the RISC-V toolchain has been installed.
- ``serval_rust_examples/generate_verifiable.sh`` is used to compile Rust macros to a Racket file. The result is written to ``serval_rust/rust`` directory. The first run may take some minutes if Serval libraries have to be compiled.
- To prove the compiled lemmas, is necessary to run the ``make`` command from ``serval_rust/rust`` directory.

