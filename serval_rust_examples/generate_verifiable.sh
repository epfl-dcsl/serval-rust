BASE_PATH=/home/filippo/serval/rust/gen
VER_PATH=/home/filippo/serval/rust
LIB_NAME=serval_rust_examples

mkdir target/verify_temp  2> /dev/null
mkdir target/verify_racket  2> /dev/null

rm target/verify_temp/*  2> /dev/null
rm target/verify_racket/*  2> /dev/null

( cd ../serval_rust ; cargo +nightly build -p verify_expand --target x86_64-unknown-linux-gnu; cd -; cp ../serval_rust/target/x86_64-unknown-linux-gnu/debug/verify_expand verify_expand )

cargo +nightly rustc --release -- --emit=llvm-ir -C panic=abort -Cllvm-args="--opaque-pointers=0"
racket /home/filippo/serval/serval/bin/serval-llvm.rkt -- target/riscv64gc-unknown-linux-gnu/release/deps/$LIB_NAME.ll > $BASE_PATH/sumrust.code.rkt


GENERATE_VERIFIABLE=true cargo +nightly rustc --release -- -C panic=abort
riscv64-linux-gnu-nm --print-size --numeric-sort "target/riscv64gc-unknown-linux-gnu/release/lib$LIB_NAME.so" > $BASE_PATH/sumrust.map.tmp
echo "#lang reader serval/lang/nm" > $BASE_PATH/sumrust.map.rkt && cat $BASE_PATH/sumrust.map.tmp >> $BASE_PATH/sumrust.map.rkt
rm $BASE_PATH/sumrust.map.tmp

echo "#lang reader serval/lang/dwarf" > $BASE_PATH/sumrust.globals.rkt
riscv64-linux-gnu-objdump --dwarf=info "target/riscv64gc-unknown-linux-gnu/release/lib$LIB_NAME.so" >> $BASE_PATH/sumrust.globals.rkt



#cargo +nightly run -p verify_expand --target x86_64-unknown-linux-gnu
./verify_expand

rm ./verify_expand  2> /dev/null

mkdir -p $VER_PATH  2> /dev/null
rm $VER_PATH/gen.*.rkt  2> /dev/null
cp target/verify_racket/* $VER_PATH  2> /dev/null
