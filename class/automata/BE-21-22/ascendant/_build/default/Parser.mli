
(* The type of tokens. *)

type token = 
  | UL_VIRG
  | UL_TO
  | UL_SYS
  | UL_PTVIRG
  | UL_PT
  | UL_PORT of (string)
  | UL_PAROUV
  | UL_PARFER
  | UL_OUT
  | UL_MODEL
  | UL_INT
  | UL_IN
  | UL_IDENT of (string)
  | UL_FROM
  | UL_FLOW
  | UL_FLOAT
  | UL_FIN
  | UL_ENTIER of (int)
  | UL_DXPT
  | UL_CROOUV
  | UL_CROFER
  | UL_BOOL
  | UL_BLOCK
  | UL_ACCOUV
  | UL_ACCFER

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val modele: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)
