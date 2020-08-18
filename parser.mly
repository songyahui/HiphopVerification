%{ open Ast %}
%{ open List %}

%token <string> STRING
%token <string> VAR


%token EOF SIMI EQ LPAR RPAR DOT COMMA
%token VARKEY REQUIRE EXPORTS NEW



%start program  
%type <(Ast.declare) list > program



%%

program: 
| EOF {[]}
| a = import r = program { append [a] r }
| a = require SIMI r = program { append [a] r }
| a = export  SIMI r = program { append [a] r }

import:
| s = STRING {Import s}

require:
| VARKEY a = VAR EQ REQUIRE LPAR b = STRING RPAR {Require (a, b)}

export:
| EXPORTS DOT a = VAR EQ NEW b = VAR DOT c = VAR  LPAR d = VAR COMMA e = STRING RPAR {Export e }

