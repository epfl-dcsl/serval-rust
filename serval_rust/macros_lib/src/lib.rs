#![feature(proc_macro_diagnostic)]

extern crate proc_macro;



use json::JsonValue;
use json::JsonValue::Null;
use proc_macro::TokenStream;
use proc_macro2::Span;
use quote::quote;
use syn::ExprAssign;
use syn::ExprCall;
use syn::ExprForLoop;
use syn::Member;
use syn::UnOp;
use std::env;
use std::fs;
use syn::spanned::Spanned;
use syn::BinOp;
use syn::Path;
use syn::{parse_macro_input, Block, Expr, ExprLit, ItemFn, Lit, Local, Stmt};
use syn::{Pat, Type};

#[proc_macro]
pub fn test_proc_macro(input: TokenStream) -> TokenStream {
    println!("{}", input);

    return input;
}

#[derive(Debug, Copy, Clone)]
struct Context{
    signed: bool
}


fn make_err<T>(span: Span, msg: &str) -> Result<T, String> {
    span.unwrap().error(msg).emit();
    return Err(msg.to_string());
}

fn ignore_call(l: &String) -> bool{
    match l.as_str() {
        "args" | "signed" | "unsigned" => {true}
        _ => {false}
    }
}


fn parse_path(p: &Path) -> String {
    let mut path = "".to_owned();
    let mut i: usize = 0;

    while i < p.segments.len() - 1 {
        path.push_str(p.segments[i].ident.to_string().as_str());
        path.push_str("::");
        i += 1;
    }

    path.push_str(p.segments[i].ident.to_string().as_str());

    return path;
}

fn get_type_info(t: &Type) -> Result<String, String> {
    match t {
        Type::Path(p) => {
            return Ok(parse_path(&p.path));
        }
        _ => {
            return make_err(t.span(), "Type not recognized");
        }
    }
}
/*
fn get_arg_info(arg: &FnArg) -> Result<JsonValue, String> {
    let mut def = json::JsonValue::new_object();

    match arg {
        FnArg::Receiver(_r) => {
            def["name"] = "self".into();
            def["type"] = "".into();
            return Ok(def);
        }
        FnArg::Typed(t) => {
            match &*t.pat {
                Pat::Ident(ref p) => {
                    let name: String = p.ident.to_string();

                    match get_type_info(&*t.ty) {
                        Ok(path) => {
                            def["name"] = name.into();
                            def["type"] = path.into();
                            return Ok(def);
                        }
                        Err(e) => {
                            return make_err(t.ty.span(), format!("Type of {}:", e).as_str());
                        }
                    }
                }
                _ => {
                    return make_err(t.pat.span(), "Parameter pattern not recognized");
                }
            };
        }
    }
}*/

fn write_data(file_name: String, data: String) -> std::io::Result<()> {
    fs::create_dir_all("target/verify_temp")?;
    fs::write(format!("target/verify_temp/{}.json", file_name), data.as_bytes())?;

    return Ok(());
}

fn parse_literal(l: &ExprLit) -> Result<JsonValue, String> {
    let mut def = json::JsonValue::new_object();

    match &l.lit {
        Lit::Int(i) => {
            def["type"] = "int".into();
            def["value"] = i.base10_digits().into();

            if i.suffix().len()==0 {
              return make_err(i.span(), "Numeric literals must have a size suffixed")
            }


            def["size"] = i.suffix().into();
        }
        Lit::Bool(i) => {
            def["type"] = "bool".into();
            def["value"] = (if i.value { "true" } else { "false" }).into();
        }

        Lit::Str(i) =>{
            def["type"] = "string".into();
            def["value"] = i.token().to_string().into();
        }
        _ => {
            return make_err(l.span(), "Literal not parseable");
        }
    }

    return Ok(def);
}

fn parse_loop(l: &ExprForLoop, ctx: Context) -> Result<(String, String, JsonValue), String> {

    let var_name = match &l.pat {
        Pat::Ident(i) => {
            i.ident.to_string()
        },
        _ => {return make_err(l.pat.span(), "Invalid for variable name");}
    };

    let boundary = if let Expr::Range(r) = &*l.expr {
        if let Some(from) = &r.from{
            if let Expr::Lit(lit) = &**from{
                if let Lit::Int(val) = &lit.lit{
                    if val.base10_digits()!="0"{
                        return make_err(val.span(), "Start must be 0")
                    }
                }else{
                    return make_err(lit.span(), "Start must be 0")
                }
            }else{
                return make_err(from.span(), "Start must be 0")  
            }
        }

        if let Some(to) = &r.to{
            if let Expr::Lit(lit) = &**to{
                if let Lit::Int(val) = &lit.lit{
                    val.base10_digits().to_owned()
                }else{
                    return make_err(lit.span(), "Start must be integer")
                }
            }else{
                return make_err(to.span(), "Start must be a literal number")  
            }
        }else{
            return make_err(r.span(), "Range end must be specified")
        }
    } else {return make_err(l.expr.span(), "For loops must have a range speciffied");};



    return Ok((var_name, boundary, parse_body(&l.body, ctx)?));
}

fn parse_call_name(c: &ExprCall) -> Result<String, String>{

    let name = match &*c.func {
        Expr::Path(p) => parse_path(&p.path),
        _ => return make_err(c.func.span(), "Invalid function identifier")
    };
  
    return Ok(name);
  }

fn parse_call(c: &ExprCall, ctx: Context) -> Result<(String, JsonValue), String>{

  let name = match &*c.func {
      Expr::Path(p) => parse_path(&p.path),
      _ => return make_err(c.func.span(), "Invalid function identifier")
  };
  let mut def = json::JsonValue::new_array();

  let mut i = 0;
  for ele in &c.args {

    def[i] = parse_expression(ele, ctx)?.into();
    i+=1;
  }

  return Ok((name, def));
}

fn parse_signed(c: &ExprCall, name: String, ctx: Context) -> Result<JsonValue, String>{

    if c.args.len() != 1 {
        return make_err(c.args.span(), "signed and unsigned functions accept only one argument")
    }

    if name == "signed"{
        return Ok(parse_expression(&c.args[0], Context{signed: true, ..ctx})?);
    }else if name == "unsigned"{
        return Ok(parse_expression(&c.args[0], Context{signed: false, ..ctx})?);
    }else{
        return make_err(c.func.span(),"Function name is neither signed nor unsigned");
    }
     
  }

fn parse_arguments(c: &ExprCall, comp: bool) -> Result<JsonValue, String>{

    let name = match &*c.func {
        Expr::Path(p) => parse_path(&p.path),
        _ => return make_err(c.func.span(), "Invalid function identifier")
    };
    let mut def = json::JsonValue::new_array();

    if name.as_str() != "args" {
        return Ok(def);
    }

    if !comp {
        c.span().unwrap().warning("Arguments are ignored in a verify annotation. They are available only in define annotations.").emit();
    }

  
    let mut i = 0;
    for ele in &c.args {
  
      def[i] = parse_identifier_expr(ele)?.into();
      i+=1;
    }
  
    return Ok(def);
  }



fn parse_memory_access(expr: &Expr, ctx: Context) -> Result<(String, JsonValue), String>{
    let mut def = json::JsonValue::new_object();

    let child = match expr {
        Expr::Field(e) =>{
            let name = match &e.member {
                Member::Named(m) => {
                    m.to_string()
                },
                Member::Unnamed(_) =>
                    return make_err(e.member.span(), "Cannot use unnamed struct members")
            };
            def["kind"] = "named".into();
            def["name"] = name.into();
            &*e.base
        }
        Expr::Index(e) =>{
            def["kind"] = "indexed".into();
            def["expr"]  = parse_expression(&e.index, ctx)?;
            &*e.expr
        }
        _ => return {
            
            make_err(expr.span(), "Not a valid field access pattern")
        }
    };

    match child {
        Expr::Field(_) | Expr::Index(_) => {                    
            let mut child = parse_memory_access(child, ctx)?;
            let _n = child.1.push(def);

            return Ok(child)
        },

        Expr::Path(f) => { 

            let p = parse_path(&f.path);
            let mut r = json::JsonValue::new_array();
            let _r = r.push(def);
            
            return Ok((p, r))
        },

        _ => {
            return make_err(child.span(), "Invalid base for access fieldd operator");
        }
    }
}

fn parse_if_else(expr: &Expr, ctx: Context) -> Result<(JsonValue, JsonValue),String>{
    match expr {
        Expr::If(e) => {
            let mut def = json::JsonValue::new_object();
            def["condition"] = parse_expression(&*e.cond, ctx)?;
            def["body"] = parse_body(&e.then_branch, ctx)?;

            let mut st = json::JsonValue::new_array();
            let _u =st.push(def);

            if e.else_branch.is_some() {
                let r = parse_if_else(&*e.else_branch.as_ref().unwrap().1, ctx)?;

                for ele in r.0.members() {
                    let _u =st.push(ele.to_owned());
                }                

                return Ok((st, r.1))
            }else{
                return Ok((st, json::JsonValue::Null))
            }
        },
        Expr::Block(e) => {
            return Ok((json::JsonValue::new_array(),parse_body(&e.block, ctx)?));
        }
        _ => {
            return make_err(expr.span(), "Invalid type for if expression");
        }
    }
}

fn parse_expression(expr: &Expr, ctx: Context) -> Result<JsonValue, String> {
    let mut def = json::JsonValue::new_object();

    match expr {
        Expr::Binary(e) => {
            def["kind"] = "binary".into();

            match e.op {
                BinOp::Add(_) => {
                    def["op"] = "add".into();
                }
                BinOp::Sub(_) => {
                    def["op"] = "sub".into();
                }
                BinOp::Mul(_) => {
                    def["op"] = "mul".into();
                }
                BinOp::Div(_) => {
                    def["op"] = if ctx.signed {
                        "signed_div".into()
                    }else{
                        "unsigned_div".into()
                    }                    
                }
                BinOp::Rem(_) => {
                    def["op"] = if ctx.signed {
                        "signed_rem".into()
                    }else{
                        "unsigned_rem".into()
                    }                    
                }
                BinOp::And(_) => {
                    def["op"] = "and".into();
                }
                BinOp::Or(_) => {
                    def["op"] = "or".into();
                }
                BinOp::BitXor(_) => {
                    def["op"] = "bitxor".into();
                }
                BinOp::BitAnd(_) => {
                    def["op"] = "bitand".into();
                }
                BinOp::BitOr(_) => {
                    def["op"] = "bitor".into();
                }
                BinOp::Shl(_) => {
                    def["op"] = "shl".into();
                }
                BinOp::Shr(_) => {
                    def["op"] = if ctx.signed {
                        "signed_shr".into()
                    }else{
                        "unsigned_shr".into()
                    }                  }
                BinOp::Eq(_) => {
                    def["op"] = "equals".into();
                }
                BinOp::Ne(_) => {
                    def["op"] = "not_equals".into();
                }
                BinOp::Lt(_) => {
                    def["op"] = if ctx.signed {
                        "signed_lt".into()
                    }else{
                        "unsigned_lt".into()
                    }                    
                }
                BinOp::Le(_) => {
                    def["op"] = if ctx.signed {
                        "signed_le".into()
                    }else{
                        "unsigned_le".into()
                    }                    
                }
                BinOp::Gt(_) => {
                    def["op"] = if ctx.signed {
                        "signed_gt".into()
                    }else{
                        "unsigned_gt".into()
                    }                    
                }
                BinOp::Ge(_) => {
                    def["op"] = if ctx.signed {
                        "signed_ge".into()
                    }else{
                        "unsigned_ge".into()
                    }                    
                }

                _ => return make_err(e.op.span(), "Symbol not allowed here"),
            }

            def["left"] = parse_expression(&*e.left, ctx)?.into();
            def["right"] = parse_expression(&*e.right, ctx)?.into();
        }

        Expr::Unary(u) =>{
          match u.op {
              UnOp::Deref(_) => {
                  match &*u.expr {
                      Expr::Call(c) => {
                        def["kind"] = "serval_call".into();
                        let r = parse_call(c, ctx)?;
                        def["name"] = r.0.into();
                        def["args"] = r.1.into();
                      },
                      _ => {
                        return make_err(u.span(), "*-op can only be used with function calls");
                      }
                  }
              },
              _ => {
                return make_err(u.span(), "Invalid unary operation usage");
              }
          }
        }

        Expr::Call(c)=>{
          let name = parse_call_name(c)?;
          if ignore_call(&name) {
            if name == "signed" || name == "unsigned" {
                def =  parse_signed(c, name, ctx)?;
            }else{            
                def["kind"] = "ignored".into();
            }


          }else{
            let r = parse_call(c, ctx)?;
            def["kind"] = "function_call".into();
            def["name"] = name.into();
            def["args"] = r.1.into();
          }
        }

        Expr::Lit(e) => {
            def["kind"] = "literal".into();
            def["value"] = parse_literal(&e)?.into();
        }

        Expr::Path(e) => {
            def["kind"] = "identifier".into();
            def["identifier"] = parse_path(&e.path).into();
        }

        Expr::If(_) => {
            def["kind"] = "if".into();
            
            let r = parse_if_else(expr, ctx)?;

            def["conditions"] = r.0.into();

            if r.1 != Null{
                def["else"]["body"] = r.1;
            }
        }

        Expr::Cast(e) => {
            def["kind"] = "cast".into();            
            def["expr"] = parse_expression(&e.expr, ctx)?.into();
            def["type"] = get_type_info(&*e.ty)?.into();
        }

        Expr::Paren(e) => {
            def["kind"] = "parentheses".into();           
            def["expr"] = parse_expression(&e.expr, ctx)?.into();
        }

        Expr::Field(_) | Expr::Index(_) =>{
            def["kind"] = "memory_access".into();
            let r = parse_memory_access(expr, ctx)?;
            def["base"] = r.0.into();
            def["access"] = r.1.into();
        }

        Expr::ForLoop(l) =>{
            def["kind"] = "foreach".into();
            let (var, boundary, body) = parse_loop(l, ctx)?;
            def["var_name"] = var.into();
            def["var_max"] = boundary.into();
            def["body"] = body.into();

        }

        Expr::Assign(l) =>{
            def["kind"] = "assign".into();
            let (l, r) = parse_assignment(l, ctx)?;
            def["var_name"] = l.into();
            def["value"] = r.into();

        }

        _ => {
            println!("not parseable: {:?}", expr);
            return make_err(expr.span(), "Part of expression not parseable");
        }
    }

    return Ok(def);
}

fn parse_identifier_expr(expr: &Expr) -> Result<String, String> {

    match expr {
        Expr::Path(e) => {
             Ok(parse_path(&e.path))
        }   

        _ => {
            return make_err(expr.span(), "Must be an identifier");
        }
    }

}

fn parse_local_binding(ref local: &Local, ctx: Context) -> Result<JsonValue, String> {
    let mut def = json::JsonValue::new_object();

    def["kind"] = "definition".into();

    match &local.pat {
        Pat::Type(ref p) => {
            match &*p.pat {
                Pat::Ident(name) => {
                    def["name"] = name.ident.to_string().into();
                }
                _ => {
                    return make_err(p.pat.span(), "Variable definition pattern not recognized");
                }
            }

            def["type"] = get_type_info(&*p.ty)?.into();
        }
        Pat::Ident(name) => {
            def["name"] = name.ident.to_string().into();
        }
        _ => {
            return make_err(local.pat.span(), "Variable definition pattern not recognized");
        }
    }

    match local.init {
        Some(ref v) => {
            def["value"] = parse_expression(&v.1, ctx)?.into();
            def["symbolic"] = false.into();
        }
        None => {
            if def["type"].is_empty() {
                return make_err(local.pat.span(), "Symbolic variables must be typed")
            }
            def["symbolic"] = true.into();
        }
    }

    return Ok(def);
}

fn parse_assignment(ref local: &ExprAssign, ctx: Context) -> Result<(String, JsonValue), String> {

    let var_name = match &*local.left {
        Expr::Path(p) => {
            parse_path(&p.path)
        },

        e => {return make_err(e.span(), "Assignment left part must be a variable name!")}
    };

    let expr = parse_expression(&local.right, ctx)?;

    return Ok((var_name, expr));
}

fn parse_body(body: &Block, ctx: Context) -> Result<JsonValue, String> {

    let mut lemma = json::JsonValue::new_object();

    let mut i: usize = 0;

    for ele in &body.stmts {
        match ele {
            Stmt::Local(local) => {
                lemma["statements"][i] = parse_local_binding(local, ctx)?;
                i += 1;
            }
            Stmt::Item(_) => {
            }
            Stmt::Expr(e) | Stmt::Semi(e, _) => {

                match e {
                    Expr::Lit(v) => {
                        match &v.lit {
                            Lit::Str(v) => {
                                println!("String: {}", v.value());
                            }
                            _ => {}
                        };
                    }

                    _ => {
                      lemma["statements"][i]["kind"] = "expr".into();
                      lemma["statements"][i]["value"] = parse_expression(&e, ctx)?.into();
                      //return make_err(e.span(), "Statement structure not parseable");
                      i += 1;

                    }
                }
            }
        }
    }

    return Ok(lemma);
}

fn get_lemma_args(expr: &Expr, comp: bool) -> Result<JsonValue,String> {

    match expr {
        Expr::Call(c)=>{
            let r = parse_arguments(&c, comp)?;
            Ok(r)
          }

          _ => Ok(json::JsonValue::new_array())
    }

}

fn get_lemma_name(default_name: String, body: &Block, name_compulsory: bool) -> Result<(String, JsonValue), String> {
    let mut args = json::JsonValue::new_array();
    if body.stmts.len()>0 {
        match &body.stmts[0] {
            Stmt::Expr(e) | Stmt::Semi(e, _) => {

                match e {
                    Expr::Lit(v) => {
                        match &v.lit {
                            Lit::Str(v) => {
                                let name = v.value();
                                
                                if body.stmts.len()>1 {
                                    let args = match &body.stmts[1] {
                                        Stmt::Expr(e) | Stmt::Semi(e, _) => {
                                            get_lemma_args(e, name_compulsory)?
                                        }

                                        _ => {
                                            json::JsonValue::new_array()
                                        }
                                    };

                                    return Ok((name, args));
                                }
                            }
                            _ => {}
                        };
                    }

                    other => {
                        args = get_lemma_args(other, name_compulsory)?;
                    }
                }
            }
            
            _ => {}
        }
    }


    if name_compulsory{
        return make_err(body.span(),"This lemma must have a name specified");
    }

    return Ok((default_name, args));
}

fn remove_whitespace(s: &mut String) {
    s.retain(|c| !c.is_whitespace());
}

fn parse_annotation(attr: TokenStream, item: TokenStream, kind: &str, name_compulsory: bool) -> TokenStream{
    if !env::var("GENERATE_VERIFIABLE").is_ok() {
        return item;
    }

    let mut data = json::JsonValue::new_object();

    let input = parse_macro_input!(item as ItemFn);
    let parsed = parse_macro_input!(attr as Block);

    let ItemFn {
        attrs,
        vis,
        sig,
        block,
    } = input;
    let stmts = &block.stmts;

    //println!("Function Name: ");
    //println!("{}", sig.ident);
    let names_result = get_lemma_name(sig.ident.to_string().into(),&parsed, name_compulsory);

    if names_result.is_ok() {
        let (mut lemma_name, args) = names_result.unwrap();

        remove_whitespace(&mut lemma_name);

        data["name"] = lemma_name.clone().into();
        data["arguments"] = args.into();
        data["kind"] = kind.into();

        //println!("");

        /*println!("Parameters: ");
        for (i, ele) in (&sig.inputs).iter().enumerate() {
            match get_arg_info(ele) {
                Ok(t) => {
                    data["parameters"][i] = t.into();
                }
                Err(e) => {
                    println!("Parameter not parsable: {}", e);
                }
            }
        }
        println!("");

        println!("Output: ");*/

        /*match sig.output {
            ReturnType::Default => {
                data["return_type"] = "()".into();
                println!("()");
            }
            ReturnType::Type(_arrow, ref typ) => match get_type_info(&typ) {
                Ok(path) => {
                    println!("{}", path);
                    data["return_type"] = path.into();
                }
                Err(e) => {
                    data["return_type"] = format!("!INVALID: {}", e).into();

                    println!("Return type not parsed: {}", e)
                }
            },
        }*/

        data["body"] = match parse_body(&parsed, Context{signed: false}) {
            Ok(b) => b,
            Err(_e) => json::JsonValue::new_object(),
        }
        .into();

        match write_data(lemma_name.to_string(), data.pretty(2)) {
            Ok(_) => {}
            Err(e) => {
                println!("Error writing to file: {}", e)
            }
        }
    }else{
        //parsed.span().unwrap().error(names_result.err().unwrap()).emit();
    }

    return TokenStream::from(quote! {
        #(#attrs)* #vis #sig {
            #(#stmts)*
        }
    });
}


#[proc_macro_attribute]
pub fn verify(attr: TokenStream, item: TokenStream) -> TokenStream {
    parse_annotation(attr, item,"lemma", false)
}

#[proc_macro_attribute]
pub fn define(attr: TokenStream, item: TokenStream) -> TokenStream {
    parse_annotation(attr, item,"define", true)
}




