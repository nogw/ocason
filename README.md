# rejson
🗄️ A JSON Parser in Reason

## TODO

- [x] use sedlex
- [x] json -> ast 
- [ ] ast -> json

### received:
```
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
```
 
### expect: 
```ocaml
(JsonObject
   [("user",
    (JsonObject
      [("active", (JsonBool true));
       ("props",
       (JsonObject
         [("name", (JsonString "nogw"));
          ("emoji", (JsonString "\240\159\152\128"));
          ("years", (JsonNumber 12)); 
          ("weight", (JsonFloat 56.5));
          ("phone", JsonNull);
          ("interests",
            (JsonArray
             [(JsonString "fruits");
              (JsonString "functional programming");
              (JsonString "terraria")]))]))]))])
```
