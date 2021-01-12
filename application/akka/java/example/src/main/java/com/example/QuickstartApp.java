package com.example;

import akka.NotUsed;
import akka.actor.typed.Behavior;
import akka.http.javadsl.Http;
import akka.http.javadsl.ServerBinding;
import akka.http.javadsl.server.Route;
import akka.actor.typed.javadsl.Behaviors;
import akka.actor.typed.ActorSystem;
import akka.http.javadsl.server.AllDirectives;

import java.net.InetSocketAddress;
import java.util.concurrent.CompletionStage;

//#main-class
public class QuickstartApp extends AllDirectives {
    final Route root = path("", () -> get(() -> {
            if (System.getenv("DEMO_USERNAME") == null || System.getenv("DEMO_PASSWORD") == null) {
                return complete("not all variables are set\n");
            } else {
                return complete("Welcome " + System.getenv("DEMO_USERNAME") + "\n");
            }
        }));

    // #start-http-server
    static void startHttpServer(Route route, ActorSystem<?> system) {
        CompletionStage<ServerBinding> futureBinding =
            Http.get(system).newServerAt("localhost", 8080).bind(route);

        futureBinding.whenComplete((binding, exception) -> {
            if (binding != null) {
                InetSocketAddress address = binding.localAddress();
                system.log().info("Server online at http://{}:{}/",
                    address.getHostString(),
                    address.getPort());
            } else {
                system.log().error("Failed to bind HTTP endpoint, terminating system", exception);
                system.terminate();
            }
        });
    }
    // #start-http-server

    public static void main(String[] args) {
        //#server-bootstrapping
        Behavior<NotUsed> rootBehavior = Behaviors.setup(context -> {
            startHttpServer(new QuickstartApp().root, context.getSystem());
            return Behaviors.empty();
        });

        // boot up server using the route as defined below
        ActorSystem.create(rootBehavior, "ExampleAkkaHttpServer");
        //#server-bootstrapping
    }

//    TODO: Choose the top code or the commented one
//    public static void main(String[] args) throws Exception {
//        // boot up server using the route as defined below
//        ActorSystem<Void> system = ActorSystem.create(Behaviors.empty(), "routes");
//
//        final Http http = Http.get(system);
//
//        //In order to access all directives we need an instance where the routes are define.
//        QuickstartApp app = new QuickstartApp();
//
//        final CompletionStage<ServerBinding> binding =
//                http.newServerAt("localhost", 8080)
//                        .bind(app.root);
//
//        System.out.println("Server online at http://localhost:8080/\nPress RETURN to stop...");
//        System.in.read(); // let it run until user presses return
//    }

}
//#main-class



