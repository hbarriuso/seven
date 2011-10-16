import java.io.FileNotFoundException
import scala.io._
import scala.actors._
import Actor._
import util.matching.Regex

object PageLoader {
  def loadPage(url: String, link: String): String = link match {
    case x if x.startsWith("http") => loadPage(link)
    case x if "#".equals(x) || x.startsWith("javascript") => ""
    case x if x.startsWith("/") => loadPage(url + link.substring(1))
    case _ => loadPage(url + link)
  }

  def loadPage(url: String) = {
    try {
      Source.fromURL(url)(Codec("ISO-8859-1")).mkString
    } catch {
      case fnfe: FileNotFoundException => ""
    }
  }
}

class Sizer {
  val urls = List("http://www.amazon.com/",
    "http://www.twitter.com/",
    "http://www.google.com/",
    "http://www.cnn.com/")
  val linkRegex = new Regex("(?i)<a href=['|\"]([^'^\"]*)['|\"][^>]*>", "link")

  def timeMethod(method: () => Unit) {
    val start = System.nanoTime
    method()
    val end = System.nanoTime
    println("Method took " + (end - start) / 1000000000.0 + " seconds.")
  }

  def loadPageSizeSequentially() = {
    for (url <- urls) {
      val content = PageLoader.loadPage(url)
      processSequentially(url, content)
    }
  }

  def processSequentially(url: String, content:String) {
    println("Size for " + url + ": " + content.length)
    val links = extractLinks(content)
    var total = content.length
    for (link <- links) {
      total += PageLoader.loadPage(url, link).length
      println("Partial size for " + url + ": " + total)
    }
    println("Total size for " + url + ": " + total)
    println("Number of links in " + url + ": " + links.length)
  }

  def extractLinks(content: String) = {
    val matchIterator = linkRegex.findAllIn(content).matchData
    for (a <- matchIterator) yield  a.group("link")
  }

  def loadPageSizeConcurrently() = {
    val caller = self

    for (url <- urls) {
      actor { caller ! (url, PageLoader.loadPage(url)) }
    }

    for (i <- 1 to urls.size) {
      receive {
        case (url: String, content: String) =>
          processConcurrently(url, content)
      }
    }
  }

  def processConcurrently(url: String, content:String) {
    val caller = self

    println("Size for " + url + ": " + content.length)
    val links = extractLinks(content)
    for (link <- links) {
      actor { caller ! (url, PageLoader.loadPage(url, link))}
    }
    var total = content.length
    for (i <- 1 to links.size) {
      receive {
        case (url: String, content: String) =>
          total += content.length
          println("Total size for " + url + ": " + total)
      }
    }
    println("Number of links in " + url + ": " + links.length)
  }
}

object Sizer extends App {
  override def main(args: Array[String]) {
    val sizer = new Sizer

    println("Sequential run:")
    sizer.timeMethod { sizer.loadPageSizeSequentially }

    println("Concurrent run")
    sizer.timeMethod { sizer.loadPageSizeConcurrently }
  }
}