OperatorTable addAssignOperator(":", "atPutString")

Builder := Object clone

spaces := "" asMutable

Builder forward := method (
  spaces = spaces appendSeq("  ")
  write(spaces, "<", call message name)
  call message arguments foreach( 
    i, arg,
    if (i == 0 and arg asString() findSeq("curlyBrackets") != 0, writeln(">"));
    content := self doMessage(arg);
    if(content type == "Map", content foreach(k, v, write(" ", k, " = \"", v, "\">\n")));
    if(content type == "Sequence", writeln(spaces, "  ", content))
  )
  write(spaces, "</", call message name, ">")
  spaces = spaces removeSuffix("  ")
)

Builder curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
  r
)

Map atPutString := method(arg,
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
    call evalArgAt(1)
  )
)

Builder ul(
  li("Io"),
  li("Lua"),
  li("JavaScript")
)
"" println
s := File with("Book.lispml") openForReading contents
doString(s)
