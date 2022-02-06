open Sedlexing.Utf8
open Parser

exception SyntaxError of string

let rec tokenizer buf =
  let blank       = [%sedlex.regexp ?(Plus ' ' | '\t')] in
  let newline     = [%sedlex.regexp? '\r' | '\n' | "\r\n"] in
  let digit       = [%sedlex.regexp? '0' .. '9'] in
  let int         = [%sedlex.regexp? (Opt('-'), Plus(digit))] in
  let float       = [%sedlex.regexp? (int, '.') | ('.', Plus(digit)) | (int, '.', Plus(digit))] in
  let letter      = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z'] in

  let hexdigit    = [%sedlex.regexp? '0'..'9' | 'a'..'f' | 'A'..'F'] in
  let unsc_string = [%sedlex.regexp? 0x20 .. 0x21 | 0x23 .. 0x5B | 0x5D .. 0x10FFFF ] in
  let esc_string  = [%sedlex.regexp? ("\\", 0x22 | 0x5C | 0x2F | 0x62 | 0x66 | 0x6E | 0x72 | 0x74 | (0x75, Rep(hexdigit, 4)))] in
  let char        = [%sedlex.regexp? esc_string | unsc_string] in
  let string      = [%sedlex.regexp? ("\"" , (Star (char)) , '"')] in

  let unquote x = String.sub x 1 ((String.length x) - 2) in
  
  [%sedlex
    match buf with
    | blank   -> tokenizer(buf)
    | newline -> Sedlexing.new_line(buf) ; tokenizer(buf)
    | "null"  -> NULL
    | "true"  -> TRUE
    | "false" -> FALSE
    | "{"     -> LEFTBRACE
    | "}"     -> RIGHTBRACE
    | "["     -> LEFTBRACKET
    | "]"     -> RIGHTBRACKET
    | ","     -> COMMA
    | ":"     -> COLON
    | int     -> INT(int_of_string (Sedlexing.Utf8.lexeme (buf)))
    | float   -> FLOAT(float_of_string (Sedlexing.Utf8.lexeme (buf)))
    | string  -> STRING(unquote (Sedlexing.Utf8.lexeme (buf)))
    | eof     -> EOF
    | _       -> raise(SyntaxError("[LEXER ERROR] Illegal character"))
  ]

let expression_value = MenhirLib.Convert.Simplified.traditional2revised Parser.prog

let provider buf () =
  let token = tokenizer buf in
  let (start,stop) = Sedlexing.lexing_positions buf in (token, start, stop)

let from_string str =
  str 
  |> Sedlexing.Utf8.from_string 
  |> provider 
  |> expression_value

let from_channel ic =
  ic 
  |> Sedlexing.Utf8.from_channel 
  |> provider 
  |> expression_value

let pp x = Ast.show_json x