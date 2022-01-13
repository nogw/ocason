exception SyntaxError(string)

type t

let parse_from_string : string => t

let parse_from_channel : in_channel => t