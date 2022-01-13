exception TypeError(string)

type t

let typeof : t => string

let to_string : t => string

let to_bool : t => bool

let to_int : t => int

let to_float : t => float

let to_list : t => list(t)

let to_object : t => list((string, t))

let key : (string, t) => t

let keys : t => list(string)