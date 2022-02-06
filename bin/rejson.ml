module Basic =
  struct
    include Lib.Pretty
    include Lib.Lexer
    include Lib.Ast
    module Util = Lib.Util
  end

open Basic

let json' = (JsonObject([("name", JsonString("nogw"))]))

let () = 
  let oc = open_out "ha.json" in
  Basic.to_channel oc json';
  close_out oc;
