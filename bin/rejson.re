let readfile = filename => {
  let ic = open_in(filename);
  let try_read = () => 
    try(Some(input_line(ic))) {
    | End_of_file => None
    }
  let rec aux = acc => {
    switch (try_read()) {
      | Some(s) => aux([s, ...acc])
      | None => 
        close_in(ic); 
        List.rev(acc) |> String.concat("\n")
    }
  }; aux([])
}

open Lib;

let parse = (s: string): Ast.json => {
  let lexbuf = Lexing.from_string(s);
  let ast = Parser.prog(Lexer.token, lexbuf)
  ast
}

let () = readfile("tests/A.json") |> parse |> Ast.show_json |> print_endline 