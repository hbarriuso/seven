Builder := Object clone

spaces := "" asMutable

Builder forward := method (
  spaces = spaces appendSeq("  ")
  writeln(spaces, "<", call message name, ">")
  call message arguments foreach( 
    arg,
    content := self doMessage(arg);
    if(content type == "Sequence", writeln(spaces, "  ", content))
  )
  write(spaces, "</", call message name, ">")
  spaces = spaces removeSuffix("  ")
)

Builder ul(
  li("Io"),
  li("Lua"),
  li("JavaScript")
)  
