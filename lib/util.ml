open Ast

exception TypeError of string

let typeof = 
  function
  | JsonNull      -> "null"
  | JsonBool(_)   -> "bool"
  | JsonNumber(_) -> "number"
  | JsonString(_) -> "string"
  | JsonFloat(_)  -> "float"
  | JsonArray(_)  -> "list"
  | JsonObject(_) -> "object"

let error_message expect typ = 
  TypeError(
    Printf.sprintf
      "the operation expects an %s type, but received a %s type" expect (typeof typ))

let to_string = 
  function
  | JsonString(s) -> s
  | js -> raise (error_message "string" js)

let to_bool = 
  function
  | JsonBool(b) -> b
  | js -> raise (error_message "bool" js)

let to_int = 
  function
  | JsonNumber(n) -> n
  | js -> raise (error_message "int" js)

let to_float = 
  function
  | JsonFloat(f) -> f
  | js -> raise (error_message "float" js)

let to_list = 
  function
  | JsonArray l -> l
  | js -> raise (error_message "list" js)

let to_object = 
  function
  | JsonObject o -> o
  | js -> raise (error_message "object" js)

let key mem js =
  match js with
  | ((JsonObject obj)) ->
      (try List.assoc mem obj with | Not_found  -> JsonNull)
  | _ -> raise (error_message "object" js)

let keys = 
  function
  | JsonObject obj -> List.map (fun (k,_)  -> k) obj
  | js -> raise (error_message "object" js)