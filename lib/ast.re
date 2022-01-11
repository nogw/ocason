[@deriving (show({ with_path: false }), eq)]
type json = 
  | JsonNull
  | JsonBool   (bool)
  | JsonNumber (int)
  | JsonString (string)
  | JsonArray  (list(json))
  | JsonObject (list((string, json)))