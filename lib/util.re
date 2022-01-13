open Ast

exception TypeError(string)

let typeof = {
  fun
  | JsonNull      => "null"
  | JsonBool(_)   => "bool"
  | JsonNumber(_) => "number"
  | JsonString(_) => "string"
  | JsonFloat(_)  => "float"
  | JsonArray(_)  => "list"
  | JsonObject(_) => "object"
}

let error_message = (expect, typ) => {
  TypeError(
    Printf.sprintf(
      "the operation expects an %s type, but received a %s type",
      expect, typeof(typ)
    )
  )
}

let to_string = {
  fun
  | JsonString(s) => s
  | js => raise(error_message("string", js))
}

let to_bool = {
  fun
  | JsonBool(b) => b
  | js => raise(error_message("bool", js))
}

let to_int = {
  fun
  | JsonNumber(n) => n
  | js => raise(error_message("int", js))
}

let to_float = {
  fun
  | JsonFloat(f) => f
  | js => raise(error_message("float", js))
}

let to_list = {
  fun
  | JsonArray(l) => l
  | js => raise(error_message("list", js))
}

let to_object = {
  fun
  | JsonObject(o) => o
  | js => raise(error_message("object", js))
}

let key = (mem, js) => {
  switch js {
  | JsonObject(obj) => try(List.assoc(mem, obj)) { | Not_found => JsonNull }
  | _ => raise(error_message("object", js))
  }
}

let keys = {
  fun
  | JsonObject(obj) => List.map((((k, _)) => k), obj)
  | js => raise(error_message("object", js))
}