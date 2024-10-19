open Util
open Mem

(* get_assoc: int -> (int * char) list -> char -> char
 * Permet d'obtenir la valeur associée à la clef e dans une liste associative l 
 * Retourne def si la clef e n''est pas présente dans la liste l
 *
 * Paramètres :
 * e : int, clef dont nous cherchons la valeur
 * l : (int,char) list, liste associative où nous allons mener nos recherches
 * def : char, valeur par defaut que nous allons retourner si la clef n'est 
 * pas dans la liste
 *  
 * Retour :
 * La valeur associée à la clef e dans la liste associative l
 *)

let get_assoc e l def = List.fold_right (fun (c, v) getq -> if (c=e) then v 
                                                                    else getq) l def

(* Exemple de liste associative *)
let listeAssociativeExemple = [(1, 'a'); (2, 'b'); (3, 'c')]

(* Tests unitaires *)
let%test _ = get_assoc 2 listeAssociativeExemple _0 = 'b'
let%test _ = get_assoc 5 listeAssociativeExemple _0 = _0

(* set_assoc : int -> (int * char) list -> char -> (int * char) list
 * Permet de changer la valeur associée à la clef e à x dans une liste associative l
 *
 * Paramètres : 
 * e : int, clef dont nous cherchons la valeur
 * l : (int,char) list, liste associative où nous allons mener nos recherches
 * x : char, la nouvelle valeur associée à la clef e si elle existe
 *
 * Retour : 
 * La liste associative modifiée
 *)
let rec set_assoc e l x = 
    match l with 
    | [] -> [(e, x)]
    | (c, v)::q -> if (c = e) then (c, x)::q
                            else (c, v)::(set_assoc e q x)

(* Tests unitaires *)
let%test _ = set_assoc 2 listeAssociativeExemple _0 = [(1, 'a'); (2, _0); (3, 'c')]
let%test _ = set_assoc 4 listeAssociativeExemple 'd' = [(1, 'a'); (2, 'b'); (3, 'c'); (4, 'd')]


module AssocMemory : Memory =
struct
    (* Type = liste qui associe des adresses (entiers) à des valeurs (caractères) *)
    type mem_type = (int * char) list

    (* Un type qui contient la mémoire + la taille de son bus d'adressage *)
    type mem = int * mem_type

    (* Nom de l'implémentation *)
    let name = "assoc"

    (* Taille du bus d'adressage *)
    let bussize (bs, _) = bs

    (* Taille maximale de la mémoire *)
    let size (bs, _) = pow2 bs

    (* Taille de la mémoire en mémoire *)
    let allocsize (bs, m) = 2 * (List.length m)

    (* Nombre de cases utilisées *)
    let busyness (bs, m) = List.fold_right (fun (c,v) bq -> if (v = _0) then bq
                                                                        else 1 + bq) m 0

    (* Construire une mémoire vide *)
    let clear bs = (bs, [])

    (* Lire une valeur *)
    let read (bs, m) addr = if (addr > (size (bs, m))) then raise OutOfBound
                                            else (get_assoc addr m _0)

    (* Écrire une valeur *)
    let write (bs, m) addr x = if (addr > (size (bs, m))) then raise OutOfBound
                                            else (bs, set_assoc addr m x)
end
