open Lib

let json = {|{ "name": "nogw" }|} 
let json' = Ast.(JsonObject([("name", JsonString("nogw"))]))

let from_string () =
  Alcotest.(check string)
  "from string"
  (json |> Lexer.from_string |> Pretty.to_string)
  (json' |> Pretty.to_string)

let from_channel () =
  Alcotest.(check string)
  "from channel"
  (open_in "data/input.json" |> Lexer.from_channel |> Pretty.to_string)
  (json' |> Pretty.to_string)

let to_string () =
  Alcotest.(check string)
  "to string"
  (json' |> Pretty.to_string)
  json

let key () =
  Alcotest.(check string)
  "key"
  (json' |> Util.key "name" |> Util.to_string)
  "nogw"

(* TODO: for some reason this test only runs if I run it using "sudo esy test", 
  I still don't understand this problem, but I believe it is Dune file *)
let write_file () =
  Alcotest.(check string)
  "write"
  (
    let oc = open_out "data/output.json" in
    Pretty.to_channel oc json';
    close_out oc;

    open_in "data/input.json" |> input_line
  )
  json

let () = 
  let open Alcotest in 
  run "OCason" [
    "generate json", [
      test_case "generate" `Quick from_string;
      test_case "generate" `Quick from_channel;
    ];
    "generate string", [
      test_case "generate" `Quick to_string
    ];
    "utils", [
      test_case "tool" `Quick key
    ];
    "write json", [
      test_case "write" `Quick write_file
    ]
  ] 