//#full-example
package example


import akka.actor.typed.ActorRef
import akka.actor.typed.ActorSystem
import akka.actor.typed.Behavior
import akka.actor.typed.scaladsl.Behaviors

//#main-class
object AkkaQuickstart extends App {

  if (sys.env.get("DEMO_USERNAME").getOrElse("").isEmpty() || sys.env.get("DEMO_PASSWORD").getOrElse("").isEmpty()) {
  	println("not all variables are set")
  } else {
  	//#main-send-messages
  	println("Hello " + sys.env.get("DEMO_USERNAME").get)
  	//#main-send-messages
  }
}
//#main-class
//#full-example

