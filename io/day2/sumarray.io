sumarray := method(array, sum := 0; array foreach(element, sum = sum + element sum))

sumarray( list(list(1, 2, 3), list(4, 5, 6)) ) println
