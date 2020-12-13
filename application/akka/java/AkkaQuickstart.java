package example;

import akka.actor.typed.ActorSystem;

import java.io.IOException;
public class AkkaQuickstart {
  public static void main(String[] args) {
    //#actor-system
    final ActorSystem<GreeterMain.SayHello> greeterMain = ActorSystem.create(GreeterMain.create(), "helloakka");
    //#actor-system

    if (System.getenv("DEMO_USERNAME") == null || System.getenv("DEMO_PASSWORD") == null) {
    	System.out.println("not all variables are set");
    } else {
    	//#main-send-messages
    	greeterMain.tell(new GreeterMain.SayHello(System.getenv("DEMO_USERNAME")));
    	//#main-send-messages
    }
    greeterMain.terminate();
  }
}

