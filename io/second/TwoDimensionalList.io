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

TwoDimensionalList xSize := method(
  if (inner == nil or inner size() == 0, 0, inner at(0) size())
)

TwoDimensionalList ySize := method(
  if (inner == nil , 0, inner size())
)

TwoDimensionalList transpose := method(
  result := TwoDimensionalList clone;
  if (inner != nil, 
    result dim(ySize(), xSize())
    for(i, 0, xSize() - 1,
      for(j, 0, ySize() - 1,
        result set(j, i, get(i, j))
      ) 
    )
  )
  result;
)

test := TwoDimensionalList clone
test dim(3, 4)

test set(0,1,"hola")
test set(2,3,3)
test get(0,1) println
test get(2,3) println

transposed := test transpose()

transposed get (1, 0) println
transposed get (3, 2) println
