exception TypeError(string)

let typeof : Ast.json => string

let to_string : Ast.json => string

let to_bool : Ast.json => bool

let to_int : Ast.json => int

let to_float : Ast.json => float

let to_list : Ast.json => list(Ast.json)

let to_object : Ast.json => list((string, Ast.json))

let key : (string, Ast.json) => Ast.json

let keys : Ast.json => list(string)