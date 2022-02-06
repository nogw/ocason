exception InvalidJson of string

val to_string : ?std: bool -> Ast.json -> string

val to_channel : ?std: bool -> out_channel -> Ast.json -> unit