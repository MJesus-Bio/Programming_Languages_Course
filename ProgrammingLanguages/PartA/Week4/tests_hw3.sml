use "assignments.sml";

(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

(* FN 1 *)

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test1_1 = only_capitals ["a", "b", "c"] = []

val test1_2 = only_capitals ["a", "B", "c", "D"] = ["B", "D"]

val test1_3 = only_capitals ["Mat", "mate", "aLp", "RRat"] = ["Mat", "RRat"]						       

(* =================================================== *)
(* FN 2 *)							 

val test2 = longest_string1 ["A","bc","C"] = "bc"

val test2_1 = longest_string1 ["aa","bb","cc"] = "aa"

val test2_2 = longest_string1 ["ab", "bcd", "efgh", "t"] = "efgh"						     

(* =================================================== *)
(* FN 3 *)						 

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test3_1 = longest_string2 ["aa","bb","cc"] = "cc"

val test3_2 = longest_string2 ["ab", "bcd", "efgh", "t"] = "efgh"						 

(* =================================================== *)
(* FN 4 *)		 

val test4a = longest_string3 ["Aa","bc","C"] = "Aa"

val test4b = longest_string4 ["Aa","bc","C"] = "bc"

(* =================================================== *)
(* FN 5 *)					 

val test5 = longest_capitalized ["A","bc","C"] = "A"

val test5_1 = longest_capitalized ["Aa", "bb", "c"] = "Aa"

val test5_2 = longest_capitalized ["Cc", "Ddddd", "Fffff", "gGggggggg"] = "Ddddd"							  

(* =================================================== *)
(* FN 6 *)					     

val test6 = rev_string "abc" = "cba"

val test6_1 = rev_string "Campora" = "aropmaC"

val test6_2 = rev_string "neuqueN" = "Neuquen"					 

(* =================================================== *)
(* FN 7 *)		   

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test7_1 = first_answer (fn x => if x > 1 then SOME x else NONE) [1,2,3] = 2

val test7_2 = ((first_answer (fn x => NONE) [1,2,5,6]; false)
	       handle NoAnswer => true)

val test7_3 = ((first_answer (fn x => if x > 7 then SOME x else NONE)
			     [1,2,5,6]; false)
	       handle NoAnswer => true)

val test7_4 = first_answer (fn x => SOME (String.size x)) ["abc", "de"] = 3		  

(* =================================================== *)
(* FN 8 *)

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE)
			[2,3,4,5,6,7] = NONE

val test8_1 = all_answers (fn x => if x > 1 then SOME [x] else NONE)
			  [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]

val test8_2 = all_answers (fn x => if x > 1 then SOME [x] else NONE)
			[1,3,4,5,6,7] = NONE					       

(* =================================================== *)
(* FN 9 *)									       

val test9a = count_wildcards Wildcard = 1

val test9a_1 = count_wildcards (ConstructorP ("alf",
					      (TupleP [UnitP,
						       Wildcard,
						       Wildcard])))
			       = 2

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9b_1 = count_wild_and_variable_lengths Wildcard = 1

val test9b_2 = count_wild_and_variable_lengths
		   (TupleP [Variable("abc"), Wildcard,
			    ConstructorP ("abc", Variable("f"))]) = 5							      
								   
val test9c = count_some_var ("x", Variable("x")) = 1

val test9c_1 = count_some_var ("d", Variable("x")) = 0					       

(* =================================================== *)
(* FN 10 *)

val test10 = check_pat (Variable("x")) = true

val test10_1 = check_pat (TupleP [Variable("x"), Variable("x")]) = false

val test10_2 = check_pat (TupleP [Variable("x"),
				  Wildcard,
				  Variable("y"),
				  ConstructorP("x", Wildcard)]) = true

val test10_3 = check_pat (ConstructorP ("egg", ConstructorP ("egg", ConstP 4)))
	       = true

val test10_4 = check_pat (TupleP[ConstP 17,Wildcard,ConstP 4,ConstructorP ("egg",ConstP 4),ConstructorP ("egg",ConstructorP ("egg",ConstP 4))]) = true		     

(* =================================================== *)
(* FN 11 *)					     

val test11 = match (Const(1), UnitP) = NONE

val test11_1 = match (Const(1), ConstP(1)) = SOME []

val test11_2 = match (Const(2), ConstP(8)) = NONE

val test11_3 = match (Unit, Wildcard) = SOME []

val test11_4 = match (Unit, UnitP) = SOME []

val test11_5 = match (Unit, Variable("pet")) = SOME [("pet", Unit)]

val test11_6 = match (Tuple [Unit, Const(2)],
		      TupleP [UnitP, Wildcard]) = SOME []

val test11_7 = match (Tuple [Unit, Const(2)],
		      TupleP [UnitP, ConstP(3)]) = NONE

val test11_8 = match (Tuple [Unit, Const(2)],
		      TupleP [Variable("ss"), Wildcard]) = SOME [("ss", Unit)]

val test11_9 = match (Tuple [Unit, Const(2)],
		      TupleP [Variable("ss"), Variable("ff")])
	       = SOME [("ss", Unit), ("ff", Const(2))]

val test11_10 = match (Constructor("f",Unit),
		       ConstructorP("f",Wildcard)) = SOME []

val test11_11 = match (Constructor("f",Unit),
		       ConstructorP("g",Wildcard)) = NONE

val test11_12 = match (Constructor("f",Unit),
		       ConstructorP("f",ConstP(5))) = NONE

val test11_13 = match (Tuple[Const 17,Unit,Const 4,Constructor ("egg",Const 4),Constructor ("egg",Constructor ("egg",Const 4))],TupleP[Wildcard,Wildcard]) = NONE							  

(* =================================================== *)
(* FN 12 *)					   

val test12 = first_match Unit [UnitP] = SOME []

val test12_1 = first_match (Const(2)) [ConstP(3), Wildcard] = SOME []

val test12_2 = first_match (Const(2)) [Variable("ss"), ConstP(2)]
	       = SOME [("ss",Const(2))]

val test12_3 = first_match (Const(2)) [UnitP, ConstP(4)] = NONE		      

