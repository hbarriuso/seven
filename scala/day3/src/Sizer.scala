import scala.io._
import scala.actors._
import Actor._

object PageLoader {
  val reg = "<a [^>]*>".r

  def processPage(url: String) {
    val content = getPage(url)
    println("Size for " + url + ": " + content.length)
    println("Number of links in " + url + ": " + countLinks(content))
  }
  def getPage(url: String) = Source.fromURL(url)(Codec("ISO-8859-1")).mkString
  def countLinks(content: String) = reg.findAllIn(content).length
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
      PageLoader.processPage(url)
    }
  }

  def getPageSizeConcurrently() = {
    val caller = self

    for (url <- urls) {
      actor { caller ! (url, PageLoader.getPage(url)) }
    }

    for (i <- 1 to urls.size) {
      receive {
        case (url, content: String) =>
          println("Size for " + url + ": " + content.length)
          println("Number of links in " + url + ": " + PageLoader.countLinks(content))
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