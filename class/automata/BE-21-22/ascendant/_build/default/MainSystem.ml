open Parser

(* Fonction d'affichage des unités lexicales et des données qu'elles contiennent *)
let printToken t =
  (print_endline
     (match t with
       | UL_ACCOUV -> "{"
       | UL_ACCFER -> "}"
       | UL_CROOUV -> "["
       | UL_CROFER -> "]"
       | UL_VIRG -> ","
       | UL_ENTIER i -> "int(" ^ (string_of_int i) ^ ")"
       | UL_FLOAT -> "float"
       | UL_PORT n -> n
       | UL_BLOCK -> "block"
       | UL_PAROUV -> "("
       | UL_PARFER -> ")"
       | UL_PTVIRG -> ";"
       | UL_DXPT -> ":"
       | UL_PT -> "."
       | UL_SYS -> "system"
       | UL_FLOW -> "flow"
       | UL_IN -> "in"
       | UL_OUT -> "out"
       | UL_INT -> "int"
       | UL_BOOL -> "boolean"
       | UL_TO -> "to"
       | UL_FROM -> "from"
       | UL_MODEL -> "model"
       | UL_IDENT n -> n
       | UL_FIN -> "EOF"
));;

(* Analyse lexicale du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  let token = ref (Lexer.lexer lexbuf) in
  while ((!token) != UL_FIN) do
    (printToken (!token));
    (token := (Lexer.lexer lexbuf))
  done
else
  (print_endline "MainJSON fichier");;

(* Analyse lexicale, syntaxique et sémantique du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  (Parser.modele Lexer.lexer lexbuf)
else
  (print_endline "MainJSON fichier");;
