(****** Algorithmes combinatoires et listes ********)


(*** Code binaires de Gray ***)

(*CONTRAT
Fonction qui génère un code de Gray
Paramètre n : la taille du code
Resultat : le code sous forme de int list list
*)


let rec gray_code n = 
  if n = 0 then [[]]
           else (List.map (fun e -> 0::e) (gray_code (n-1)))@(List.map (fun e -> 1::e) (List.rev(gray_code (n-1))))

(* TESTS *)
let%test _ = gray_code 0 = [[]]
let%test _ = gray_code 1 = [[0]; [1]]
let%test _ = gray_code 2=  [[0; 0]; [0; 1]; [1; 1]; [1; 0]]
let%test _ = gray_code 3 = [[0; 0; 0]; [0; 0; 1]; [0; 1; 1]; [0; 1; 0]; [1; 1; 0]; [1; 1; 1]; [1; 0; 1];
 [1; 0; 0]]
 let%test _ = gray_code 4 = [[0; 0; 0; 0]; [0; 0; 0; 1]; [0; 0; 1; 1]; [0; 0; 1; 0]; [0; 1; 1; 0];
  [0; 1; 1; 1]; [0; 1; 0; 1]; [0; 1; 0; 0]; [1; 1; 0; 0]; [1; 1; 0; 1];
  [1; 1; 1; 1]; [1; 1; 1; 0]; [1; 0; 1; 0]; [1; 0; 1; 1]; [1; 0; 0; 1];
  [1; 0; 0; 0]]


(*** Combinaisons d'une liste ***)

(* CONTRAT 
Fonction qui genère les combinaisons de k éléments choisis dans une liste l 
Paramètre k : nombre d'éléments choisi
Paramètre l : liste dans laquelle on va chercher les combinaisons
Resultat : la liste des différentes combinaisons de k éléments choisis dans
           la liste sous forme de int list list
*)
let rec combinaison k l = 
  match k,l with 
  | 0, _ -> [[]]
  | _, [] -> []
  | _, t::q -> List.map (fun li -> t::li) (combinaison (k-1) q) @ (combinaison k q)

(* TESTS *)
let%test _ = combinaison 1 [] = []
let%test _ = combinaison 0 [1; 2; 3; 4] = [[]]
let%test _ = combinaison 1 [1; 2; 3; 4] = [[1]; [2]; [3]; [4]]
let%test _ = combinaison 2 [1; 2; 3; 4] = [[1; 2]; [1; 3]; [1; 4]; [2; 3]; [2; 4]; [3; 4]]
let%test _ = combinaison 3 [1; 2; 3; 4] = [[1; 2; 3]; [1; 2; 4]; [1; 3; 4]; [2; 3; 4]]


(*** Permutations d'une liste ***)

(* CONTRAT
Fonction prend en paramètre un élément e et une liste l et qui insére e à toutes les possitions possibles dans l
Pamaètre e : ('a) l'élément à insérer
Paramètre l : ('a list) la liste initiale dans laquelle insérer e
Reesultat : la liste des listes avec toutes les insertions possible de e dans l
*)

let rec insertion e l = 
  match l with 
  | [] -> [[e]]
  | t::q -> (e::l)::(List.map (fun li -> t::li) (insertion e q))


(* TESTS *)
let%test _ = insertion 0 [1;2] = [[0;1;2];[1;0;2];[1;2;0]]
let%test _ = insertion 0 [] = [[0]]
let%test _ = insertion 3 [1;2] = [[3;1;2];[1;3;2];[1;2;3]]
let%test _ = insertion 3 [] = [[3]]
let%test _ = insertion 5 [12;54;0;3;78] =
[[5; 12; 54; 0; 3; 78]; [12; 5; 54; 0; 3; 78]; [12; 54; 5; 0; 3; 78];
 [12; 54; 0; 5; 3; 78]; [12; 54; 0; 3; 5; 78]; [12; 54; 0; 3; 78; 5]]
 let%test _ = insertion 'x' ['a';'b';'c']=
 [['x'; 'a'; 'b'; 'c']; ['a'; 'x'; 'b'; 'c']; ['a'; 'b'; 'x'; 'c'];
  ['a'; 'b'; 'c'; 'x']]


(* CONTRAT
Fonction qui renvoie la liste des permutations d'une liste
Paramètre l : une liste
Résultat : la liste des permutatiions de l (toutes différentes si les élements de l sont différents deux à deux 
*)

(* Avec un match
let rec permutations l = 
  match l with 
  | [] -> [[]]
  | t::q -> List.flatten(List.map (insertion t) (permutations q))
*)

(* Avec un itérateur*)
let permutations l = List.fold_right (fun t pq -> List.flatten(List.map (insertion t) pq)) l [[]]

(* TESTS *)
let l1 = permutations [1;2;3]
let%test _ = List.length l1 = 6
let%test _ = List.mem [1; 2; 3] l1 
let%test _ = List.mem [2; 1; 3] l1 
let%test _ = List.mem [2; 3; 1] l1 
let%test _ = List.mem [1; 3; 2] l1 
let%test _ = List.mem [3; 1; 2] l1 
let%test _ = List.mem [3; 2; 1] l1 
let%test _ = permutations [] =[[]]
let l2 = permutations ['a';'b']
let%test _ = List.length l2 = 2
let%test _ = List.mem ['a';'b'] l2 
let%test _ = List.mem ['b';'a'] l2 



(*** Partition d'un entier ***)

(* partition int -> int list
Fonction qui calcule toutes les partitions possibles d'un entier n
Paramètre n : un entier dont on veut calculer les partitions
Préconditions : n >0
Retour : les partitions de n
*)

let rec partition n =
  let partitions nb k = 

  if n = 0 then []
           else List.map (fun e -> 1::e) (partition (n-1)) @ [[n]] 
  

(* TEST *)
let%test _ = partition 1 = [[1]]
let%test _ = partition 2 = [[1;1];[2]]
let%test _ = partition 3 = [[1; 1; 1]; [1; 2]; [3]]
let%test _ = partition 4 = [[1; 1; 1; 1]; [1; 1; 2]; [1; 3]; [2; 2]; [4]]

