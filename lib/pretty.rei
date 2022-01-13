exception InvalidJson(string)

let to_string : (~std: bool=?, Ast.json) => string

let to_channel : (~std: bool=?, out_channel, Ast.json) => unit