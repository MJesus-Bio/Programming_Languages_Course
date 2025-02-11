(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1 *)			       
val only_capitals = List.filter (fn x => Char.isUpper (String.sub (x, 0)))
				
(* 2 *)
val longest_string1 = List.foldl (fn (x, y) => if (String.size x > String.size y) then x else y) ""

(* 3 *)				 
val longest_string2 = List.foldl (fn (x, y) => if (String.size x >= String.size y) then x else y) ""

(* 4 *)				 
fun longest_string_helper f = List.foldl (fn (x,y) => if f (String.size x, String.size y) then x else y) ""

val longest_string3 = longest_string_helper (fn (x,y) => x > y)

val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

(* 5 *)					    
val longest_capitalized = longest_string3 o only_capitals

(* 6 *)						
val rev_string = String.implode o List.rev o String.explode

(* 7 *)						 
fun first_answer f lst =
    case lst of
	[] => raise NoAnswer
      | x::xs => case f x of
		     NONE => first_answer f xs
		   | SOME v => v  

(* 8 *)				   
fun all_answers f lst =
    let fun helper (lst, acc) =
	    case lst of
		[] => SOME acc
	      | x::xs => (case f x of
			      NONE => NONE
			    | SOME lst1 => helper (xs, acc@lst1))
    in
	helper (lst, [])
    end

(* 9 *)	
val count_wildcards = g (fn x => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn x => 1) String.size

fun count_some_var (s, p) = g (fn x => 0) (fn x => if x=s then 1 else 0) p				

(* 10 *)			      
fun check_pat p =
    let fun list_strings p =
	    case p of
		Variable s => [s]
	      | TupleP ps => List.foldl (fn (x,y) => list_strings(x)@y) [] ps
	      | ConstructorP(_,p) => list_strings p
	      | _ => []
	fun check_repeats s_lst =
	    case s_lst of
		[] => true
	      | s1::ss => not(List.exists (fn x => x = s1) ss)
			  andalso check_repeats ss
    in
	(check_repeats o list_strings) p
    end

(* 11 *)					    
fun match (v, p) =
    case (v,p) of
	(_, Wildcard) => SOME []
      | (_, Variable s) => SOME [(s, v)]
      | (Unit, UnitP) => SOME []
      | (Const(x), ConstP(x')) => if x=x'
				  then SOME []
				  else NONE
      | (Tuple(vs), TupleP(ps)) => if (List.length vs = List.length ps)
				   then all_answers match
						    (ListPair.zip (vs, ps))
				   else NONE
						    
      | (Constructor(s2,v),
	 ConstructorP(s1,p)) => if s1=s2
				then match(v,p)
				else NONE
      | _ => NONE 
	
(* 12 *)
fun first_match v ps =
    (SOME (first_answer (fn p => match(v,p)) ps))
    handle NoAnswer => NONE
