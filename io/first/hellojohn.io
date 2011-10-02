Man := Object clone do (
	greet := method(name, writeln("hello, ", name))
)

john := Man clone

john greet("Hector")
