use std::fs;

use json::JsonValue;

mod racket_structure;

fn get_racket_type(rust_type: &str) -> String{
    match rust_type {
        "i32" => return "i32".to_owned(),
        "u32" => return "i32".to_owned(),
        "i64" => return "i64".to_owned(),
        "u64" => return "i64".to_owned(),
        "u8" => return "i8".to_owned(),
        "i8" => return "i8".to_owned(),
        "b" => return "8".to_owned(),
        //"bool" => return "i1".to_owned(),
        _ => return "*** TYPE NOT RECOGNIZED ***".to_owned()
    }
}

fn is_signed(rust_type: &str) -> bool{
    match rust_type {
        "i32" | "i64" => true,
        "u32" | "u64" => false,
        _ => false
    }
}

fn get_bitvector_size(rust_type: &str) -> u64{
    match rust_type {
        "i64" | "u64" => 64,
        "i32" | "u32" => 32,
        _ => 0
    }
}

fn get_literal_initializer(rust_type: &str, value: &str) -> String{
    if rust_type=="l" {
        return format!("{}", value);
    }
    return format!("(bv {} {})", value, get_racket_type(rust_type));
}

fn as_binary_op(op: &str, op1: String, op2: String) -> String{
    return format!("({} {} {})", op,  op1, op2);
}

fn as_unary_op(op: &str, op1: String) -> String{
    return format!("({} {})", op,  op1);
}

fn generate_expression(expr: &JsonValue) -> String{
    match expr["kind"].as_str().unwrap() {
        "binary" => {
            let op1 = generate_expression(&expr["left"]);
            let op2 = generate_expression(&expr["right"]);


            return match expr["op"].as_str().unwrap() {
                "add" => as_binary_op("bvadd", op1, op2),
                "sub" => as_binary_op("bvsub", op1, op2),
                "mul" => as_binary_op("bvmul", op1, op2),
                "signed_div" => as_binary_op("bvsdiv", op1, op2),
                "unsigned_div" => as_binary_op("bvudiv", op1, op2),
                "signed_rem" => as_binary_op("bvsrem", op1, op2),
                "unsigned_rem" => as_binary_op("bvurem", op1, op2),
                "and" => as_binary_op("and", op1, op2),
                "or" => as_binary_op("or", op1, op2),
                "bitxor" => as_binary_op("bvxor", op1, op2),
                "bitand" => as_binary_op("bvand", op1, op2),
                "bitor" => as_binary_op("bvor", op1, op2),
                "shl" => as_binary_op("bvshl", op1, op2),
                "signed_shr" => as_binary_op("bvashr", op1, op2),
                "unsigned_shr" => as_binary_op("bvlshr", op1, op2),
                "equals" => as_binary_op("bveq", op1, op2),
                "not_equals" => as_unary_op("not",as_binary_op("bveq", op1, op2)),
                "signed_lt" => as_binary_op("bvslt", op1, op2),
                "unsigned_lt" => as_binary_op("bvult", op1, op2),
                "signed_le" => as_binary_op("bvsle", op1, op2),
                "unsigned_le" => as_binary_op("bvule", op1, op2),
                "signed_gt" => as_binary_op("bvsgt", op1, op2),
                "unsigned_gt" => as_binary_op("bvugt", op1, op2),
                "signed_ge" => as_binary_op("bvsge", op1, op2),
                "unsigned_ge" => as_binary_op("bvuge", op1, op2),
                _ =>  "*** INVALID BINARY OPERATOR ***".to_owned(),
            }

        },

        "assign" => {
            let op1 = expr["var_name"].as_str().unwrap();
            let op2 = generate_expression(&expr["value"]);


            return format!("(set! {} {})", op1, op2);

        },
        "literal" => {
            match expr["value"]["type"].as_str().unwrap() {
                "string" => return expr["value"]["value"].as_str().unwrap().to_owned(),
                "bool" => if expr["value"]["value"].as_str().unwrap().to_owned() == "true" {"#t".into()} else {"#f".into()},
                _ => return get_literal_initializer(expr["value"]["size"].as_str().unwrap(), expr["value"]["value"].as_str().unwrap())                ,
            }
        },
        "identifier" => {
            return expr["identifier"].as_str().unwrap().to_owned()
        },

        "serval_call" => {
            let mut args = "".to_owned();

            for ele in  expr["args"].members() {
                args.push_str(format!("{} ", generate_expression(ele)).as_str());
            }

            return format!("({} {})", expr["name"].as_str().unwrap(),  args);
        },

        "function_call" => {
            let mut args = "".to_owned();

            for ele in  expr["args"].members() {
                args.push_str(format!("{} ", generate_expression(ele)).as_str());
            }

            return format!("(@{} {})", expr["name"].as_str().unwrap(),  args);
        },



        "memory_access" => {
            let mut identifier = "".to_owned();

            for ele in expr["access"].members(){
                identifier.push_str(format!("{} ",
                    match ele["kind"].as_str().unwrap() {
                        "named" => format!("'{}", ele["name"]),
                        "indexed" => format!("{}", generate_expression(&ele["expr"])),
                        _ => "*** INVALID ACCESS METHOD ***".to_owned(),
                    }
            ).as_str())
            }



            return format!("(mblock-iload (llvm:symbol->block '{}) (list {}))", expr["base"], identifier);
        }

        "cast" => {
            let signed = is_signed(expr["type"].as_str().unwrap());
            let size = get_bitvector_size(expr["type"].as_str().unwrap());

            let body = generate_expression(&expr["expr"]);

            if signed {
                return format!("(sign-extend {} (bitvector {}))", body, size);
            } else {
                return format!("(zero-extend {} (bitvector {}))", body, size);

            }

        }

        "if" => {

            let mut conditions = "".to_owned();

            for ele in expr["conditions"].members() {
                let cond = generate_expression(&ele["condition"]);
                let body = generate_block(&ele["body"]);


                conditions.push_str(format!("[{} {}]\n", cond, body).as_str());
            }


            if expr.has_key("else") {
                let body = generate_block(&expr["else"]["body"]);


                conditions.push_str(format!("[else {}]\n", body).as_str());
            }

            return format!("(cond \n{}\n)", conditions);

        }

        "foreach" => {
            return format!("(for ([{} {}])\n{}\n)", expr["var_name"].as_str().unwrap(), expr["var_max"].as_str().unwrap(), generate_block(&expr["body"]));
        }

        "parentheses" => {
            let body = generate_expression(&expr["expr"]);

            
            return format!("({})", body);
           

        }

        "ignored" => {
            return "".to_owned();
        }
        _ => {return "*** INVALID EXPR KIND ***".to_owned();},
    }
}

fn generate_statement(st: &JsonValue) -> String{
    return match st["kind"].as_str().unwrap() {
        "definition" => {
            if st["symbolic"].as_bool().unwrap()==false {
                format!("(define {} {})", st["name"].as_str().unwrap(), generate_expression(&st["value"]))
            }else{
                format!("(define-symbolic {} {})", st["name"].as_str().unwrap(), get_racket_type(st["type"].as_str().unwrap()))
            }
        },

        "expr" => {
            generate_expression(&st["value"])
        },
        _ => {"*** INVALID STATEMENT KIND ***".to_owned()},
    }
}

fn generate_block(block: &JsonValue) -> String{
    let mut body: String = "".to_owned();
    for ele in block["statements"].members() {
        body.push_str(format!("{}\n", generate_statement(ele)).as_str());
    }

    return body;
}


fn generate_test(info: JsonValue) -> (String, String){
    let name = info["name"].as_str().unwrap();
    println!("Function name: {}", name);

    //let mut params: String = "".to_owned();


    /*for ele in info["parameters"].members() {
        //body.push_str(format!("(define-symbolic {} {})\n", ele["name"].as_str().unwrap(), get_racket_type(ele["type"].as_str().unwrap())).as_str());
        //params.push_str(format!("{} ", ele["name"].as_str().unwrap()).as_str());
    }*/

    let body = generate_block(&info["body"]);


    if info["kind"]=="lemma" {
        let function = racket_structure::RKT_FUNCTION.to_owned().replace("{body}", body.as_str()).replace("{function_name}", name); 

        return (function, racket_structure::RKT_TEST.to_owned().replace("{name}", name).replace("{function_name}", name));
    }else{

        let mut name_args = name.to_owned();

        for ele in info["arguments"].members() {
            name_args.push_str(format!(" {}", ele.as_str().unwrap()).as_str());
        }

        let function = racket_structure::RKT_FUNCTION.to_owned().replace("{body}", body.as_str()).replace("{function_name}", &name_args); 


        return (function, "".to_owned());

    }

}


fn main() {
    println!("Generating files...");

    let paths = fs::read_dir("./target/verify_temp").unwrap();

    let (mut functions, mut tests): (String, String) = ("".to_owned(),"".to_owned());

    for path in paths {
        let p = path.unwrap().path();
        println!("File: {}", p.display());

        let contents = fs::read_to_string(p);

        match contents {
            Ok(c) => {

                let obj = json::parse(&c);

                match obj {
                    Ok(j) => {
                        let (func, test) = generate_test(j);

                        functions.push_str(func.as_str());
                        tests.push_str(test.as_str());
                    },
                    Err(e) => {println!("Cannot parse json: {}", e);},
                }

            },
            Err(e) => {println!("Cannot read file: {}", e);},
        }
    }


    let tests = racket_structure::RKT_TESTS.to_owned().replace("{name}", "rust-generated").replace("{tests}", tests.as_str());

    
    let result = racket_structure::RKT_BASE.to_owned()
        .replace("{header}", racket_structure::RKT_HEADER)
        .replace("{defs}", racket_structure::RKT_DEFS)
        .replace("{functions}", functions.as_str())
        .replace("{tests}", &tests);

    //fs::create_dir_all("verify_racket");
    let output_name = "target/verify_racket/gen.all.rkt";
    match fs::write(&output_name, result) {
        Ok(_) => {println!("Generated file {}", output_name)},
        Err(e) => {println!("Error generating file {}: {}", output_name, e)},
    };
}
