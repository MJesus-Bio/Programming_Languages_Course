use "assignments.sml";

(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

(* FN 1 *)

val test1 = is_older ((1,2,3),(2,3,4)) = true

val test1_2 = is_older ((1998, 5, 3), (2000, 6, 8)) = true

val test1_3 = is_older ((1998,5,3), (1998,4,2)) = false

val test1_4 = is_older ((1998,1,3), (1998,4,2)) = true

val test1_5 = is_older ((1998,4,1), (1998,4,2)) = true

val test1_6 = is_older ((1998,4,2), (1998,4,2)) = false

(* ======================================================= *)
(* FN 2 *)						      

val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1 

val test2_1 = number_in_month ([(2012,4,28),(2013,12,1)],2) = 0

val test2_2 = number_in_month ([(2012,2,28),(2013,2,1),(1678,2,17)],2) = 3

val test2_3 = number_in_month ([(2012,4,28),(2013,12,1),(1746,3,28)],12) = 1									     

(* ======================================================= *)								
(* FN 3 *)
									       
val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test3_1 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,3,4]) = 2

val test3_2 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,6,7,8]) = 1

val test3_3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[11,7,5]) = 0

val test3_4 = number_in_months ([(2012,2,28),(2013,2,1),(2011,3,31),(2011,2,28)],[2,3,4]) = 2 												  
											       
(* ======================================================= *)											       
(* FN 4 *)
												
val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test4_1 = dates_in_month ([(2012,2,28),(2013,12,1)],12) = [(2013,12,1)]

val test4_2 = dates_in_month ([(2012,2,28),(2013,12,1)],5) = []

val test4_3 = dates_in_month ([(2012,2,28),(2013,12,1),(2005,2,4)],2) = [(2012,2,28),(2005,2,4)]  								 

(* ======================================================= *)
(* FN 5 *)
									    
val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)] 

val test5_1 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,12]) = [(2012,2,28),(2011,3,31),(2013,12,1)]

val test5_2 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,4,5]) = [(2012,2,28),(2011,4,28)]

val test5_3 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,5,6]) = [(2012,2,28)]

val test5_4 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[8,9,10]) = []												
(* ======================================================= *)						      
(* FN 6 *)
												 
val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test6_1 = get_nth (["hi", "there", "how", "are", "you"], 3) = "how"

val test6_2 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"								      

(* ======================================================= *)
(* FN 7 *)
								      
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test7_1 = date_to_string (2021, 4, 29) = "April 29, 2021"					      

(* ======================================================= *)
(* FN 8 *)
						 
val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test8_1 = number_before_reaching_sum (2, [1,2,3,4,5]) = 1

val test8_2 = number_before_reaching_sum (25, [5, 10, 5, 6]) = 3								

val test8_3 = number_before_reaching_sum (1, [1,2,3,4,5]) = 0								
								   
(* ======================================================= *)						 
(* FN 9 *)
								
val test9 = what_month 70 = 3

val test9_1 = what_month 17 = 1

val test9_2 = what_month 100 = 4

val test9_3 = what_month 365 = 12

val test9_4 = what_month 1 = 1				   

(* ======================================================= *)				
(* FN 10 *)
				 
val test10 = month_range (31, 34) = [1,2,2,2]
					
(* ======================================================= *)
(* FN 11 *)
					
val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

val test11_1 = oldest([(2012,2,28),(2011,3,31),(2008,4,28)]) = SOME (2008,4,28)

val test11_2 = oldest ([]) = NONE

(* ======================================================= *)
(* Helper, duplicate *)

val test_x1 = remove_duplicated_months ([1,2,2,4,5]) = [1,2,4,5]

val test_x2 = remove_duplicated_months ([1,1,1,1]) = [1]

val test_x3 = remove_duplicated_months ([1,2,3,4]) = [1,2,3,4]

val test_x4 = remove_duplicated_months ([4,8,11,5,4,6]) = [4,5,6,8,11]

val test_x5 = remove_duplicated_months ([1,6,5,5,28]) = [1,5,6]

(* ======================================================= *)
(* FN 12 *)

val test12 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,4]) = 3

val test12_1 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,3,4,3]) = 2

val test12_2 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,6,7,8]) = 1

val test12_3 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[11,7,5]) = 0

val test12_4 = number_in_months_challenge ([(2012,2,28),(2013,2,1),(2011,3,31),(2011,2,28)],[2,3,4]) = 4 						     

val test12_5 = number_in_months_challenge ([(2012,2,28),(2013,2,1),(2011,3,31),(2011,2,28)],[1,1,1]) = 0


val test12_6 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)] 

val test12_7 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,12,3]) = [(2012,2,28),(2011,3,31),(2013,12,1)]

val test12_8 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,5,5,4,5]) = [(2012,2,28),(2011,4,28)]

val test12_9 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,5,6]) = [(2012,2,28)]

val test12_10 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[8,9,10]) = []

val test12_11 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,2]) = [(2012,2,28)]													     
(* ======================================================= *)
(* FN 13 *)

val test13 = reasonable_date (2012,2,28) = true

val test13_1 = reasonable_date (0,2,28) = false

val test13_2 = reasonable_date (~2,2,28) = false

val test13_3 = reasonable_date (1998,13,28) = false

val test13_4 = reasonable_date (1998,10,56) = false						  

val test13_5 = reasonable_date (1998,11,31) = false

val test13_6 = reasonable_date (1998,2,30) = false

val test13_7 = reasonable_date (2008,2,29) = true

val test13_8 = reasonable_date (2009,2,29) = false						 
