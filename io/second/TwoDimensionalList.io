TwoDimensionalList := Object clone do (
  inner := nil // creates inner list to store other arrays
)

TwoDimensionalList dim := method(x,y,
  inner = List clone;
  for(i, 1, y, inner append(List clone setSize(x)))
)

TwoDimensionalList set := method(x,y,value, 
  inner at(y) insertAt(value, x) 
)

TwoDimensionalList get := method(x,y, 
  inner at(y) at(x)
)

test := TwoDimensionalList clone
test dim(3, 4)

test println
test set(0,1,"hola")
test get(0,1) println
test set(2,3,3)
test get(2,3) println
