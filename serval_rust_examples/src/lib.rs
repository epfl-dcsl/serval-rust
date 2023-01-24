#![no_std]
#![no_main]
use macros_lib::verify;
use macros_lib::define;

use core::panic::PanicInfo;



#[verify({
  let a: i32;
  let b: i32;

  //*assume(a<=10000000i32);
  //*assume(b<=10000000i32);

  *assert(test(a, b) == (a+b));
})]
#[no_mangle]
fn test(x: u32, y: u32) -> u32{
  let r: u32 = x + y;
  return r;
}

#[verify({
  "equality";
  let x: i32;
  let y: i32;

  let result = equality(x, y);
  if x == y {
    *assert(result==1u8);
  } else {
    *assert(result==0u8);
  }

})]
#[no_mangle]
fn equality(x: u32, y: u32) -> u8{
  if x==y || (x==0&&y==1)
  {return 1;}
  return 0;
}



#[no_mangle]
fn double_sum(xp: u32, yp: u32) -> u32{
  let mut x: u32 = xp;
  let mut y: u32 = yp;


  if x>=10000000 { x = 0; }
  if y>=10000000 { y = 0; }
  return test(x, x) + test(y, y);
}


#[panic_handler]
fn panic(_info: &PanicInfo)-> ! {
	loop{}
}


#[define({
  "arguments_test";
  args(x, y);

  *print("x = ");
  *println(x);
  
  *print("y = ");
  *println(y);
})]
#[verify({
  "arguments_verify";
  let x: u32;
  let y: u32;

  x = 3u32+x;

  *arguments_test(x, y);
  *println(example(x, y))

})]

#[verify({
  "signed";

  let z = 3u8 - 5u8;

  let t = z<0u8;
  let q = signed(z<0u8);
  *println(t);

})]
#[no_mangle]
fn example(a: u32, b: u32) -> u32 {
  let mut c = a;
  if a%2==0 {
      c = 1;
  }

  if b>10 {
      c = b+1;
  }
  
  return c;
}

/*
fn main() {
    let a: u32 = 10;
    let b: u32 = 5;

    let _c:u32= test(a,b);
}*/

pub mod libarray;
pub mod libmonitor;
