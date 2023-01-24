use macros_lib::verify;



struct Region {
    container_id: u32,
    valid: bool,
}

struct Container {
    id: u32,
    region_count: u32,
}

impl Copy for Region {}

impl Clone for Region {
    fn clone(&self) -> Region {
        Region{container_id: self.container_id, valid: self.valid}
    }
}

impl Copy for Container {}

impl Clone for Container {
    fn clone(&self) -> Container {
        Container{id: self.id, region_count: self.region_count}
    }
}


#[no_mangle]
static mut regions: [Region; 32] = [Region{container_id:3, valid:false};32];


#[no_mangle]
static mut containers: [Container; 32] = [Container{id:0, region_count:0};32];


#[no_mangle]
unsafe fn init_memory() -> (){
        let mut i:usize = 0;

        while i < 16 {
            containers[i].id = 0;
            containers[i].region_count = 0;
            i = i+1;
        }

        i = 0;

        while i < 16 {
            regions[i].container_id = 0;
            regions[i].valid = false;
            i = i+1;
        }

    }

#[no_mangle]
unsafe fn init_container(container_id: u32) -> bool{

    let mut i:usize = 0;

    if container_exists(container_id) {
        return false;
    }

    while i < 4 {
        if containers[i].id == 0{
            containers[i].id = container_id;
            containers[i].region_count = 0;
            return true;
        }
        i = i+1;
    }

    return false;
}

#[verify({
    init_memory();
    init_container(3u32);

    let x: u32;

    *println(container_exists(x));
})]
#[no_mangle]
unsafe fn container_exists(container_id: u32) -> bool{
    return container_position(container_id)!=usize::MAX;
}

#[no_mangle]
unsafe fn container_position(container_id: u32) -> usize{

    let mut i:usize = 0;

    if container_id<=0 {
        return usize::MAX;
    }

    while i < 4 {

        if containers[i].id == container_id && containers[i].id != 0{
            return i;
        }
        i = i+1;
    }

    return usize::MAX;
}


#[no_mangle]
unsafe fn add_region(container_id: u32) -> u32{


    if !container_exists(container_id) {
        return u32::MAX;
    }

    let mut i:usize = 0;
    
    while i < 4 {
        if regions[i].valid == false{
            regions[i].container_id = container_id;
            regions[i].valid = true;
            containers[container_position(container_id)].region_count += 1;

            return i as u32;
        }
        i = i+1;
    }

    return u32::MAX;
}

/*
#[define({
    let z = 3u8 - 5u8;
    let u = z < 0u8;
    let s = signed(z < 0u8);
    })]
  */  