type iden = string 

type direction = In | Out | Inout

type op = Plus | Minus | Gt | Lt | GtEq | LtEq 

type hhExpr = Now of iden
        | Pre of iden
        | Val of iden
        | Preval of iden
        | Num of int 
        | Binary of op * hhExpr * hhExpr

type hhDelay = Count of hhExpr * hhExpr | Immediate of hhExpr

type hhSigRun = direction * iden * hhExpr option

type hhStat = 
        HHHalt 
      | HHBlock of hhStat * hhStat 
      | HHFork of hhStat * hhStat 
      | HHEmit of iden * hhExpr option 
      | HHSustain of iden * hhExpr option 
      | HHLoop of hhStat
      | HHYield
      | HHAwait of hhDelay
      | HHAbort of hhDelay * hhStat
      | HHTrap of iden* hhStat
      | HHBreak of iden
      | HHRun of hhExpr * hhSigRun list
      | HHIf of hhExpr * hhStat * hhStat option 
      | HHExpression of hhExpr
      | HHDo of hhStat * hhDelay 
      | HHEvery of hhDelay * hhStat     

type hhModule = iden * hhSigRun list * hhStat

type declare = Import of iden | Require of iden * iden | Export of iden | Module of hhModule

type prog = declare list 
      

(*
type state = One | Zero
type mapping = (var * state) 


(*signal set*)
type instance = mapping list * mapping list 
           (*前面的是constrain,  后面的是signal assignment*)

type fst = Negation of idenlist
           | Normal of idenlist
;;

(*type event  = Instance of instance   | Not of instance *)


type es = Bot 
        | Emp 
        | Instance of instance 
        | Con of es * es
        | Kleene of es
        | Any
        | Omega of es
        | Ntimed of es * int
        | Not of es

type history = es 

type current = instance

type trace = history * current * int 

type precondition = var list * (history * current) 


type postcondition  = trace list 

type inclusion = INC of es list * es list;;

type jscode = 
            JSnumber of int
          | Var of var
          | Assign of jscode * jscode
          | Binary of jscode * jscode


type hiphop = 
            Nothing 
          | Loop of prog
          | Seq of prog * prog 
          | Par of prog * prog
          | Await of prog
          | If of cond * prog * prog
          | Emit of var
          | Trap of iden* prog
          | Exit of iden* int
          | JS of jscode




type ltl = Lable of string 
        | Next of ltl
        | Until of ltl * ltl
        | Global of ltl
        | Future of ltl
        | NotLTL of ltl
        | Imply of ltl * ltl
        | AndLTL of ltl * ltl
        | OrLTL of ltl * ltl


type spec_prog = es list * prog
*)