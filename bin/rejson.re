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

// let parse = (s: string): Ast.json => {
//   let lexbuf = Lexing.from_string(s);
//   let ast = Parser.prog(Lexer.token, lexbuf)
//   ast
// }

let expression_value =
  MenhirLib.Convert.Simplified.traditional2revised(
    Parser.prog,
  );

let provider = (buf, ()) => {
  let token = Lexer.tokenizer(buf);
  let (start, stop) = Sedlexing.lexing_positions(buf);
  (token, start, stop);
};

let parse = code => {
  let buf = Sedlexing.Utf8.from_string(code);
  expression_value(provider(buf));
};

let () = readfile("tests/A.json") |> parse |> Ast.show_json |> print_endline 