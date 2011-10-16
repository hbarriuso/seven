import scala.io._
import scala.actors._
import Actor._

object PageLoader {
  def getPageSize(url: String) = Source.fromURL(url).mkString.length
}

class Sizer {
  val urls = List("http://www.amazon.com/",
    "http://www.twitter.com/",
    "http://www.google.com/",
    "http://www.cnn.com/")

  def timeMethod(method: () => Unit) = {
    val start = System.nanoTime
    method()
    val end = System.nanoTime
    println("Method took " + (end - start) / 1000000000.0 + " seconds.")
  }

  def getPageSizeSequentially() = {
    for (url <- urls) {
      println("Size for " + url + ": " + PageLoader.getPageSize(url))
    }
  }

  def getPageSizeConcurrently() = {
    val caller = self

    for (url <- urls) {
      actor { caller ! (url, PageLoader.getPageSize(url)) }
    }

    for (i <- 1 to urls.size) {
      receive {
        case (url, size) =>
          println("Size for " + url + ": " + size)
      }
    }
  }
}

object Sizer extends Application {
  override def main(args: Array[String]) = {
    val sizer = new Sizer
    
    println("Sequential run:")
    sizer.timeMethod { sizer.getPageSizeSequentially }

    println("Concurrent run")
    sizer.timeMethod { sizer.getPageSizeConcurrently }
  }
}