
val p = 42 < 36;

(* Syntax: something1 (<) something2 *)
(* Type-checking: something1 and something2 have to be int, *)
(* gives back boolean. *)
(* Evaluation: produces true if something1 is less than something2, *)
(* false if something2 is greater or equal than something1. *)

val x = (3, (4, (5, 6))) (* int * (int * (int * int))) *)
val y = (#2x,        (#1x,#2(#2x)))
val y = ((4, (5,6)), (3,  (5,6)))  (* (int * (int * int)) * (int * (int * int))) *)
val ans = (#2y, 4)
val ans = ((3, (5,6)), 4)

fun list_product (xs : int list) =
    if null xs
    then 1
    else hd xs * list_product (tl xs)	     

			      









