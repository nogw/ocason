module Basic =
  struct
    include Lib.Pretty
    include Lib.Lexer
    include Lib.Ast
    module Util = Lib.Util
  end

open Basic

let json' = JsonObject([("name", JsonString("nogw"))])

let () =
  json' 
  |> Basic.to_string 
  |> print_endline 