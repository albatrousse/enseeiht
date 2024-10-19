(* Evaluation des expressions simples *)


(* Module abstrayant les expressions *)
module type ExprSimple =
sig
  type t
  val const : int -> t
  val plus : t -> t -> t
  val mult : t-> t -> t
end

(* Module réalisant l'évaluation d'une expression *)
module EvalSimple : ExprSimple with type t = int =
struct
  type t = int
  let const c = c
  let plus e1 e2 = e1 + e2
  let mult e1 e2 = e1 * e2
end


(* Solution 1 pour tester *)
(* A l'aide de foncteur *)

(* Définition des expressions *)
module ExemplesSimples (E:ExprSimple) =
struct
  (* 1+(2*3) *)
  let exemple1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* (5+2)*(2*3) *)
  let exemple2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
end

(* Module d'évaluation des exemples *)
module EvalExemples =  ExemplesSimples (EvalSimple)

let%test _ = (EvalExemples.exemple1 = 7)
let%test _ = (EvalExemples.exemple2 = 42)

(* Mdoule réalisant l'affichage d'une expression *)
module PrintSimple : ExprSimple with type t = string =
struct
  type t = string
  let const c = string_of_int c
  let plus e1 e2 = "("^e1^" + "^e2^")"
  let mult e1 e2 = "("^e1^" * "^e2^")"
end

(* Module d'évaluation des exemples pour PrintExemple*)
module EvalPrintSimpleExemples =  ExemplesSimples (PrintSimple)

let%test _ = (EvalPrintSimpleExemples.exemple1 = "(1 + (2 * 3))")
let%test _ = (EvalPrintSimpleExemples.exemple2 = "((5 + 2) * (2 * 3))")

(* Module réalisant le comptage des opérations d'une expression *)
module CompteSimple : ExprSimple with type t = int =
struct
  type t = int
  let const c = 0
  let plus e1 e2 = 1 + e1 + e2
  let mult e1 e2 = 1 + e1 + e2
end

(* Module d'évaluation des exemples pour CompteSimple *)
module EvalCompteExemples =  ExemplesSimples (CompteSimple)

let%test _ = (EvalCompteExemples.exemple1 = 2)
let%test _ = (EvalCompteExemples.exemple2 = 3)

(* Module abstrayant la présence de variable dans les expressions *)
module type ExprVar = 
sig
  type t
  val var : string -> t
  val def : string -> t -> t -> t
end

(* Module permettant d'abstraire les expressions dans leur intégralité *)
module type Expr = 
sig
  type tExpr
  include ExprSimple with type t := tExpr
  include ExprVar with type t := tExpr 
end

(* Module permettant de convertir les expressions avec variables en chaine de caractères *)
module PrintVar : ExprVar with type t = string = 
struct
  type t = string
  let var x = x
  let def x e1 e2 = "let "^x^" = "^e1^" in "^e2 
end

module Print : Expr with type tExpr = string = 
struct
  type tExpr = string
  include PrintSimple
  include PrintVar
end

(* Définition des expressions *)
module Exemples (E:Expr) =
struct
  (* let x = (1 + 2) in (x * 3) *)
  let exempleDef  = E.(def "x" (plus (const 1) (const 2)) (mult (var "x") (const 3)))
  (* (1 + (2 * 3)) *)  
  let exemple1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* ((5 + 2) * (2 * 3)) *)
  let exemple2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
end

(* Module d'évaluation de l'exemple pour Print *)
module EvalPrintExemples =  Exemples (Print)
let%test _ = (EvalPrintExemples.exempleDef = "let x = (1 + 2) in (x * 3)")
let%test _ = (EvalPrintExemples.exemple1 = "(1 + (2 * 3))")
let%test _ = (EvalPrintExemples.exemple2 = "((5 + 2) * (2 * 3))")


