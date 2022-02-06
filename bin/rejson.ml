module Basic =
  struct
    include Lib.Pretty
    include Lib.Lexer
    include Lib.Ast
    module Util = Lib.Util
  end