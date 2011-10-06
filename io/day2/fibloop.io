fib := method(n, a := 0; b := 1; s := 0; while (n > 0, s = a + b; a = b; b = s; n := n - 1); a)

fib(0) println
fib(1) println
fib(2) println
fib(3) println
fib(4) println
fib(5) println
fib(6) println
fib(7) println
fib(8) println

