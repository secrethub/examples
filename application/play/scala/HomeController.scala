package controllers

import javax.inject._
import play.api._
import play.api.mvc._

/**
 * This controller creates an `Action` to handle HTTP requests to the
 * application's home page.
 */
@Singleton
class HomeController @Inject()(config: Configuration, val controllerComponents: ControllerComponents) extends BaseController {

  /**
   * Create an Action to render an HTML page.
   *
   * The configuration in the `routes` file means that this method
   * will be called when the application receives a `GET` request with
   * a path of `/`.
   */
  def index() = Action { implicit request: Request[AnyContent] =>
    if (config.get[String]("demo.username").isEmpty || config.get[String]("demo.password").isEmpty) {
      InternalServerError("not all variables are set")
    } else {
      Ok("Welcome home " + config.get[String]("demo.username"))
    }
  }
}

