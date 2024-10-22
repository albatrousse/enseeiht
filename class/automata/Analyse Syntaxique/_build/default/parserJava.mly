%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

(* let nbrVariables = ref 0;; *)

let nbrFonctions = ref 0;;

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token IMPORT
%token <string> IDENT TYPEIDENT
%token INT FLOAT BOOL CHAR VOID STRING
%token ACCOUV ACCFER PAROUV PARFER CROOUV CROFER
%token PTVIRG VIRG
%token SI SINON TANTQUE RETOUR
/* Defini le type des donnees associees a l'unite lexicale */
%token <int> ENTIER
%token <float> FLOTTANT
%token <bool> BOOLEEN
%token <char> CARACTERE
%token <string> CHAINE
%token VIDE
%token NOUVEAU
%token ASSIGN
%token OPINF OPSUP OPINFEG OPSUPEG OPEG OPNONEG
%token OPPLUS OPMOINS OPOU
%token OPMULT OPMOD OPDIV OPET
%token OPNON
%token OPPT
/* Unite lexicale particuliere qui represente la fin du fichier */
%token FIN

/* Declarations des regles d'associative et de priorite pour les operateurs */
/* La priorite est croissante de haut en bas */
/* Associatif a droite */
%right ASSIGN /* Priorite la plus faible */
/* Non associatif */
%nonassoc OPINF OPSUP OPINFEG OPSUPEG OPEG OPNONEG
/* Associatif a gauche */
%left OPPLUS OPMOINS OPOU
%left OPMULT OPMOD OPDIV OPET
%right OPNON
%left OPPT PAROUV CROOUV /* Priorite la plus forte */

/* Type renvoye pour le nom terminal fichier */
%type <unit> fichier
%type <int> variables

/* Le non terminal fichier est l'axiome */
%start fichier

%% /* Regles de productions */

fichier : programme FIN { (print_endline "fichier : programme FIN");(print_string "Nombre de fonctions : ");(print_int !nbrFonctions);(print_newline()) }

programme : /* Lambda, mot vide */ { (nbrFonctions := 0); (print_endline "programme : /* Lambda, mot vide */") }
          | fonction programme { (nbrFonctions := !nbrFonctions + 1);(print_endline "programme : fonction programme") }

typeStruct : typeBase declTab { (print_endline "typeStruct : typeBase declTab") }

typeBase : INT { (print_endline "typeBase : INT") }
         | FLOAT { (print_endline "typeBase : FLOAT") }
         | BOOL { (print_endline "typeBase : BOOL") }
         | CHAR { (print_endline "typeBase : CHAR") }
         | STRING { (print_endline "typeBase : STRING") }
         | TYPEIDENT { (print_endline "typeBase : TYPEIDENT") }

declTab : /* Lambda, mot vide */ { (print_endline "declTab : /* Lambda, mot vide */") }
        | CROOUV CROFER { (print_endline "declTab : CROOUV CROFER") }

fonction : entete bloc  { (print_endline "fonction : entete bloc") }

entete : typeStruct IDENT PAROUV parsFormels PARFER { (print_endline "entete : typeStruct IDENT PAROUV parsFormels PARFER") }
       | VOID IDENT PAROUV parsFormels PARFER { (print_endline "entete : VOID IDENT PAROUV parsFormels PARFER") }

parsFormels : /* Lambda, mot vide */ { (print_endline "parsFormels : /* Lambda, mot vide */") }
            | typeStruct IDENT suiteParsFormels { (print_endline "parsFormels : typeStruct IDENT suiteParsFormels") }

suiteParsFormels : /* Lambda, mot vide */ { (print_endline "suiteParsFormels : /* Lambda, mot vide */") }
                 | VIRG typeStruct IDENT suiteParsFormels { (print_endline "suiteParsFormels : VIRG typeStruct IDENT suiteParsFormels") }

bloc : ACCOUV /* $1 */ variables /* $2 */ instructions /* $3 */ ACCFER /* $4 */
     {
	(print_endline "bloc : ACCOUV variables instructions ACCFER");
	(print_string "Nombre de variables = ");
	(print_int $2);
	(print_newline ())
	}

variables : /* Lambda, mot vide */
	  {
		(print_endline "variables : /* Lambda, mot vide */");
		0
		}
          | variable /* $1 */ variables /* $2 */
	  {
		(print_endline "variables : variable variables");
		($2 + 1)
		}

variable : typeStruct IDENT PTVIRG { (print_endline "variable : typeStruct IDENT PTVIRG") }

/* A FAIRE : Completer pour decrire une liste d'instructions eventuellement vide */
instructions : instruction instructions{ (print_endline "instructions : instruction") } 
				| /* Lambda, mot vide */ { (print_endline "instructions : /* Lambda, mot vide */") }

/* A FAIRE : Completer pour ajouter les autres formes d'instructions */
               instruction : expression PTVIRG { (print_endline "instruction : expression PTVIRG") }
                             | RETOUR expression PTVIRG  { (print_endline "instruction : RETURN expression PTVIRG") }
							 | SI PAROUV expression PARFER bloc { (print_endline "instruction : IF PAROUV expression PARFER bloc") }
							 | SI PAROUV expression PARFER bloc SINON bloc { (print_endline "instruction : IF PAROUV expression PARFER bloc ELSE bloc") }
							 | TANTQUE PAROUV expression PARFER bloc { (print_endline "instruction : WHILE PAROUV expression PARFER bloc") }

/* A FAIRE : Completer pour ajouter les autres formes d'expressions */
expression : ENTIER 			{ (print_endline "expression : ENTIER") }
			| FLOTTANT 			{ (print_endline "expression : FLOTTANT")}
			| CARACTERE			{ (print_endline "expression : CARACTERE")}
			| BOOLEEN			{ (print_endline "expression : BOOLEEN")}
			| VIDE				{ (print_endline "expression : VIDE")}
			| expression binaire expression 			{(print_endline "expression : expression binaire expression")}
			| unaires expression 						{(print_endline "expression : unaire expression")}
			| NOUVEAU IDENT PAROUV PARFER 				{(print_endline "expression : NOUVEAU IDENT PAROUV PARFER")}
			| NOUVEAU IDENT CROOUV expression CROFER 	{(print_endline "expression : NOUVEAU IDENT CROOUV expression CROFER")}
			| IDENT suffixes 							{(print_endline "expression : IDENT suffixes")}
			| PAROUV expression PARFER suffixes			{(print_endline "expression : PAROUV expression PARFER suffixes")}


unaires : unaire unaires 			{ (print_endline "unaires : unaire unaires") } 
		| | /* Lambda, mot vide */ 	{ (print_endline "unaire : /* Lambda, mot vide */") }

unaire : PAROUV typeBase PARFER { (print_endline "unaire : PAROUV typeBase PARFER")}
		| OPPLUS				{ (print_endline "unaire : OPPLUS")}
		| OPMOINS				{ (print_endline "unaire : OPMOINS")}
		| OPNON					{ (print_endline "unaire : OPNON")}

binaire : ASSIGN                { (print_endline "binaire : ASSIGN")}
		| OPEG					{ (print_endline "binaire : OPEG")}
		| OPPT					{ (print_endline "binaire : OPPT")}
		| OPPLUS				{ (print_endline "binaire : OPPLUS")}
		| OPMOINS				{ (print_endline "binaire : OPMOINS")}
		| OPMULT				{ (print_endline "binaire : OPMULT")}
		| OPDIV					{ (print_endline "binaire : OPDIV")}
		| OPMOD					{ (print_endline "binaire : OPMOD")}
		| OPOU					{ (print_endline "binaire : OPOU")}
		| OPET					{ (print_endline "binaire : OPET")}
		| OPEG					{ (print_endline "binaire : OPEG")}
		| OPNONEG				{ (print_endline "binaire : OPNONEG")}
		| OPINF					{ (print_endline "binaire : OPINF")}
		| OPINFEG				{ (print_endline "binaire : OPINFEG")}
		| OPSUP					{ (print_endline "binaire : OPSUP")}
		| OPSUPEG				{ (print_endline "binaire : OPSUPEG")}

suffixes : suffixe suffixes 				{ (print_endline "suffixes : suffixe suffixes")}
		 | /* Lambda, mot vide */			{ (print_endline "suffixes : /* Lambda, mot vide */")}

suffixe : CROOUV expression CROFER 						{ (print_endline "suffixe : CROOUV expression CROFER")}
		| PAROUV PARFER									{ (print_endline "suffixe : PAROUV PARFER")}
		| PAROUV expression virgexpressions PARFER		{ (print_endline "suffixe : PAROUV expression virgexpression PARFER")}

virgexpressions : VIRG expression virgexpressions		{ (print_endline "virgexpressions : VIRG expression virgexpressions")}
				| /* Lambda, mot vide */				{ (print_endline "virgexpressions : /* Lambda, mot vide */")}

%%
