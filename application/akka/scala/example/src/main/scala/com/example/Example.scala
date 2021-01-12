package com.example

import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.server.Route

import scala.concurrent.ExecutionContextExecutor
import scala.io.StdIn
import scala.util.Failure
import scala.util.Success

//#main-class
object Example {
  //#start-http-server
  private def startHttpServer(routes: Route)(implicit system: ActorSystem[_]): Unit = {
    // Akka HTTP still needs a classic ActorSystem to start
    import system.executionContext

    val futureBinding = Http().newServerAt("localhost", 8080).bind(routes)
    futureBinding.onComplete {
      case Success(binding) =>
        val address = binding.localAddress
        system.log.info("Server online at http://{}:{}/", address.getHostString, address.getPort)
      case Failure(ex) =>
        system.log.error("Failed to bind HTTP endpoint, terminating system", ex)
        system.terminate()
    }
  }
  //#start-http-server
  def main(args: Array[String]): Unit = {
    //#server-bootstrapping
    val rootBehavior = Behaviors.setup[Nothing] { context =>
      val route =
        path("") {
          get {
            if (sys.env.getOrElse("DEMO_USERNAME", "").isEmpty || sys.env.getOrElse("DEMO_PASSWORD", "").isEmpty) {
              complete("not all variables are set\n")
            } else {
              complete("Welcome " + sys.env("DEMO_USERNAME") + "\n")
            }
          }
        }
      startHttpServer(route)(context.system)

      Behaviors.empty
    }
    val system = ActorSystem[Nothing](rootBehavior, "HelloAkkaHttpServer")
    //#server-bootstrapping
  }

  // TODO Select the code above or the commented one
//  def main(args: Array[String]): Unit = {
//
//    implicit val system: ActorSystem[Nothing] = ActorSystem(Behaviors.empty, "my-system")
//    // needed for the future flatMap/onComplete in the end
//    implicit val executionContext: ExecutionContextExecutor = system.executionContext
//
//    val route =
//      path("") {
//        get {
//          if (sys.env.getOrElse("DEMO_USERNAME", "").isEmpty || sys.env.getOrElse("DEMO_PASSWORD", "").isEmpty) {
//            complete("not all variables are set\n")
//          } else {
//            complete("Welcome " + sys.env("DEMO_USERNAME") + "\n")
//          }
//        }
//      }
//
//    val bindingFuture = Http().newServerAt("localhost", 8080).bind(route)
//
//    println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
//    StdIn.readLine() // let it run until user presses return
//  }
}
//#main-class

