## 🗄️ OCason - A JSON Parser in OCaml
## Examples

Read json from string
```ocaml
let json = {|
{ 
  "user": {
    "active": true,
    "props": {
      "name": "nogw"
    }
  }
} 
|} 

let () = 
  json 
  |> Basic.from_string 
  |> Basic.pp
  |> print_endline

  // (JsonObject
  //    [("user",
  //      (JsonObject
  //         [("active", (JsonBool true));
  //           ("props", 
  //             (JsonObject [("name", (JsonString "nogw"))]))]))])
```

---

Read json from Variants

```ocaml
open Basic

let json = JsonObject([("name", JsonString("nogw"))])

let () = 
  json
  |> Basic.to_string 
  |> print_endline 
  (* { "name": "nogw" }   *)
```

---

Read json from file

```ocaml 
let () = 
  open_in "test.json"
  |> Basic.from_channel 
  |> Basic.pp
  |> print_endline

  (* (JsonObject
     [("user",
       (JsonObject
          [("active", (JsonBool true));
            ("props", 
              (JsonObject [("name", (JsonString "nogw"))]))]))]) *)
```

---

Write json

```ocaml
open Basic

let json = JsonObject([("name", JsonString("nogw"))])

let () =
  let oc = open_out "test.json" in
  Basic.to_channel oc json
```

---

A simple example of access to the json key

```ocaml
let json = {|
{ 
  "user": {
    "active": true,
    "props": {
      "name": "nogw"
    }
  }
} 
|} 

let () = 
  json
  |> Basic.from_string
  |> Basic.Util.key "user" 
  |> Basic.Util.key "props"
  |> Basic.Util.key "name"
  |> Basic.Util.to_string
  |> print_endline 
  (* nogw *)
```