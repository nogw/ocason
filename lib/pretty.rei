exception InvalidJson(string)

type t

let to_string : (~std: bool=?, t) => string

let to_channel : (~std: bool=?, out_channel, t) => unit