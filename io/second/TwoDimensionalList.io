TwoDimensionalList := Object clone do (
  inner := List clone // creates inner list to store other arrays
)

TwoDimensionalList dim := method(x,y,
  inner = List clone;
  for(i, 1, y, inner append(List clone setSize(x)))
)

TwoDimensionalList set := method(x,y,value, 
  inner at(y) atPut(x, value) 
)

TwoDimensionalList get := method(x,y, 
  inner at(y) at(x)
)

TwoDimensionalList xSize := method(
  if (inner size == 0, 0, inner at(0) size)
)

TwoDimensionalList ySize := method(
  inner size
)

TwoDimensionalList transpose := method(
  result := TwoDimensionalList clone;
  result dim(ySize, xSize);
  for(i, 0, xSize - 1,
    for(j, 0, ySize - 1,
      result set(j, i, get(i, j))
    )
  )
  result;
)

TwoDimensionalList toFile := method(path,
  tempFile := File clone openForUpdating(path)
  inner foreach(line, 
    tempFile write(line join(" "), "\n")
  )
  tempFile close
)

File toTwoDimensionalList := method(
  result := TwoDimensionalList clone
  lines := readLines
  if (lines size > 0,
    x := lines at(0) split size;
    result dim(x, lines size);
    chunks := nil;
    lines foreach(i, line, 
      chunks = line split;
      chunks foreach(j, chunk, result set(j, i, chunk))
    )
  );
  result
)

test := TwoDimensionalList clone
test dim(3, 4)

test set(0,1,"hola")
test set(2,3,3)
test get(0,1) println
test get(2,3) println
test toFile("/tmp/test")

transposed := test transpose

transposed get (1, 0) println
transposed get (3, 2) println

file := File clone openForReading("/tmp/test")
readlist := file toTwoDimensionalList
readlist toFile("/tmp/test2")
file close

