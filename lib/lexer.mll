{
  open Parser

  exception SyntaxError of string

  let unquote x = String.sub x 1 (String.length x - 2)

  let next_line (lexbuf: Lexing.lexbuf) =
      let pos = lexbuf.lex_curr_p in
      lexbuf.lex_curr_p <-
      { pos with pos_bol = lexbuf.lex_curr_pos;
        pos_lnum = pos.pos_lnum + 1 }
}

let white = [' ' '\t']+
let newline    = '\n' | '\r' | "\r\n"
let digit      = '-'? ['0' - '9']
let int        = digit+
let letter     = ['a'-'z' 'A'-'Z']
let string     = '"' [^'"']* '"'

rule token = parse
  | white   { token lexbuf }
  | newline { next_line lexbuf ; token lexbuf }
  | "{"     { LEFTBRACE }
  | "}"     { RIGHTBRACE }
  | "["     { LEFTBRACKET }
  | "]"     { RIGHTBRACKET }
  | ","     { COMMA }
  | ":"     { COLON }
  | string  { STRING (unquote (Lexing.lexeme lexbuf)) }
  | int     { INT (int_of_string (Lexing.lexeme lexbuf))}
  | eof     { EOF }
  | _       { raise (SyntaxError (
              "[LEXER ERROR] Illegal character: \'" 
              ^ Lexing.lexeme lexbuf 
              ^ "\' at " 
              ^ string_of_int(lexbuf.lex_curr_p.pos_lnum) 
              ^ ":" 
              ^ string_of_int(lexbuf.lex_curr_p.pos_cnum) ))}