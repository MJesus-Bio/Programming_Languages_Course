(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option (s, lst) = 
    let fun check_string (s, lst) =
	    case lst of
		[] => []
	      | str::str' => if same_string(s, str)
			     then str'
			     else str::check_string(s, str')
	val result = check_string (s, lst)
    in
	if result = lst then NONE else SOME result
    end

fun get_substitutions1 (lst, s) =
    case lst of
	[] => []
      | str::str' => case (all_except_option(s,str)) of
			   NONE => []@get_substitutions1 (str', s)
			 | SOME p => p@get_substitutions1 (str', s)


fun get_substitutions2 (lst, s) =
    let fun helper (lst, s, acc) =
	    case lst of
		[] => acc
	      | str::str' => case (all_except_option(s,str)) of
				 NONE => helper(str', s, acc)
			       | SOME p => helper(str', s, acc@p)
    in
	helper (lst, s, [])
    end


fun similar_names (lst, {first=f, middle=m, last=l}) =
    let val name = {first=f, middle=m, last=l}
	fun make_names (lst_of_subs) =
	    case lst_of_subs of
		[] => []
	      | sub::subs => {first=sub,
			       middle=m,
			       last=l}::make_names(subs)
    in
	name::make_names(get_substitutions2(lst,f))
    end
					   

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color (c) =
    case c of
	(Clubs, _) => Black
      | (Spades, _) => Black
      | _  => Red 


fun card_value (c) =
    case c of
	(_, Num x) => x
      | (_, Ace) => 11
      | _ => 10 


fun remove_card (cs, c, e) =
    case cs of
	[] => raise e
      | c'::cs' => if c = c'
		   then cs'
		   else c'::remove_card(cs', c, e)


fun all_same_color (cs) =
    case cs of
	[] => true
      | _::[] => true 
      | c1::c2::cs' => (card_color(c1) = card_color(c2)) andalso
		       all_same_color(c2::cs')


fun sum_cards (cs) =
    let fun sum_cards_tr (cs, acc) =
	    case cs of
		[] => acc
	      | c::cs' => sum_cards_tr(cs', acc+card_value(c))
    in
	sum_cards_tr (cs, 0)
    end


fun score (cs, goal) =
    let val sum = sum_cards (cs)
	val pre_score = if sum > goal
			then (sum - goal) * 3
			else (goal - sum)
    in
	if all_same_color (cs)
	then pre_score div 2
	else pre_score
    end


fun officiate (card_list, move_list, goal) =
    let fun game (card_list, move_list, held_cards) =
	    case move_list of
		[] => score(held_cards, goal)
	      | m::ms => (case m of
			      Discard x => game (card_list, ms,
						    remove_card(held_cards,
								x,
								IllegalMove))
				       | Draw => (case card_list of
						      [] => score(held_cards, goal)
						    | c::cs => if sum_cards(c::held_cards) > goal
							       then score (c::held_cards, goal)
							       else game (cs, ms, c::held_cards)))
    in
	game (card_list, move_list, [])
    end
						   

(* My solution to the first challenge problem abuses the fact that in
 a common game you can only find 4 aces, but I couldn't think of a function
 to generalize that to an arbitrary number of aces; I don't really like it
 as a result *)
fun sum_cards_challenge (cs) =
    let fun sum_cards_tr (cs, acc, n_aces) =
	    case cs of
		[] => (acc, n_aces)
	      | c::cs' => (case c of
			       (_,Ace) => sum_cards_tr(cs',acc,n_aces+1)
			     | _ => sum_cards_tr(cs', acc+card_value(c),n_aces))
	val (sum, n_aces) = sum_cards_tr (cs, 0, 0)	
    in
	if n_aces = 0
	then [sum]
	else if n_aces = 1
	then [sum, sum+1, sum+11]
	else if n_aces = 2
	then [sum, sum+2, sum+12, sum+22]
	else if n_aces = 3
	then [sum, sum+3, sum+13, sum+23, sum+33]
	else [sum, sum+4, sum+14, sum+24, sum+34, sum+44]
    end		 

		 
fun score_challenge (cs, goal) =
    let val sum = sum_cards_challenge (cs)
	val n = if all_same_color (cs) then 2 else 1
	fun get_score (lst_sums) =
	case lst_sums of    
	    [] => []
	  | sum::sums => if sum > goal
			 then (((sum - goal) * 3)div n)::get_score(sums)
			 else ((goal-sum) div n)::get_score(sums)
	fun get_min (lst) =
	    case lst of
		[] => raise List.Empty
	      | x::[] => x
	      | x::y::xs => if x < y then get_min(x::xs) else get_min(y::xs) 
    in
	get_min(get_score(sum))
    end

fun officiate_challenge (card_list, move_list, goal) =
    let fun game (card_list, move_list, goal, held_cards) =
	    case move_list of
		[] => score_challenge(held_cards, goal)
	      | m::ms => (case m of
			      Discard x => game (card_list, ms, goal,
						    remove_card(held_cards,
								x,
								IllegalMove))
				       | Draw => (case card_list of
						      [] => score_challenge(held_cards, goal)
						    | c::cs => if sum_cards(c::held_cards) > goal
							       then score_challenge (c::held_cards, goal)
							       else game (cs, ms, goal, c::held_cards)))
    in
	game (card_list, move_list, goal, [])
    end
		       

(* Works for some cases, it has bugs in others, but I'm tired of working on
it and want to advance to the next week, so here is my partial solution *)
fun careful_player (cs, goal) =
    let fun check_if_zero (c, h::hs, ctrl) =
	    if h::hs = ctrl
	    then NONE
	    else if score(c::hs, goal) = 0
	    then SOME h
	    else check_if_zero (c, hs@[h], ctrl@[h])

	fun simulate_play (c::cs', held, move_list) =
	    case held of
		[] => simulate_play (cs', c::held, Draw::move_list)
	      | _ => (case check_if_zero(c, held, []) of
			      NONE =>  (if (goal - sum_cards(held) > 10)
					then simulate_play (cs', c::held, Draw::move_list)
					else move_list)
			    | SOME disc => (if score(held, goal) = 0
					    then move_list	 
					    else move_list@[Discard disc, Draw]))
    in
	simulate_play (cs, [], [])
    end
