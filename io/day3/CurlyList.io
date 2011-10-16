curlyBrackets := method(
  r := List clone
  call message arguments foreach(arg,
    content := self doMessage(arg);
    r append(content)
  )
  r
)

{"a", 2, "treinta y dos"} println
