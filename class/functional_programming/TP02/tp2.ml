(******* TRIS ******)

(*  Tri par insertion **)

(*CONTRAT
Fonction qui ajoute un élément dans une liste triée, selon un ordre donné
Type : ('a->'a->bool)->'a->'a list -> 'a list
Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
Paramètre : elt, l'élement à ajouter
Paramètre : l, la liste triée dans laquelle ajouter elt
Résultat : une liste triée avec les éléments de l, plus elt
*)

let rec insert ordre elt l = 
  match l with 
  |[] -> [elt]
  |t::q -> if (ordre elt t) then elt::l
                            else t::(insert ordre elt q)

(* TESTS *)
let%test _ = insert (fun x y -> x<y) 3 []=[3]
let%test _ = insert (fun x y -> x<y) 3 [2;4;5]=[2;3;4;5]
let%test _ = insert (fun x y -> x > y) 6 [3;2;1]=[6;3;2;1]



(*CONTRAT
Fonction qui trie une liste, selon un ordre donné
Type : ('a->'a->bool)->'a list -> 'a list
Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
Paramètre : l, la liste à trier
Résultat : une liste triée avec les éléments de l
*)

(* Première version avec un match *)
(*
  let rec tri_insertion ordre l = 
  match l with 
  |[] -> []
  |t::q -> insert ordre t (tri_insertion ordre q) 
*)

(* Version avec un itérateur *)
  let tri_insertion ordre l = List.fold_right (insert ordre) l []

(* TESTS *)
let%test _ = tri_insertion (fun x y -> x<y) [] =[]
let%test _ = tri_insertion (fun x y -> x<y) [4;2;4;3;1] =[1;2;3;4;4]
let%test _ = tri_insertion (fun x y -> x > y) [4;7;2;4;1;2;2;7]=[7;7;4;4;2;2;2;1]



(*  Tri fusion **)

(* CONTRAT
Fonction qui décompose une liste en deux listes de tailles égales à plus ou moins un élément
Paramètre : l, la liste à couper en deux
Retour : deux listes
*)

let rec scinde l =
  match l with 
  |[] -> ([], [])
  |[_] -> (l, [])
  |t1::t2::q -> let (l1, l2) = scinde q in (t1::l1, t2::l2)


(* TESTS *)
(* Peuvent être modifiés selon l'algorithme choisi *)
let%test _ = scinde [1;2;3;4] = ([1;3],[2;4])
let%test _ = scinde [1;2;3] = ([1;3],[2])
let%test _ = scinde [1] = ([1],[])
let%test _ = scinde [] = ([],[])



(* Fusionne deux listes triées pour en faire une seule triée
Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
Paramètre : l1 et l2, les deux listes triées
Résultat : une liste triée avec les éléments de l1 et l2
*)

let rec fusionne ordre l1 l2 =
  match (l1, l2) with 
  |([], _) -> l2
  |(_, []) -> l1
  |(t1::q1, t2::q2) -> if (ordre t1 t2) then (t1::(fusionne ordre q1 l2))
                                        else (t2::(fusionne ordre l1 q2))

(*TESTS*)
let%test _ = fusionne (fun x y -> x<y) [1;2;4;5;6] [3;4] = [1;2;3;4;4;5;6]
let%test _ = fusionne (fun x y -> x<y) [1;2;4] [3;4] = [1;2;3;4;4]
let%test _ = fusionne (fun x y -> x<y) [1;2;4] [3;4;8;9;10] = [1;2;3;4;4;8;9;10]
let%test _ = fusionne (fun x y -> x<y) [] [] = []
let%test _ = fusionne (fun x y -> x<y) [1] [] = [1]
let%test _ = fusionne (fun x y -> x<y) [] [1] = [1]
let%test _ = fusionne (fun x y -> x<y) [1] [2] = [1;2]
let%test _ = fusionne (fun x y -> x>y) [1] [2] = [2;1]

(* CONTRAT
Fonction qui trie une liste, selon un ordre donné
Type : ('a->'a->bool)->'a list -> 'a list
Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
Paramètre : l, la liste à trier
Résultat : une liste triée avec les éléments de l
*)

let rec tri_fusion ordre l =
  match l with 
  | [] -> []
  | [_] -> l
  | _ -> let (l1, l2) = scinde l in 
         fusionne ordre (tri_fusion ordre l1) (tri_fusion ordre l2)


(* TESTS *)
let%test _ = tri_fusion (fun x y -> x<y) [] =[]
let%test _ = tri_fusion (fun x y -> x<y) [4;2;4;3;1] =[1;2;3;4;4]
let%test _ = tri_fusion (fun x y -> x > y) [4;7;2;4;1;2;2;7]=[7;7;4;4;2;2;2;1]

(*  Parsing du fichier *)
open Lexing

(* Affiche un quadruplet composé 
- du sexe des personnes ayant reçu ce prénom : 1 pour les hommes, 2 pour les femmes
- du prénom
- de l'année
- du nombre de fois où ce prénom a été donné cette année là
*)
let print_stat (sexe,nom,annee,nb) =
  Printf.eprintf "%s,%s,%d,%d%!\n" (if (sexe=1) then "M" else "F") nom annee nb

(* Analyse le fichier nat2016.txt (stratistique des prénoms entre 1900 et 2016) 
 et construit une liste de quadruplet (sexe,prénom,année,nombre d'affectation)
*)
let listStat = 
  let input = open_in "/mnt/n7fs/ens/tp_guivarch/pf/nat2016.txt" in 
  let filebuf = Lexing.from_channel input in
  Parser.main Lexer.token filebuf
  

(* Analyse le fichier nathomme2016.txt (stratistique des prénoms d'homme commençant par un A ou un B entre 1900 et 2016) 
 et construit une liste de quadruplets (sexe,prénom,année,nombre d'affectations)
*)
let listStatHomme = 
  let input = open_in "/mnt/n7fs/ens/tp_guivarch/pf/nathomme2016.txt" in
  let filebuf = Lexing.from_channel input in
  Parser.main Lexer.token filebuf
  

(*  Les contrats et les tests des fonctions suivantes sont à écrire *)

(* Exercice 7 *)

(* CONTRAT
Fonction booléenne qui permet de comparer le nombre d'affectation d'un prénom entre deux quadruplets
(sexe,prénom,année,nombre d'affectations)
Type : (Int*String*Int*Int) -> (Int*String*Int*Int) -> bool
Paramètre : q1, premier quadruplet de la comparaison
Paramètre : q2, deuxième quadruplet de la comparaison
Résultat : le booléen résultat de la comparaison
*)

let ordreAffectation q1 q2 = 
  let (_, _, _, n1) = q1 in
  let (_, _, _, n2) = q2 in
  n1 > n2

(* CONTRAT
Fonction qui trie (avec la fonction créée seule) la liste de quadruplet (sexe,prénom,année,nombre d'affectations)
selon le nombre d'affectations
Résultat : une liste triée selon le nombre d'affectation avec les éléments de la liste de quadruplet
*)

(*
let triListePrenomMine = tri_fusion ordreAffectation listStat
=> mène à un StackOverflow
*)

(* CONTRAT
Fonction booléenne qui permet de comparer le nombre d'affectation d'un prénom entre deux quadruplets
(sexe,prénom,année,nombre d'affectations)
Type : (Int*String*Int*Int) -> (Int*String*Int*Int) -> int
Paramètre : q1, premier quadruplet de la comparaison
Paramètre : q2, deuxième quadruplet de la comparaison
Résultat : un entier représentant le résultat de la comparaison
*)

let ordreAffectationOcaml q1 q2 = 
  let (_, _, _, n1) = q1 in
  let (_, _, _, n2) = q2 in

  if n1 > n2 then (-1)
  else if n1 < n2 then 1
  else 0

(* CONTRAT
Fonction qui trie (avec la fonction de Ocaml) la liste de quadruplet (sexe,prénom,année,nombre d'affectations)
selon le nombre d'affectations
Résultat : une liste triée selon le nombre d'affectation avec les éléments de la liste de quadruplet
*)

let triListePrenomOcaml = List.sort ordreAffectationOcaml listStat

(* Affichage de la liste triée *)
(*
let rec printListe l = 
  match l with
  | [] -> Printf.printf "\n"
  | t::q -> print_stat t;
            printListe q
let affichageListe = printListe triListePrenomOcaml 
*)

(* Exercice 8 : Tri_fusion Terminale *)

(* CONTRAT
Fonction qui décompose une liste en deux listes de tailles égales à plus ou moins un élément
Paramètre : l, la liste à couper en deux
Paramètre : n, la taille de la liste
Retour : deux listes
*)

(* Non Abouti *)
(*
let scindeTerminale l size =
  let rec scinde_aux l i = 
    match l with 
    | [] -> ([], [])
    | t::q -> let (l1, l2) = scinde_aux q i+1 in
              if (i < size/2) then (t::l1, [])
                              else (l1, t::l2)
  in
  scinde_aux l 0  

(* TESTS *)
(* Peuvent être modifiés selon l'algorithme choisi *)
let%test _ = scindeTerminale [1;2;3;4] = ([1;3],[2;4])
let%test _ = scindeTerminale [1;2;3] = ([1;3],[2])
let%test _ = scindeTerminale [1] = ([1],[])
let%test _ = scindeTerminale [] = ([],[])
*)
