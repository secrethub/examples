package controllers;

import play.mvc.*;

/**
 * This controller contains an action to handle HTTP requests
 * to the application's home page.
 */
public class HomeController extends Controller {

    /**
     * An action that renders an HTML page with a welcome message.
     * The configuration in the <code>routes</code> file means that
     * this method will be called when the application receives a
     * <code>GET</code> request with a path of <code>/</code>.
     */
    public Result index() {
        if (System.getenv("DEMO_USERNAME") == null || System.getenv("DEMO_PASSWORD") == null) {
            return Results.internalServerError("not all variables are set\n");
        } else {
            return ok("Welcome " + System.getenv("DEMO_USERNAME") + "\n");
        }
    }
}

