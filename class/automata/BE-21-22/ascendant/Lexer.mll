{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Parser 
  exception LexicalError

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule lexer = parse
(* Espace, tabulation, passage a ligne, etc : consommes par l'analyse lexicale *)
  | ['\n' '\t' ' ']+					{ (lexer lexbuf) }
(* Commentaires consommes par l'analyse lexicale *)
  | commentaire						{ (lexer lexbuf) }
(* Structures des mots clés *)
  | "block"         {UL_BLOCK}
  | "{"							{ UL_ACCOUV }
  | "}"							{ UL_ACCFER }
  | "("             { UL_PAROUV }
  | ")"             { UL_PARFER }
  | "["							{ UL_CROOUV }
  | "]"							{ UL_CROFER }
  | ","             { UL_VIRG }
  | ":"             { UL_DXPT }
  | ";"             { UL_PTVIRG }
  | "."             { UL_PT }
  | "model"					{ UL_MODEL }
  | "system"        { UL_SYS }
  | "flow"          { UL_FLOW }
  | "from"          { UL_FROM }
  | "to"            { UL_TO }
  | "in"            { UL_IN }
  | "out"           { UL_OUT }
  | "int"           { UL_INT }
  | "float"         { UL_FLOAT }
  | "boolean"       { UL_BOOL }
  | eof							{ UL_FIN }
(* Structures des terminaux complexes *)
  | (['1' - '9'] chiffre*) as texte   { (UL_ENTIER (int_of_string texte)) }
  | (majuscule alphabet*) as texte   { (UL_IDENT texte)}
  | (minuscule alphabet*) as texte   { (UL_PORT texte)}
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); raise LexicalError }

{
  
}
