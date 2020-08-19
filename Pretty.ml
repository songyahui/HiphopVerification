(*----------------------------------------------------
----------------------PRINTING------------------------
----------------------------------------------------*)

open String
open List
open Ast
open Printf
open Int32


exception Foo of string


(*used to generate the free veriables, for subsititution*)
let freeVar = ["t1"; "t2"; "t3"; "t4";"t5";"t6";"t7";"t8";"t9";"t10"
              ;"t11"; "t12"; "t13"; "t14";"t15";"t16";"t17";"t18";"t19";"t20"
              ;"t21"; "t22"; "t23"; "t24";"t25";"t26";"t27";"t28";"t29";"t30"];;



let rec getAfreeVar (varList:string list):string  =
  let rec findOne li = 
    match li with 
        [] -> raise ( Foo "freeVar list too small exception!")
      | x :: xs -> if (exists (fun a -> String.compare a x == 0) varList) == true then findOne xs else x
  in
  findOne freeVar
;;




let rec iter f = function
  | [] -> ()
  | [x] ->
      f true x
  | x :: tl ->
      f false x;
      iter f tl

let to_buffer ?(line_prefix = "") ~get_name ~get_children buf x =
  let rec print_root indent x =
    bprintf buf "%s\n" (get_name x);
    let children = get_children x in
    iter (print_child indent) children
  and print_child indent is_last x =
    let line =
      if is_last then
        "└── "
      else
        "├── "
    in
    bprintf buf "%s%s" indent line;
    let extra_indent =
      if is_last then
        "    "
      else
        "│   "
    in
    print_root (indent ^ extra_indent) x
  in
  Buffer.add_string buf line_prefix;
  print_root line_prefix x

let printTree ?line_prefix ~get_name ~get_children x =
  let buf = Buffer.create 1000 in
  to_buffer ?line_prefix ~get_name ~get_children buf x;
  Buffer.contents buf

type binary_tree =
  | Node of string * (binary_tree  list )
  | Leaf

let get_name = function
    | Leaf -> "."
    | Node (name, li) -> name;;

let get_children = function
    | Leaf -> []
    | Node (_, li) -> List.filter ((<>) Leaf) li;;

let rec input_lines file =
  match try [input_line file] with End_of_file -> [] with
   [] -> []
  | [line] -> (String.trim line) :: input_lines file
  | _ -> failwith "Weird input_line return value"

  ;;

let rec input_lines file =
  match try [input_line file] with End_of_file -> [] with
   [] -> []
  | [line] -> (String.trim line) :: input_lines file
  | _ -> failwith "Weird input_line return value"
;;

let rec string_of_expr (expr:hhExpr): string = 
  match expr with 
    Now id -> id^".now"
  | Pre id -> id^".now"
  | Val id -> id^".now"
  | Preval id -> id^".now"
  | Num i -> string_of_int i
  | _ -> raise (Foo "string_of_expr")
  ;;


let rec string_of_hhSigRun (p: hhSigRun) : string =
  let (a, b, c) = p in 
  let str_a = (match a with 
                In -> "in "
              | Out -> "out "
              | Inout -> "inout "
              ) in 
  let str_b = b in 
  let str_c = (match c with 
                Some a -> "(" ^string_of_expr a ^ ")" 
              | None -> ""
              ) in 
  str_a ^ str_b ^ str_c
  ;;

let rec string_of_op (op:op) :string = 
  match op with 
  | Plus -> "+" 
  | Minus -> "-" 
  | Gt -> ">" 
  | Lt -> "<"
  | GtEq -> ">=" 
  | LtEq -> "<="
  ;;

let rec string_of_expr (expr:hhExpr) :string = 
  match expr with 
    Now id -> id ^".now"
  | Pre id -> id ^".pre"
  | Val id -> id ^".val"
  | Preval id -> id ^".preval"
  | Num i -> string_of_int i 
  | Binary (op, e1, e2) -> string_of_expr e1 ^ string_of_op op^ string_of_expr e2
  ;;

let rec string_of_hhDelay (d: hhDelay):string =
  match d with 
  | Count (e1, e2) -> "count("^ string_of_expr e1 ^","^ string_of_expr e2 ^")"
  | Immediate e ->string_of_expr e 
  ;;

let rec string_of_hhStat (sts:hhStat) :string =
  match sts with 
  | HHHalt -> "nothing" 
  | HHBlock (hhStat1, hhStat2) -> string_of_hhStat hhStat1 ^ "\n" ^ string_of_hhStat hhStat2 
  | HHFork hhStatL -> List.fold_left (fun acc cur -> acc ^ "\n||\n" ^ string_of_hhStat cur) "" hhStatL
  | HHEmit (id, ex) -> "emit " ^ id ^ (match ex with 
    Some p -> string_of_expr p
    | None -> "")
  | HHDoEvery (hhStat1, hhDelay1) -> "\ndo{ \n"^ string_of_hhStat hhStat1 ^ "}\n" ^ "every" ^ string_of_hhDelay hhDelay1
  | HHAwait d -> "await " ^ string_of_hhDelay d 
  | _ -> "string_of_hhStat"
  (*
  | HHSustain of iden * hhExpr option 
  | HHLoop of hhStat
  | HHYield
  | HHAbort of hhDelay * hhStat
  | HHTrap of iden* hhStat
  | HHBreak of iden
  | HHRun of hhExpr * hhSigRun list
  | HHIf of hhExpr * hhStat * hhStat option 
  | HHExpression of hhExpr
  *)
  ;;


let string_of_declare (d : declare): string = 
  match d with 
    Import str -> str
  | Require (id1, id2) -> id1 ^ " = " ^ id2
  | Export e -> e 
  | Module (id, signaLi, state) -> 
    id ^ 
    (List.fold_left (fun acc dec -> acc ^ "," ^ string_of_hhSigRun dec) "(" signaLi)^ ")" ^
    string_of_hhStat state   ^"\n"
  ;;

let rec string_of_prog (p : prog) : string =

  List.fold_left (fun acc dec -> acc ^ "\n" ^ string_of_declare dec) "" p
  ;;


