(*  Exercice à rendre **)
(*
  pgcd : int -> int -> int
  calcule le pgcd entre deux entiers strictement positifs
  Parametre a > 0 : int le premier entier
  Parametre b > 0 : int le deuxieme entier
  Resultat : int le pgcd entre a et b
  Les préconditions sur a et b peuvent être levées à l'aide d'une fonction locale
*)

let pgcd a b =
  let rec pgcd_rec a b = 
    if (a = b) then a
    else if (a > b) then (pgcd_rec (a-b) b)
    else (pgcd_rec a (b-a))
  in pgcd_rec (abs a) (abs b)

let%test "egalite positif" = pgcd 2 2 = 2
let%test "a > b positif" = pgcd 34 12 = 2
let%test "a < b positif" = pgcd 12 34 = 2
let%test "egalite negatif" = pgcd (-2) (-2) = 2
let%test "a < b negatif" = pgcd (-34) (-12) = 2
let%test "a > b negatif" = pgcd (-12) (-34) = 2
let%test "egalite positif negatif" = pgcd (-2) 2 = 2
let%test "egalite negatif positif" = pgcd 2 (-2) = 2
let%test "a < b negatif positif" = pgcd (-12) 34 = 2
let%test "a > b positif negatif" = pgcd 12 (-34) = 2