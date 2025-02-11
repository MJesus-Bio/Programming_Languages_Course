fun null xs =
    ((fn z => false) (hd xs)) handle List.Empty => true
