
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_VIRG
    | UL_TO
    | UL_SYS
    | UL_PTVIRG
    | UL_PT
    | UL_PORT of (
# 25 "Parser.mly"
       (string)
# 20 "Parser.ml"
  )
    | UL_PAROUV
    | UL_PARFER
    | UL_OUT
    | UL_MODEL
    | UL_INT
    | UL_IN
    | UL_IDENT of (
# 24 "Parser.mly"
       (string)
# 31 "Parser.ml"
  )
    | UL_FROM
    | UL_FLOW
    | UL_FLOAT
    | UL_FIN
    | UL_ENTIER of (
# 23 "Parser.mly"
       (int)
# 40 "Parser.ml"
  )
    | UL_DXPT
    | UL_CROOUV
    | UL_CROFER
    | UL_BOOL
    | UL_BLOCK
    | UL_ACCOUV
    | UL_ACCFER
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 62 "Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState03 : ('s _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_state
    (** State 03.
        Stack shape : UL_IDENT.
        Start symbol: modele. *)

  | MenhirState05 : (('s, _menhir_box_modele) _menhir_cell1_UL_SYS _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_state
    (** State 05.
        Stack shape : UL_SYS UL_IDENT.
        Start symbol: modele. *)

  | MenhirState06 : (('s _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_cell1_UL_PAROUV, _menhir_box_modele) _menhir_state
    (** State 06.
        Stack shape : UL_IDENT UL_PAROUV.
        Start symbol: modele. *)

  | MenhirState09 : (('s, _menhir_box_modele) _menhir_cell1_UL_PORT, _menhir_box_modele) _menhir_state
    (** State 09.
        Stack shape : UL_PORT.
        Start symbol: modele. *)

  | MenhirState11 : (('s, _menhir_box_modele) _menhir_cell1_UL_INT, _menhir_box_modele) _menhir_state
    (** State 11.
        Stack shape : UL_INT.
        Start symbol: modele. *)

  | MenhirState13 : (('s, _menhir_box_modele) _menhir_cell1_UL_ENTIER, _menhir_box_modele) _menhir_state
    (** State 13.
        Stack shape : UL_ENTIER.
        Start symbol: modele. *)

  | MenhirState18 : (('s, _menhir_box_modele) _menhir_cell1_UL_FLOAT, _menhir_box_modele) _menhir_state
    (** State 18.
        Stack shape : UL_FLOAT.
        Start symbol: modele. *)

  | MenhirState22 : (('s, _menhir_box_modele) _menhir_cell1_UL_BOOL, _menhir_box_modele) _menhir_state
    (** State 22.
        Stack shape : UL_BOOL.
        Start symbol: modele. *)

  | MenhirState26 : (('s, _menhir_box_modele) _menhir_cell1_UL_PORT, _menhir_box_modele) _menhir_state
    (** State 26.
        Stack shape : UL_PORT.
        Start symbol: modele. *)

  | MenhirState31 : (('s, _menhir_box_modele) _menhir_cell1_port, _menhir_box_modele) _menhir_state
    (** State 31.
        Stack shape : port.
        Start symbol: modele. *)

  | MenhirState34 : ((('s, _menhir_box_modele) _menhir_cell1_UL_SYS _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_cell1_parametres, _menhir_box_modele) _menhir_state
    (** State 34.
        Stack shape : UL_SYS UL_IDENT parametres.
        Start symbol: modele. *)

  | MenhirState39 : (('s, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_PORT _menhir_cell0_UL_PORT, _menhir_box_modele) _menhir_state
    (** State 39.
        Stack shape : UL_FLOW UL_PORT UL_PORT.
        Start symbol: modele. *)

  | MenhirState42 : (('s, _menhir_box_modele) _menhir_cell1_UL_PORT, _menhir_box_modele) _menhir_state
    (** State 42.
        Stack shape : UL_PORT.
        Start symbol: modele. *)

  | MenhirState46 : (('s, _menhir_box_modele) _menhir_cell1_UL_IDENT _menhir_cell0_UL_PORT, _menhir_box_modele) _menhir_state
    (** State 46.
        Stack shape : UL_IDENT UL_PORT.
        Start symbol: modele. *)

  | MenhirState54 : (('s, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_PORT _menhir_cell0_UL_IDENT _menhir_cell0_UL_PORT, _menhir_box_modele) _menhir_state
    (** State 54.
        Stack shape : UL_FLOW UL_PORT UL_IDENT UL_PORT.
        Start symbol: modele. *)

  | MenhirState59 : (('s, _menhir_box_modele) _menhir_cell1_UL_BLOCK _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_state
    (** State 59.
        Stack shape : UL_BLOCK UL_IDENT.
        Start symbol: modele. *)

  | MenhirState66 : (('s, _menhir_box_modele) _menhir_cell1_element, _menhir_box_modele) _menhir_state
    (** State 66.
        Stack shape : element.
        Start symbol: modele. *)


and ('s, 'r) _menhir_cell1_element = 
  | MenhirCell1_element of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_parametres = 
  | MenhirCell1_parametres of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_port = 
  | MenhirCell1_port of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_UL_BLOCK = 
  | MenhirCell1_UL_BLOCK of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_BOOL = 
  | MenhirCell1_UL_BOOL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_ENTIER = 
  | MenhirCell1_UL_ENTIER of 's * ('s, 'r) _menhir_state * (
# 23 "Parser.mly"
       (int)
# 170 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_FLOAT = 
  | MenhirCell1_UL_FLOAT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_FLOW = 
  | MenhirCell1_UL_FLOW of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_IDENT = 
  | MenhirCell1_UL_IDENT of 's * ('s, 'r) _menhir_state * (
# 24 "Parser.mly"
       (string)
# 183 "Parser.ml"
)

and 's _menhir_cell0_UL_IDENT = 
  | MenhirCell0_UL_IDENT of 's * (
# 24 "Parser.mly"
       (string)
# 190 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_INT = 
  | MenhirCell1_UL_INT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_PAROUV = 
  | MenhirCell1_UL_PAROUV of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_PORT = 
  | MenhirCell1_UL_PORT of 's * ('s, 'r) _menhir_state * (
# 25 "Parser.mly"
       (string)
# 203 "Parser.ml"
)

and 's _menhir_cell0_UL_PORT = 
  | MenhirCell0_UL_PORT of 's * (
# 25 "Parser.mly"
       (string)
# 210 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_SYS = 
  | MenhirCell1_UL_SYS of 's * ('s, 'r) _menhir_state

and _menhir_box_modele = 
  | MenhirBox_modele of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 49 "Parser.mly"
                                              (print_endline "bloc : UL_BLOCK UL_IDENT parametres UL_PTVIRG")
# 224 "Parser.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 78 "Parser.mly"
                                (print_endline "boucle : UL_PORT UL_VIRG boucle")
# 232 "Parser.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 79 "Parser.mly"
                                                (print_endline "boucle : UL_IDENT UL_PT UL_PORT UL_VIRG boucle")
# 240 "Parser.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 80 "Parser.mly"
                                 (print_endline "boucle : UL_IDENT UL_PT UL_PORT")
# 248 "Parser.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 81 "Parser.mly"
                  (print_endline "boucle : UL_PORT")
# 256 "Parser.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 45 "Parser.mly"
               (print_endline "element : bloc")
# 264 "Parser.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 46 "Parser.mly"
                  (print_endline "element : systeme")
# 272 "Parser.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 47 "Parser.mly"
               (print_endline "element : flow")
# 280 "Parser.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 42 "Parser.mly"
                            (print_endline "elements : element elements")
# 288 "Parser.ml"
     : (unit))

let _menhir_action_10 =
  fun () ->
    (
# 43 "Parser.mly"
           (print_endline "elements : vide")
# 296 "Parser.ml"
     : (unit))

let _menhir_action_11 =
  fun () ->
    (
# 69 "Parser.mly"
                   (print_endline "entier : UL_ENTIER")
# 304 "Parser.ml"
     : (unit))

let _menhir_action_12 =
  fun () ->
    (
# 70 "Parser.mly"
                                   (print_endline "entier : UL_ENTIER UL_VIRG entier")
# 312 "Parser.ml"
     : (unit))

let _menhir_action_13 =
  fun () ->
    (
# 72 "Parser.mly"
                                                       (print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_PORT UL_TO UL_PTVIRG")
# 320 "Parser.ml"
     : (unit))

let _menhir_action_14 =
  fun () ->
    (
# 73 "Parser.mly"
                                                                        (print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_IDENT UL_PT UL_PORT UL_TO UL_PTVIRG")
# 328 "Parser.ml"
     : (unit))

let _menhir_action_15 =
  fun () ->
    (
# 74 "Parser.mly"
                                                                               (print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_IDENT UL_PT UL_PORT UL_TO boucle UL_PTVIRG")
# 336 "Parser.ml"
     : (unit))

let _menhir_action_16 =
  fun () ->
    (
# 75 "Parser.mly"
                                                                (print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_PORT UL_TO boucle UL_PTVIRG")
# 344 "Parser.ml"
     : (unit))

let _menhir_action_17 =
  fun () ->
    (
# 40 "Parser.mly"
                 ( (print_endline "modele : UL_MODEL IDENT { ... } UL_FIN ") )
# 352 "Parser.ml"
     : (unit))

let _menhir_action_18 =
  fun () ->
    (
# 53 "Parser.mly"
                                            (print_endline "parametres : UL_PAROUV virguleport UL_PARFER")
# 360 "Parser.ml"
     : (unit))

let _menhir_action_19 =
  fun () ->
    (
# 58 "Parser.mly"
                                (print_endline "port : UL_PORT UL_DXPT UL_IN TYPE")
# 368 "Parser.ml"
     : (unit))

let _menhir_action_20 =
  fun () ->
    (
# 59 "Parser.mly"
                                 (print_endline "port : UL_PORT UL_DXPT UL_OUT TYPE")
# 376 "Parser.ml"
     : (unit))

let _menhir_action_21 =
  fun () ->
    (
# 51 "Parser.mly"
                                                                  (print_endline "systeme : UL_SYS UL_IDENT parametres UL_ACCOUV elements UL_ACCFER")
# 384 "Parser.ml"
     : (unit))

let _menhir_action_22 =
  fun () ->
    (
# 61 "Parser.mly"
            (print_endline "type : UL_INT")
# 392 "Parser.ml"
     : (unit))

let _menhir_action_23 =
  fun () ->
    (
# 62 "Parser.mly"
                  (print_endline "type : UL_FLOAT")
# 400 "Parser.ml"
     : (unit))

let _menhir_action_24 =
  fun () ->
    (
# 63 "Parser.mly"
                 (print_endline "type : UL_BOOL")
# 408 "Parser.ml"
     : (unit))

let _menhir_action_25 =
  fun () ->
    (
# 64 "Parser.mly"
                                           (print_endline "type : UL_INT UL_CROOUV UL_ENTIER UL_CROFER")
# 416 "Parser.ml"
     : (unit))

let _menhir_action_26 =
  fun () ->
    (
# 65 "Parser.mly"
                                              (print_endline "type : UL_FLOAT UL_CROOUV UL_ENTIER UL_CROFER")
# 424 "Parser.ml"
     : (unit))

let _menhir_action_27 =
  fun () ->
    (
# 66 "Parser.mly"
                                             (print_endline "type : UL_BOOL UL_CROOUV UL_ENTIER UL_CROFER")
# 432 "Parser.ml"
     : (unit))

let _menhir_action_28 =
  fun () ->
    (
# 55 "Parser.mly"
                                       (print_endline "virguleport : port UL_VIRG virguleport")
# 440 "Parser.ml"
     : (unit))

let _menhir_action_29 =
  fun () ->
    (
# 56 "Parser.mly"
                   (print_endline "virguleport : port")
# 448 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | UL_ACCFER ->
        "UL_ACCFER"
    | UL_ACCOUV ->
        "UL_ACCOUV"
    | UL_BLOCK ->
        "UL_BLOCK"
    | UL_BOOL ->
        "UL_BOOL"
    | UL_CROFER ->
        "UL_CROFER"
    | UL_CROOUV ->
        "UL_CROOUV"
    | UL_DXPT ->
        "UL_DXPT"
    | UL_ENTIER _ ->
        "UL_ENTIER"
    | UL_FIN ->
        "UL_FIN"
    | UL_FLOAT ->
        "UL_FLOAT"
    | UL_FLOW ->
        "UL_FLOW"
    | UL_FROM ->
        "UL_FROM"
    | UL_IDENT _ ->
        "UL_IDENT"
    | UL_IN ->
        "UL_IN"
    | UL_INT ->
        "UL_INT"
    | UL_MODEL ->
        "UL_MODEL"
    | UL_OUT ->
        "UL_OUT"
    | UL_PARFER ->
        "UL_PARFER"
    | UL_PAROUV ->
        "UL_PAROUV"
    | UL_PORT _ ->
        "UL_PORT"
    | UL_PT ->
        "UL_PT"
    | UL_PTVIRG ->
        "UL_PTVIRG"
    | UL_SYS ->
        "UL_SYS"
    | UL_TO ->
        "UL_TO"
    | UL_VIRG ->
        "UL_VIRG"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_69 : type  ttv_stack. ttv_stack _menhir_cell0_UL_IDENT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_FIN ->
          let MenhirCell0_UL_IDENT (_menhir_stack, _) = _menhir_stack in
          let _v = _menhir_action_17 () in
          MenhirBox_modele _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_SYS (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _v ->
          let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState05 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PAROUV ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. (ttv_stack _menhir_cell0_UL_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_PAROUV (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState06 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PORT _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_PORT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_DXPT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_OUT ->
              let _menhir_s = MenhirState09 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_INT ->
                  _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UL_FLOAT ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UL_BOOL ->
                  _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | UL_IN ->
              let _menhir_s = MenhirState26 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_INT ->
                  _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UL_FLOAT ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UL_BOOL ->
                  _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_CROOUV ->
          let _menhir_stack = MenhirCell1_UL_INT (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState11 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_ENTIER _v ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | UL_PARFER | UL_VIRG ->
          let _ = _menhir_action_22 () in
          _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          let _menhir_stack = MenhirCell1_UL_ENTIER (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState13 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_ENTIER _v ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | UL_CROFER ->
          let _ = _menhir_action_11 () in
          _menhir_goto_entier _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_entier : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState22 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState18 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState11 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState13 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_23 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_BOOL -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_BOOL (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_27 () in
      _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_goto_ty : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match _menhir_s with
      | MenhirState26 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState09 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_27 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_PORT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_UL_PORT (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_19 () in
      _menhir_goto_port _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_port : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          let _menhir_stack = MenhirCell1_port (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState31 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PORT _v ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | UL_PARFER ->
          let _ = _menhir_action_29 () in
          _menhir_goto_virguleport _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_virguleport : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState31 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState06 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_32 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_port -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_port (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_28 () in
      _menhir_goto_virguleport _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_28 : type  ttv_stack. (ttv_stack _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_cell1_UL_PAROUV -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_PAROUV (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_18 () in
      _menhir_goto_parametres _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_parametres : type  ttv_stack. (ttv_stack _menhir_cell0_UL_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState59 ->
          _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState05 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_60 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_BLOCK _menhir_cell0_UL_IDENT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_UL_IDENT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_UL_BLOCK (_menhir_stack, _menhir_s) = _menhir_stack in
          let _ = _menhir_action_01 () in
          let _v = _menhir_action_06 () in
          _menhir_goto_element _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_element : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_element (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_SYS ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState66
      | UL_FLOW ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState66
      | UL_BLOCK ->
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState66
      | UL_ACCFER ->
          let _ = _menhir_action_10 () in
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PORT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_FROM ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_PORT _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_TO ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | UL_PTVIRG ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _ = _menhir_action_13 () in
                          _menhir_goto_flot _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
                      | UL_PORT _v_1 ->
                          let _menhir_stack = MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) in
                          let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v) in
                          let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v_0) in
                          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState39
                      | UL_IDENT _v_2 ->
                          let _menhir_stack = MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) in
                          let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v) in
                          let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v_0) in
                          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState39
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | UL_IDENT _v_3 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_PT ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | UL_PORT _v_4 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | UL_TO ->
                              let _tok = _menhir_lexer _menhir_lexbuf in
                              (match (_tok : MenhirBasics.token) with
                              | UL_PTVIRG ->
                                  let _tok = _menhir_lexer _menhir_lexbuf in
                                  let _ = _menhir_action_14 () in
                                  _menhir_goto_flot _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
                              | UL_PORT _v_5 ->
                                  let _menhir_stack = MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) in
                                  let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v) in
                                  let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v_3) in
                                  let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v_4) in
                                  _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState54
                              | UL_IDENT _v_6 ->
                                  let _menhir_stack = MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) in
                                  let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v) in
                                  let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v_3) in
                                  let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v_4) in
                                  _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v_6 MenhirState54
                              | _ ->
                                  _eRR ())
                          | _ ->
                              _eRR ())
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_flot : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      let _v = _menhir_action_08 () in
      _menhir_goto_element _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_41 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          let _menhir_stack = MenhirCell1_UL_PORT (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState42 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PORT _v ->
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | UL_IDENT _v ->
              _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | UL_PTVIRG ->
          let _ = _menhir_action_05 () in
          _menhir_goto_boucle _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_43 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PORT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_VIRG ->
                  let _menhir_stack = MenhirCell1_UL_IDENT (_menhir_stack, _menhir_s, _v) in
                  let _menhir_stack = MenhirCell0_UL_PORT (_menhir_stack, _v_0) in
                  let _menhir_s = MenhirState46 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_PORT _v ->
                      _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | UL_IDENT _v ->
                      _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | _ ->
                      _eRR ())
              | UL_PTVIRG ->
                  let _ = _menhir_action_04 () in
                  _menhir_goto_boucle _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_boucle : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState54 ->
          _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState39 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState42 ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState46 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_56 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_PORT _menhir_cell0_UL_IDENT _menhir_cell0_UL_PORT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_UL_PORT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_UL_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_UL_PORT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_15 () in
      _menhir_goto_flot _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_run_49 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_PORT _menhir_cell0_UL_PORT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_UL_PORT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_UL_PORT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_16 () in
      _menhir_goto_flot _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_run_48 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_PORT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_UL_PORT (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_02 () in
      _menhir_goto_boucle _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_47 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_IDENT _menhir_cell0_UL_PORT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell0_UL_PORT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_IDENT (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_03 () in
      _menhir_goto_boucle _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_58 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_BLOCK (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _v ->
          let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState59 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PAROUV ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_67 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_element -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_element (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_09 () in
      _menhir_goto_elements _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_elements : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState03 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState66 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState34 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_64 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYS _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_cell1_parametres -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_parametres (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell0_UL_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_SYS (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_21 () in
      let _v = _menhir_action_07 () in
      _menhir_goto_element _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_33 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYS _menhir_cell0_UL_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_parametres (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_ACCOUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_SYS ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
          | UL_FLOW ->
              _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
          | UL_BLOCK ->
              _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
          | UL_ACCFER ->
              let _ = _menhir_action_10 () in
              _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_PORT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_UL_PORT (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_20 () in
      _menhir_goto_port _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_19 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_FLOAT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_FLOAT (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_26 () in
      _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_run_15 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_INT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_INT (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_25 () in
      _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_run_14 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_ENTIER -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_UL_ENTIER (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_12 () in
      _menhir_goto_entier _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_CROOUV ->
          let _menhir_stack = MenhirCell1_UL_FLOAT (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState18 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_ENTIER _v ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | UL_PARFER | UL_VIRG ->
          let _ = _menhir_action_23 () in
          _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_CROOUV ->
          let _menhir_stack = MenhirCell1_UL_BOOL (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState22 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_ENTIER _v ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | UL_PARFER | UL_VIRG ->
          let _ = _menhir_action_24 () in
          _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_MODEL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_IDENT _v ->
              let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_ACCOUV ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_SYS ->
                      _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
                  | UL_FLOW ->
                      _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
                  | UL_BLOCK ->
                      _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
                  | UL_ACCFER ->
                      let _ = _menhir_action_10 () in
                      _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let modele =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_modele v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 84 "Parser.mly"
  

# 1099 "Parser.ml"
