%{
  open Ast
%}

%token LEFTBRACE
%token RIGHTBRACE
%token NULL
%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token LEFTBRACKET
%token RIGHTBRACKET
%token COMMA
%token COLON
%token TRUE
%token FALSE
%token EOF

%start <Ast.json> prog %%

prog: 
  | v = value ; EOF { v }  

value: 
  | n = NULL   { JsonNull }
  | i = INT    { JsonNumber(i) }
  | f = FLOAT  { JsonFloat (f) }
  | s = STRING { JsonString(s) } 
  | b = TRUE   { JsonBool(true) }
  | b = FALSE  { JsonBool(false) }
  | a = array  { a }
  | o = obj    { o }

array:
  | LEFTBRACKET ; RIGHTBRACKET                    { JsonArray([]) }
  | LEFTBRACKET ; l = array_values ; RIGHTBRACKET { JsonArray(List.rev(l)) }

array_values:
  | v = value                             { [v] }
  | lv = array_values ; COMMA ; v = value { v :: lv } 

obj: 
  | LEFTBRACE ; RIGHTBRACE                     { JsonObject([]) }
  | LEFTBRACE ; op = obj_props ; RIGHTBRACE    { JsonObject(List.rev(op)) } 

obj_props:
  | s = STRING ; COLON ; v = value                             { [(s, v)] }
  | ob = obj_props ; COMMA ; s = STRING ; COLON ; v = value    { (s, v) :: ob }
