import java.io.BufferedReader
import java.io.InputStreamReader

abstract class Player {
  def next: Player
  def play(game: TicTacToe)
}

object X extends Player with Human {
  def next = O
  override def toString() = "X"
}

object O extends Player with Human {
  def next = X
  override def toString() = "O"
}

trait Human extends Player {
  private val input = new BufferedReader(new InputStreamReader(System.in))
  
  def play(game: TicTacToe) {
    val position = readPosition
    if (game.available(position)) {
      game.play(this, position)
    } else {
      play(game)
    }
  }
  
  def readPosition: Int = {
    try {
      input.readLine().toInt
    } catch {
      case nfe: NumberFormatException => 0
    }
  }
}

trait Computer extends Player {
  def play(game: TicTacToe) {
    for (i <- 1 to 9) {
      if (game.available(i)) {
        game.play(this, i)
      }
    }
  }
}