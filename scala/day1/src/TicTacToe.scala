import scala.collection.mutable.LinkedList

class TicTacToe {
  val EMPTY = "_"
  var board = LinkedList("_", "_", "_", "_", "_", "_", "_", "_", "_")
  var current: Player = X
  
  def printBoard {
    for (i <- 0 until board.size) {
      print(board(i) + " ")
      if ((i + 1) % 3 == 0)
        println
    }
    println
  }
  
  def play(player: Player, position: Int) {
    if (player == current) {
      board.update(position - 1, player.toString())
      printBoard
      if (checkResult(player)) {
        println(player + " wins.")
        exit
      } else {
        current = player.next
        println("Next move for " + current + ":")
        current.play(this)
      }
    }
  }
  
  def checkResult(player: Player): Boolean = 
    checkRows(player) || checkColumns(player) || checkDiagonals(player)

  
  def checkRows(player: Player): Boolean = {
    for (i <- 1 to 3) {
      def offset = (i - 1) * 3
      if (check(offset, offset + 1, offset + 2, player.toString())) {
        return true
      }
    }
    return false
  }  
  
  def checkColumns(player: Player): Boolean = {
    for (i <- 1 to 3) {
      if (check(i - 1, i + 2, i + 5, player.toString())) {
        return true
      }
    }
    return false    
  }
  
  def checkDiagonals(player: Player): Boolean = {
    check(0, 4, 8, player.toString()) || check(2, 4, 6, player.toString())
  }
  
  def check(x: Int, y:Int, z: Int, name: String): Boolean = 
    name.equals(board(x)) && name.equals(board(y)) && name.equals(board(z))
    
  def available(position: Int): Boolean = EMPTY.equals(board(position - 1))
}

object TicTacToe extends Application {
  override def main(args: Array[String]) = {
    val game = new TicTacToe
    println("Next move for " + game.current + ":")
    game.current.play(game)
  }
}
