%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_MODEL
%token UL_BLOCK
%token UL_SYS
%token UL_FLOW
%token UL_ACCOUV UL_ACCFER UL_PAROUV UL_PARFER UL_CROOUV UL_CROFER
%token UL_FROM UL_TO
%token UL_IN UL_OUT
%token UL_PTVIRG UL_VIRG UL_PT UL_DXPT
%token UL_INT UL_FLOAT UL_BOOL

/* Defini le type des donnees associees a l'unite lexicale */

%token <int> UL_ENTIER
%token <string> UL_IDENT
%token <string> UL_PORT
/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> modele

/* Le non terminal document est l'axiome */
%start modele

%% /* Regles de productions */

/*à modifier*/
modele : UL_MODEL UL_IDENT UL_ACCOUV elements
UL_ACCFER UL_FIN { (print_endline "modele : UL_MODEL IDENT { ... } UL_FIN ") }

elements : element elements {print_endline "elements : element elements"}
         | {print_endline "elements : vide"}

element : bloc {print_endline "element : bloc"}
        | systeme {print_endline "element : systeme"}
        | flot {print_endline "element : flow"}

bloc : UL_BLOCK UL_IDENT parametres UL_PTVIRG {print_endline "bloc : UL_BLOCK UL_IDENT parametres UL_PTVIRG"}

systeme : UL_SYS UL_IDENT parametres UL_ACCOUV elements UL_ACCFER {print_endline "systeme : UL_SYS UL_IDENT parametres UL_ACCOUV elements UL_ACCFER"}

parametres :UL_PAROUV virguleport UL_PARFER {print_endline "parametres : UL_PAROUV virguleport UL_PARFER"}

virguleport : port UL_VIRG virguleport {print_endline "virguleport : port UL_VIRG virguleport"}
            | port {print_endline "virguleport : port"}

port : UL_PORT UL_DXPT UL_IN ty {print_endline "port : UL_PORT UL_DXPT UL_IN TYPE"}
     | UL_PORT UL_DXPT UL_OUT ty {print_endline "port : UL_PORT UL_DXPT UL_OUT TYPE"}

ty : UL_INT {print_endline "type : UL_INT"}
       | UL_FLOAT {print_endline "type : UL_FLOAT"}
       | UL_BOOL {print_endline "type : UL_BOOL"}
       | UL_INT UL_CROOUV entier UL_CROFER {print_endline "type : UL_INT UL_CROOUV UL_ENTIER UL_CROFER"}
        | UL_FLOAT UL_CROOUV entier UL_CROFER {print_endline "type : UL_FLOAT UL_CROOUV UL_ENTIER UL_CROFER"}
        | UL_BOOL UL_CROOUV entier UL_CROFER {print_endline "type : UL_BOOL UL_CROOUV UL_ENTIER UL_CROFER"}


entier : UL_ENTIER {print_endline "entier : UL_ENTIER"}
        | UL_ENTIER UL_VIRG entier {print_endline "entier : UL_ENTIER UL_VIRG entier"}

flot : UL_FLOW UL_PORT UL_FROM UL_PORT UL_TO UL_PTVIRG {print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_PORT UL_TO UL_PTVIRG"}
       | UL_FLOW UL_PORT UL_FROM UL_IDENT UL_PT UL_PORT UL_TO UL_PTVIRG {print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_IDENT UL_PT UL_PORT UL_TO UL_PTVIRG"}
       | UL_FLOW UL_PORT UL_FROM UL_IDENT UL_PT UL_PORT UL_TO boucle UL_PTVIRG {print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_IDENT UL_PT UL_PORT UL_TO boucle UL_PTVIRG"}
       | UL_FLOW UL_PORT UL_FROM UL_PORT UL_TO boucle UL_PTVIRG {print_endline "flot : UL_FLOW UL_PORT UL_FROM UL_PORT UL_TO boucle UL_PTVIRG"}


boucle : UL_PORT UL_VIRG boucle {print_endline "boucle : UL_PORT UL_VIRG boucle"}
        | UL_IDENT UL_PT UL_PORT UL_VIRG boucle {print_endline "boucle : UL_IDENT UL_PT UL_PORT UL_VIRG boucle"}
        | UL_IDENT UL_PT UL_PORT {print_endline "boucle : UL_IDENT UL_PT UL_PORT"}
        | UL_PORT {print_endline "boucle : UL_PORT"}
    

%%
