import scala.io.Source
import scala.io.BufferedSource
import scala.util.Properties

trait Censor {  
  def supress(words: String, curseWords: Map[String, String]): String = {
     val speech = (words /: curseWords) {(speech, pair) => speech.replace(pair._1, pair._2)}
     return speech
  }
}

class Person(curseWords: Map[String, String]) extends Censor {
  def supress(words: String): String = supress(words, curseWords)
}

object Person extends Application {
  def extractCurseWordsFrom(buffer: BufferedSource): Map[String, String] = {
    val result = scala.collection.mutable.Map[String, String]()
    buffer.getLines.foreach(line => {
      val pair = line.split("->")
      result += pair(0).trim() -> pair(1).trim()
    })
    return result.toMap
  }
    
  override def main(args: Array[String]) = {
    //val curseWords = Map("Shoot" -> "Pucky", "Darn" -> "Beans")
    val curseWords = extractCurseWordsFrom(Source.fromFile("curse_words.txt"))
    val censor = new Person(curseWords)
    val speech = censor.supress("Darn. Shoot. Heck. I was hoping you weren't busy.- I can get out of it.")
    println(speech)
  }
}