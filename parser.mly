%{ open Ast %}
%{ open List %}

%token <string> STRING
%token <string> VAR
%token <int> INTE


%token EOF SIMI EQ LPAR RPAR DOT COMMA LBRACK RBRACK 
%token VARKEY REQUIRE EXPORTS NEW IN OUT INOUT HIPHOP MODULE COUNT AWAIT
%token (*GT LT PLUS MINUS LTEQ GTEQ *)NOW PRE VAL PREVAL DO EVERY EMIT
%token HALT YIELD FORK PAR



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

paralle: 
| PAR LBRACK st =hhStatOuter  RBRACK {[st]}

paralleList:
| {[]}
| p1 = paralle  p2 = paralleList {append p1 p2 }

annot:
| {None}
| p = expr {Some p}

hhStat:
| AWAIT LPAR d = hhDelay RPAR  SIMI {HHAwait d}
| HALT {HHHalt} 
| YIELD {HHYield}
| EMIT n = VAR LPAR a= annot RPAR SIMI {HHEmit (n, a)}
| DO LBRACK st =hhStatOuter  RBRACK EVERY LPAR d = hhDelay RPAR  {HHDoEvery (st, d)}
| FORK LBRACK st =hhStatOuter  RBRACK par= paralleList {HHFork (append [st] par)}

hhStatOuter:
| a = hhStat {a}
| a = hhStat b = hhStatOuter {HHBlock (a, b)}


modu:
| HIPHOP MODULE a = VAR LPAR li = signalList RPAR LBRACK stste = hhStatOuter RBRACK { Module (a, li,  stste)}


hhDelay:
| COUNT LPAR a = expr COMMA b = expr RPAR {Count (a, b)}
| a = expr {Immediate a}

(*
op : 
| PLUS {Plus} 
| MINUS {Minus} 
| GT {Gt}
| LT {Lt}
| GTEQ {GtEq}
| LTEQ {LtEq}  
*)

expr: 
| n = INTE {Num n}
| h = VAR DOT NOW {Now h}
| h = VAR DOT PRE {Pre h}
| h = VAR DOT PREVAL {Preval h}
| h = VAR DOT VAL {Val h}
(*
| a = expr o = op c = expr { Binary (o, a, c)}
*)


direction : 
| IN {In} | OUT {Out} | INOUT {Inout}


singleVAR: d= direction v = VAR  {[(d, v, None)]}

signalList:
| {[]}
| p = singleVAR {p}
| p1 = singleVAR  COMMA  p2 = signalList {append p1 p2 }

