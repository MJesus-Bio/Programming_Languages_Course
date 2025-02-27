use "assignments.sml";

(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

(* FN 1 *)

val test1 = all_except_option ("string", ["string"]) = SOME []

val test1_1 = all_except_option ("b", ["a","b","c","d"]) = SOME ["a","c","d"]

val test1_2 = all_except_option ("f", ["a","b","c","d"]) = NONE

(* ============================================================ *)							       
(* FN 2 *)

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []

val test2_1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]

val test2_2 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Elizabeth") = ["Betty"]

val test2_3 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"]															
								  
(* ============================================================ *)								  
(* FN 3 *)
														    

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []

val test3_1 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]

val test3_2 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Elizabeth") = ["Betty"]

val test3_3 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"]

(* ============================================================ *)
(* FN 4 *)														    

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test4_1 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Elizabeth", middle="W", last="Lopez"}) =
	    [{first="Elizabeth", last="Lopez", middle="W"}, {first="Betty", last="Lopez", middle="W"}]	

(* ============================================================ *)		
(* FN 5 *)
		
val test5 = card_color (Clubs, Num 2) = Black

val test5_1 = card_color (Spades, Ace) = Black

val test5_2 = card_color (Hearts, King) = Red

val test5_3 = card_color (Diamonds, Queen) = Red					      

(* ============================================================ *)
(* FN 6 *)					    

val test6 = card_value (Clubs, Num 2) = 2

val test6_1 = card_value (Hearts, Num 7) = 7

val test6_2 = card_value (Diamonds, Ace) = 11

val test6_3 = card_value (Spades, King) = 10

val test6_4 = card_value (Spades, Queen) = 10

val test6_5 = card_value (Spades, Jack) = 10					       

(* ============================================================ *)
(* FN 7 *)					      

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

(* val test7_1 = remove_card ([(Hearts, Ace), (Spades, Num 8)], (Hearts, King), IllegalMove) *)

val test7_2 = remove_card ([(Hearts, Ace), (Spades, Num 8), (Clubs, Queen)], (Spades, Num 8), IllegalMove) = [(Hearts, Ace), (Clubs, Queen)]												

(* ============================================================ *)
(* FN 8 *)								    

val test8 = all_same_color [(Hearts, Ace), (Diamonds, King)] = true

val test8_1 = all_same_color [(Clubs, Queen), (Spades, Num 3)] = true

val test8_2 = all_same_color [(Clubs, Queen), (Spades, Num 3), (Diamonds, Jack)] = false								     

(* ============================================================ *)
(* FN 9 *)								

val test9 = sum_cards [(Clubs, Num 2),(Hearts, Num 7)] = 9

val test9_1 = sum_cards [(Clubs, Queen),(Hearts, Num 7)] = 17

val test9_2 = sum_cards [(Clubs, Jack), (Diamonds, Ace)] = 21							       

(* ============================================================ *)							    
(* FN 10 *)
							       
val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test10_1 = score ([(Hearts, Num 8),(Clubs, Num 4)],10) = 6

val test10_2 = score ([(Hearts, Num 2),(Diamonds, Num 3)],10) = 2

val test10_3 = score ([(Clubs, Num 8),(Spades, Num 4)],10) = 3								    

(* ============================================================ *)							       
(* FN 11 *)
								 
val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test11_1 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                          [Draw,Draw,Draw,Draw,Draw],
                          42)
               = 3

val test11_2 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                           [Draw,Discard(Hearts,Jack)],
                           42);
		 false) 
		handle IllegalMove => true)

val test11_3 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                          [Draw,Draw,Draw,Draw],
                          42)
	       = 3

val test11_4 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                          [Draw,Draw,Discard(Spades,Ace),Draw,Draw,Draw],
                          42)
               = 4

val test11_5 = officiate ([(Clubs,Ace),(Spades,Ace),(Hearts,Num 8),(Spades,Ace)],
                          [Draw,Draw,Discard(Spades,Ace),Draw,Draw,Draw],
                          42)
               = 12		     

(* ============================================================ *)							    
(* FN 12 *)
							       
val test12 = score_challenge ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test12_1 = score_challenge ([(Hearts, Num 8),(Clubs, Num 4)],10) = 6

val test12_2 = score_challenge ([(Hearts, Num 2),(Diamonds, Num 3)],10) = 2

val test12_3 = score_challenge ([(Clubs, Num 8),(Spades, Num 4)],10) = 3

val test12_4 = score_challenge ([(Hearts, Ace),(Spades, Num 4)],10) = 5

val test12_5 = score_challenge ([(Hearts, Ace),(Spades, Num 2)],15) = 2

val test12_6 = officiate_challenge ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12_7 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                          [Draw,Draw,Draw,Draw,Draw],
                          42)
               = 3

val test12_8 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                          [Draw,Draw,Draw,Draw],
                          36)
	       = 1

(* ================================================== *)
(* FN 13 *)

val test13 = careful_player ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
			     42)
	     = [Draw, Draw, Draw]
             
(* val test13_1 = ((careful_player([(Clubs,Ace),(Spades,Ace),(Clubs,Ace)],
				42);
		 false) 
		handle IllegalMove => true) *)            
		   
val test13_2 = careful_player ([(Clubs,Num 9),(Spades,Num 2),(Hearts,Ace)],
			       20)
	       = [Draw, Draw, Discard (Spades,Num 2), Draw]		   
