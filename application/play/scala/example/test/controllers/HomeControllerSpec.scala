package controllers

import org.scalatestplus.play._
import org.scalatestplus.play.guice._
import play.api.test._
import play.api.test.Helpers._

/**
 * Add your spec here.
 * You can mock out a whole application including requests, plugins etc.
 *
 * For more information, see https://www.playframework.com/documentation/latest/ScalaTestingWithScalaTest
 */
class HomeControllerSpec extends PlaySpec with GuiceOneAppPerTest with Injecting {

  def checkCredentials(negativeCase: Int): Int = {
    if (sys.env.getOrElse("DEMO_USERNAME", "").isEmpty || sys.env.getOrElse("DEMO_PASSWORD", "").isEmpty) negativeCase
    else OK
  }

  def credentialMessage(): String = {
    if (sys.env.getOrElse("DEMO_USERNAME", "").isEmpty || sys.env.getOrElse("DEMO_PASSWORD", "").isEmpty) "not all variables are set"
    else "Welcome"
  }

  def routeContentType(): Some[String] = {
    if (sys.env.getOrElse("DEMO_USERNAME", "").isEmpty || sys.env.getOrElse("DEMO_PASSWORD", "").isEmpty) Some("text/html")
    else Some("text/plain")
  }

  def routeCredentialMessage(): String = {
    if (sys.env.getOrElse("DEMO_USERNAME", "").isEmpty || sys.env.getOrElse("DEMO_PASSWORD", "").isEmpty) "Not Found"
    else "Welcome"
  }

  "HomeController GET" should {

    "render the index page from a new instance of controller" in {
      val controller = new HomeController(stubControllerComponents())
      val home = controller.index().apply(FakeRequest(GET, "/"))

      status(home) mustBe checkCredentials(INTERNAL_SERVER_ERROR)
      contentType(home) mustBe Some("text/plain")
      contentAsString(home) must include (credentialMessage())
    }

    "render the index page from the application" in {
      val controller = inject[HomeController]
      val home = controller.index().apply(FakeRequest(GET, "/"))

      status(home) mustBe checkCredentials(INTERNAL_SERVER_ERROR)
      contentType(home) mustBe Some("text/plain")
      contentAsString(home) must include (credentialMessage())
    }

    "render the index page from the router" in {
      val request = FakeRequest(GET, "/")
      val home = route(app, request).get

      status(home) mustBe checkCredentials(NOT_FOUND)
      contentType(home) mustBe routeContentType()
      contentAsString(home) must include (routeCredentialMessage())
    }
  }
}

