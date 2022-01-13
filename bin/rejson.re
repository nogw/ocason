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

let json = {| 
  { 
    "user": {
      "active": true,
      "props": {
        "name": "nogw",
        "emoji": "😀",
        "years": 12,
        "weight": 56.5,
        "phone": null,
        "interests": ["fruits", "functional programming", "terraria"]
      }
    }
  } 
|}

let () = json |> Lib.Lexer.parse |> Lib.Ast.show_json |> print_endline 

let _a = 
  json 
  |> Lib.Lexer.parse 
  |> Lib.Util.member("user") 
  |> Lib.Util.member("props") 
  |> Lib.Util.member("name") 
  |> Lib.Util.to_string 
  |> print_endline 