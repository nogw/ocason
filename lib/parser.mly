%{
  open Ast
%}

%token LEFTBRACE
%token RIGHTBRACE
// todo: float, bool
%token <int> INT
%token <string> STRING
%token LEFTBRACKET
%token RIGHTBRACKET
%token COMMA
%token COLON
%token EOF

%start <Ast.json> prog %%

prog: 
  | v = value ; EOF { v }  

value: 
  | s = STRING { JsonString(s) } 
  | i = INT    { JsonNumber(i) }
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
