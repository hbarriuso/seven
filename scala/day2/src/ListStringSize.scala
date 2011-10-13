object ListStringSize extends Application {
  override def main(args: Array[String]) = {
    val words = List("a", "list", "of", "words")
    val size = (0 /: words) {(size, word) => size + word.size}
    println(size)
  }
}