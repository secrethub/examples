package controllers;

import com.typesafe.config.Config;
import play.mvc.*;

import javax.inject.Inject;

/**
 * This controller contains an action to handle HTTP requests
 * to the application's home page.
 */
public class HomeController extends Controller {

    private final Config config;

    @Inject
    public HomeController(Config config) {
        this.config = config;
    }

    /**
     * An action that renders an HTML page with a welcome message.
     * The configuration in the <code>routes</code> file means that
     * this method will be called when the application receives a
     * <code>GET</code> request with a path of <code>/</code>.
     */
    public Result index() {
        if (config.getString("demo.username").isEmpty() || config.getString("demo.password").isEmpty()) {
            return Results.internalServerError("not all variables are set");
        } else {
            return ok("Welcome " + config.getString("demo.username"));
        }
    }
}

