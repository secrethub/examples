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

public class Example extends AllDirectives {
    final Route root = path("", () -> get(() -> {
            if (System.getenv("DEMO_USERNAME") == null || System.getenv("DEMO_PASSWORD") == null) {
                return complete("not all variables are set\n");
            } else {
                return complete("Welcome " + System.getenv("DEMO_USERNAME") + "\n");
            }
        }));

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

    public static void main(String[] args) {
        Behavior<NotUsed> rootBehavior = Behaviors.setup(context -> {
            startHttpServer(new Example().root, context.getSystem());
            return Behaviors.empty();
        });

        // boot up server using the route as defined below
        ActorSystem.create(rootBehavior, "ExampleAkkaHttpServer");
    }
}
