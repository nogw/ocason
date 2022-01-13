open Ast

exception TypeError(string)

let typeof = (js) => {
  switch js {
  | JsonNull      => "null"
  | JsonBool(_)   => "bool"
  | JsonNumber(_) => "number"
  | JsonString(_) => "string"
  | JsonFloat(_)  => "float"
  | JsonArray(_)  => "list"
  | JsonObject(_) => "object"
  }
}

let error_message = (expect, jstype) => {
  TypeError(
    Printf.sprintf(
      "the operation expects an %s type, but received a %s type",
      expect, typeof(jstype)
    )
  )
}

let member = (mem, js) => {
  switch js {
  | JsonObject(obj) => List.assoc(mem, obj)
  | _ => raise(error_message("object", js))
  }
}

let to_string = (js) => {
  switch js {
  | JsonString(s) => s
  | _ => raise(error_message("string", js))
  }
}

let to_bool = (js) => {
  switch js {
  | JsonBool(b) => b
  | _ => raise(error_message("bool", js))
  }
}

let to_int = (js) => {
  switch js {
  | JsonNumber(n) => n
  | _ => raise(error_message("int", js))
  }
}

let to_float = (js) => {
  switch js {
  | JsonFloat(f) => f
  | _ => raise(error_message("float", js))
  }
}

let to_list = (js) => {
  switch js {
  | JsonArray(l) => l
  | _ => raise(error_message("list", js))
  }
}

let to_object = (js) => {
  switch js {
  | JsonObject(o) => o
  | _ => raise(error_message("object", js)) 
  }
}