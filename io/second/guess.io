randomNumber := (Random value( 99 ) + 1) floor

std := File standardInput

previousGuess := nil

10 repeat(
  guess := std readLine("Guess number(1..100): ") asNumber
  if (guess == randomNumber, 
    "Nice done!" println; break,
    if (previousGuess,
      if ((randomNumber - guess) abs >= (randomNumber - previousGuess) abs,
        "Colder" println,
        "Hotter" println
      )
    )
  );
  previousGuess = guess;
)
