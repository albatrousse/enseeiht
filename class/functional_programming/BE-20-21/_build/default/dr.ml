(*  Module qui permet la décomposition et la recomposition de données **)
(*  Passage du type t1 vers une liste d'éléments de type t2 (décompose) **)
(*  et inversement (recopose).**)
module type DecomposeRecompose =
sig
  (*  Type de la donnée **)
  type mot
  (*  Type des symboles de l'alphabet de t1 **)
  type symbole

  val decompose : mot -> symbole list
  val recompose : symbole list -> mot
end

module DRString : DecomposeRecompose with type mot = string and type symbole = char = 
struct
  type mot = string
  type symbole = char
  let decompose mot =
    let rec decompose i accu =
      if i < 0 then accu
      else decompose (i-1) (mot.[i]::accu)
    in decompose (String.length mot - 1) []
  let recompose lc =
    List.fold_right (fun t q -> String.make 1 t ^ q) lc ""
end

let rec int_power base exp =
  if exp < 0 then failwith "negative exp"
            else if exp > 0 then base * (int_power base (exp-1))
            else 1

module DRNat : DecomposeRecompose with type mot = int and type symbole = int = 
struct
  type mot = int
  type symbole = int
  let decompose mot =
    let rec decompose_rec mot = 
    if (mot <= 9) then [mot]
                else (mot mod 10)::(decompose_rec (mot/10))
    in List.rev(decompose_rec mot)
  let recompose le =
    let rec aux le accu =
      match le with
      | [] -> 0
      | t::q -> t*(int_power 10 accu) + aux q (accu-1)
    in aux le ((List.length le) - 1)
end