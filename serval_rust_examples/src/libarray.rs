use macros_lib::verify;

#[no_mangle]
static array_to_sum: [u32; 5] = [1,2,3,4,5];

#[no_mangle]
static mut array_to_sum_2: [u32; 5] = [9,8,7,6,5];


#[no_mangle]
unsafe fn init_array() -> () {

    array_to_sum_2[0] = 1;
    array_to_sum_2[1] = 2;
    array_to_sum_2[2] = 3;
    array_to_sum_2[3] = 4;
    array_to_sum_2[4] = 5;

}


#[verify({

    /*let i: u64;
    init_array();
    let x = array_to_sum_2[0u64]+array_to_sum_2[1u64]+array_to_sum_2[2u64]+array_to_sum_2[3u64]+array_to_sum_2[4u64];
    *println(x as u64);
    *println(sum_array());
    *assert((sum_array())==(x as u64));*/

    for i in 0..4 {
        *println(array_to_sum_2[*bv(i, 64l)]);
    }

})]

#[verify({
    "lemma 1";
    let new_container_id: u32;

    if init_container(new_container_id) == 0u8 {
        let result = false;
        for c in 0..32 {
            result = result || containers[*bv(c, 64l)].id;            
        }
    }
})]
#[no_mangle]
unsafe fn sum_array() -> u64{
    let mut result: u64 = 0;

    let mut i: usize = 0;

    while i<5 {
    // "range" for generates "complex" statements that are not supported by Serval LLVM parser
    //for i in 0..5 {

        result += array_to_sum_2[i] as u64;
        i = i +1;
    }
    return result;
}








/*
struct Reference {
    id: u32,
    valid: bool
}

struct TestStruct {
    id: i32,
    count: u32,
    reference: Reference
}

#[no_mangle]
fn struct_test(param: &TestStruct) -> i32{
    if param.id<0 || !param.reference.valid {
        return 0;
    }

    return param.id;
}*/