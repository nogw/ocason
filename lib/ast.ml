type json = 
  | JsonNull
  | JsonBool   of bool 
  | JsonNumber of int 
  | JsonFloat  of float 
  | JsonString of string 
  | JsonArray  of json list
  | JsonObject of (string * json) list

[@@deriving ((show { with_path = false }), eq)]