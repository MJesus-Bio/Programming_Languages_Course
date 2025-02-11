fun is_older (date1: (int*int*int), date2: (int*int*int)) =
    (#1 date1 < #1 date2)
    orelse
    ((#1 date1 = #1 date2) andalso (#2 date1 < #2 date2))
    orelse
    ((#1 date1 = #1 date2) andalso (#2 date1 = #2 date2) andalso (#3 date1 < #3 date2))


fun number_in_month (dates: (int*int*int)  list, month: int) =
    if null dates
    then 0
    else let val z = if ((#2 (hd dates)) = month) then 1 else 0
    in
	z + number_in_month (tl dates, month)
    end

  
fun number_in_months (dates: (int*int*int) list, months: int list) =
    let
	fun make_list(months: int list) =
	    if null months
	    then []
	    else number_in_month(dates,(hd months))::make_list(tl months)
	fun count_non_zero(zs: int list) =
	    if null zs
	    then 0
	    else hd zs + count_non_zero(tl zs)
    in
	count_non_zero(make_list(months))
    end
	

fun dates_in_month (dates: (int*int*int) list, month: int) =
    if null dates
    then []
    else if ((#2 (hd dates)) = month)
    then (hd dates)::dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)


fun dates_in_months (dates: (int*int*int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd months)@dates_in_months(dates, tl months)


fun get_nth (xs: string list, n: int) =
    if n = 1
    then hd xs
    else get_nth(tl xs, n - 1)


fun date_to_string (date: (int*int*int)) =
    let
	val months = ["January", "February", "March", "April",
		      "May", "June", "July", "August", "September",
		      "October", "November", "December"]
	val year = Int.toString (#1 date)
	val month = get_nth(months, #2 date)
	val day = Int.toString (#3 date)
    in
	month ^ " " ^ day ^ ", " ^ year
    end
	

fun number_before_reaching_sum (x: int, sum_list: int list) =
    if (x <= hd sum_list)
    then 0
    else 1 + number_before_reaching_sum(x - hd sum_list, tl sum_list)


fun what_month (day: int) =
    let
	val days_in_year = [31, 28, 31, 30,
			    31, 30, 31, 31,
			    30, 31, 30, 31]
    in
        1 + number_before_reaching_sum(day, days_in_year)
    end


fun month_range (day1: int, day2: int) =
    if (day1 > day2)
    then []
    else what_month(day1)::month_range(day1+1, day2)
		
	   
fun oldest (dates: (int*int*int) list) =
    if null dates
    then NONE
    else
    let
	fun older_search (dates: (int*int*int) list, older: (int*int*int)) =
	    if null dates
	    then older
	    else if is_older (older, hd dates)
	    then older_search (tl dates, older)
	    else older_search (tl dates, hd dates)
    in
	SOME (older_search (tl dates, hd dates))
    end
    
(* It also removes wrong months (e.g. 17) *)
fun remove_duplicated_months (xs: int list) =
    let
	fun take_month (xs: int list, y: int) =
	    if null xs
	    then []
	    else if (hd xs = y)
	    then [y]
	    else take_month (tl xs, y)
	val months = [1,2,3,4,5,6,7,8,9,10,11,12]
	fun take_months (xs: int list, ys: int list) =
	    if null ys
	    then []
	    else take_month(xs, hd ys)@take_months(xs, tl ys)  
    in
	take_months(xs, months)
    end

fun number_in_months_challenge (dates: (int*int*int) list, months: int list) =
    number_in_months (dates, remove_duplicated_months months)


fun dates_in_months_challenge (dates: (int*int*int) list, months: int list) =
    dates_in_months (dates, remove_duplicated_months months)

fun reasonable_date (date: (int*int*int)) =
    let
	val days_normal_year = [31, 28, 31, 30,
			        31, 30, 31, 31,
				30, 31, 30, 31]
	val days_leap_year = [31, 29, 31, 30,
			      31, 30, 31, 31,
			      30, 31, 30, 31]
	fun days_in_month (month: int, days: int list) =
	    if (month = 1)
	    then hd days
	    else days_in_month (month - 1, tl days)
	fun check_correct_year (year: int) =
	    (year > 0)
	fun check_correct_month (month: int) =
	    (month > 0) andalso (month <= 12)
	fun check_leap_year (year: int) =
	    ((year mod 400) = 0) orelse
	    (((year mod 4) = 0) andalso (not ((year mod 100) = 0)))
	val leap_year = check_leap_year (#1 date)
	fun check_correct_day (day: int, days_in_month: int) =
	    (day <= days_in_month)
    in
	if (check_correct_year (#1 date) andalso check_correct_month (#2 date))
	then let val days = if check_leap_year(#1 date)
			    then days_in_month (#2 date, days_leap_year)
			    else days_in_month (#2 date, days_normal_year)
	     in
		 check_correct_day (#3 date, days)
	     end
	else false
    end
	
	
	
