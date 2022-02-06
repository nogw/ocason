exception SyntaxError of string

val from_string : string -> Ast.json

val from_channel : in_channel -> Ast.json

val pp : Ast.json -> Ppx_deriving_runtime.string