open Lib

let json = {|{ "name": "nogw" }|} 
let json' = Ast.(JsonObject([("name", JsonString("nogw"))]))

let from_string () =
  Alcotest.(check string)
  "from string"
  (json |> Lexer.from_string |> Pretty.to_string)
  (json' |> Pretty.to_string)

(* i initially would not generate a temporary file, i would leave it in a "data" folder *)
(* but for some reason it's having a "permission denied" bug, and at the moment i couldn't solve it *)
(* so i believe that MAYBE i will at some point try to solve this, even if i don't change anything. *)

let from_channel () =
  Alcotest.(check string)
  "from channel"
  (
    let input_file = Filename.temp_file "test_yojson_from_file" ".json" in
    let oc = open_out input_file in
    Printf.fprintf oc "%s\n" json;
    close_out oc;

    open_in input_file 
    |> Lexer.from_channel 
    |> Pretty.to_string
  )
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

let write_file () =
  Alcotest.(check string)
  "write"
  (
    let output_file = Filename.temp_file "output" ".json" in
    let oc = open_out output_file in
    Pretty.to_channel oc json';
    close_out oc;

    open_in output_file |> input_line
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