exception TypeErrorstring

val typeof : Ast.json -> string

val to_string : Ast.json -> string

val to_bool : Ast.json -> bool

val to_int : Ast.json -> int

val to_float : Ast.json -> float

val to_list : Ast.json -> Ast.json list

val to_object : Ast.json -> string -> Ast.json list

val key : string -> Ast.json -> Ast.json

val keys : Ast.json -> string list