open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptIdent stream =
  match (peekAtFirstToken stream) with
    | (UL_IDENT _) -> (Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptPort stream =
  match (peekAtFirstToken stream) with
    | (UL_PORT _) -> (Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptEntier stream =
  match (peekAtFirstToken stream) with
    | (UL_ENTIER _) -> (Success (advanceInStream stream))
    | _ -> Failure
;;
(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;


(* parseMachine : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseR stream =
  (print_string "R -> model Ident { SE }");
  (match (peekAtFirstToken stream) with
  (* Regle 1 *)
  | UL_MODEL -> 
    inject stream >>=
    accept UL_MODEL >>=
    acceptIdent >>=
    accept UL_ACCOUV >>=
    parseSE >>=
    accept UL_ACCFER
  | _ -> Failure)


and parseSE stream =
  (print_string "SE -> ");
  match (peekAtFirstToken stream) with
  (* Regle 2 *)
  | UL_ACCFER -> inject stream
  (* Regle 3 *)
  | UL_BLOCK | UL_SYS | UL_FLOW ->
      inject stream >>=
      parseE >>=
      parseSE
  | _ -> Failure

and parseE stream =
  (print_string "E -> block Ident P ;");
  match (peekAtFirstToken stream) with
  (* Regle 4 *)
  | UL_BLOCK ->
      inject stream >>=
      accept UL_BLOCK >>=
      acceptIdent >>=
      parseP >>=
      accept UL_PTVIRG
  (* Regle 5 *)
  | UL_SYS -> 
      inject stream >>=
      accept UL_SYS >>=
      acceptIdent >>=
      parseP >>=
      accept UL_ACCOUV >>=
      parseSE >>=
      accept UL_ACCFER
  (* Regle 6 *)
  | UL_FLOW -> 
      inject stream >>=
      accept UL_FLOW >>=
      acceptPort >>=
      accept UL_FROM >>=
      parseNQ >>=
      accept UL_TO >>=
      parseLN >>=
      accept UL_PTVIRG 
  | _ -> Failure

and parseNQ stream =
  (print_string "NQ -> Ident");
  match (peekAtFirstToken stream) with
  (* Regle 7 *)
  | UL_PORT _-> inject stream >>=
      acceptPort
  (* Regle 8 *)
  | UL_IDENT _-> inject stream >>=
      acceptIdent >>=
      accept UL_PT >>=
      acceptPort
  | _ -> Failure

and parseLN stream =
  (print_string "LN -> Ident");
  match (peekAtFirstToken stream) with
  (* Regle 9 *)
  | UL_PTVIRG -> inject stream
  (* Regle 10 *)
  | UL_IDENT _| UL_PORT _-> inject stream >>=
      parseNQ >>=
      parseSN
  | _ -> Failure

and parseSN stream =
  (print_string "SN -> Ident");
  match (peekAtFirstToken stream) with
  (* Regle 11 *)
  | UL_PTVIRG -> inject stream
  (* Regle 12 *)
  | UL_VIRG -> inject stream >>=
      accept UL_VIRG >>=
      parseNQ >>=
      parseSN
  | _ -> Failure

and parseP stream =
  (print_string "P -> ");
  match (peekAtFirstToken stream) with
  (* Regle 13 *)
  | UL_PAROUV -> inject stream >>=
      accept UL_PAROUV >>=
      parseLP >>=
      accept UL_PARFER
  | _ -> Failure

and parseLP stream =
  (print_string "LP -> ");
  match (peekAtFirstToken stream) with
  (* Regle 14 *)
  | UL_PORT _-> inject stream >>=
      parseDP >>=
      parseSP
  | _ -> Failure


and parseSP stream =
  (print_string "SP -> ");
  match (peekAtFirstToken stream) with
  (* Regle 15 *)
  | UL_PARFER -> inject stream
  (* Regle 16 *)
  | UL_VIRG -> inject stream >>=
      accept UL_VIRG >>=
      parseDP >>=
      parseSP
  | _ -> Failure

and parseDP stream =
  (print_string "DP -> ");
  match (peekAtFirstToken stream) with
  (* Regle 17 *)
  | UL_PORT _-> inject stream >>=
      acceptPort >>=
      accept UL_DXPT >>=
      parseM >>=
      parseT >>=
      parseOT
  | _ -> Failure

and parseM stream =
  (print_string "M -> ");
  match (peekAtFirstToken stream) with
  (* Regle 18 *)
  | UL_IN -> inject stream >>=
      accept UL_IN
  (* Regle 19 *)
  | UL_OUT -> inject stream >>=
      accept UL_OUT
  | _ -> Failure

and parseT stream =
  (print_string "T -> ");
  match (peekAtFirstToken stream) with
  (* Regle 20 *)
  | UL_ENTIER _-> inject stream >>=
      acceptEntier
  (* Regle 21 *)
  | UL_FLOAT -> inject stream >>=
      accept UL_FLOAT
  (* Regle 22 *)
  | UL_BOOL -> inject stream >>=
      accept UL_BOOL
  | _ -> Failure
  
and parseOT stream =
  (print_string "OT -> ");
  match (peekAtFirstToken stream) with
  (* Regle 23 *)
  | UL_VIRG | UL_PARFER -> inject stream
  (* Regle 24 *)
  | UL_CROOUV -> inject stream >>=
      accept UL_CROOUV >>=
      acceptEntier >>=
      parseSV >>=
      accept UL_CROFER
  | _ -> Failure

and parseSV stream =
  (print_string "SV -> ");
  match (peekAtFirstToken stream) with
  (* Regle 25 *)
  | UL_CROFER -> inject stream
  (* Regle 26 *)
  | UL_VIRG -> inject stream >>=
      accept UL_VIRG >>=
      acceptEntier >>=
      parseSV
  | _ -> Failure

;;
