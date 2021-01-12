import Kitura
import Foundation

let router = Router()

if ProcessInfo.processInfo.environment["DEMO_USERNAME"] == nil || ProcessInfo.processInfo.environment["DEMO_PASSWORD"] == nil {
    router.get("/") { request, response, next in
        response.send("either the DEMO_USERNAME environment variable, DEMO_PASSWORD environment variable, or both have not been set.")
        next()
    }
}
else {
    router.get("/") { request, response, next in
        response.send("welcome, \(ProcessInfo.processInfo.environment["DEMO_USERNAME"] ?? "")")
    }
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
