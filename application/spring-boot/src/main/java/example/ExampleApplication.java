package example;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@SpringBootApplication
public class ExampleApplication {

  @Value("${DEMO_USERNAME:#{null}}")
  String username;

  @Value("${DEMO_PASSWORD:#{null}}")
  String password;

  @RestController
  class ExampleController {
    @GetMapping("/")
    ResponseEntity<String> printSecrets() {
        if (username==null || password==null) {
          return new ResponseEntity<>("not all variables are set", HttpStatus.INTERNAL_SERVER_ERROR);
        } else {
          return new ResponseEntity<>("Welcome " + username, HttpStatus.OK);
        }
    }
  }

  public static void main(String[] args) {
    SpringApplication.run(ExampleApplication.class, args);
  }
}
