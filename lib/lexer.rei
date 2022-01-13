exception SyntaxError(string)

let from_string : string => Ast.json

let from_channel : in_channel => Ast.json