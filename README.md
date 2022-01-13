## 🗄️ Rejson - A JSON Parser in Reason

## TODO

- [x] json -> ast 
- [x] ast -> json
- [ ] tests

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
  |> Basic.Util.key("user") 
  |> Basic.Util.key("props")
  |> Basic.Util.key("name")
  |> Basic.Util.to_string
  |> print_endline // nogw
```
