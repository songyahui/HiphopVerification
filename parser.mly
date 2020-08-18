%{ open Ast %}
%{ open List %}

%token <string> STRING
%token <string> VAR


%token EOF SIMI EQ LPAR RPAR DOT COMMA LBRACK RBRACK
%token VARKEY REQUIRE EXPORTS NEW IN OUT INOUT HIPHOP MODULE



%start program  
%type <(Ast.declare) list > program

%%

program: 
| EOF {[]}
| a = import r = program { append [a] r }
| a = require SIMI r = program { append [a] r }
| a = export  SIMI r = program { append [a] r }
| a = modu r = program { append [a] r }

import:
| s = STRING {Import s}

require:
| VARKEY a = VAR EQ REQUIRE LPAR b = STRING RPAR {Require (a, b)}

export:
| EXPORTS DOT a = VAR EQ NEW b = VAR DOT c = VAR  LPAR d = VAR COMMA e = STRING RPAR {Export e }

modu:
| HIPHOP MODULE a = VAR LPAR li = signalList RPAR LBRACK RBRACK { Module (a, li)}

direction : 
| IN {In} | OUT {Out} | INOUT {Inout}


singleVAR: d= direction v = VAR  {[(d, v, None)]}

signalList:
| {[]}
| p = singleVAR {p}
| p1 = singleVAR  COMMA  p2 = signalList {append p1 p2 }

