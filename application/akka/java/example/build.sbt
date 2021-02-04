val akkaHttpVersion = "10.2.2"
val akkaVersion    = "2.6.10"

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.example",
      scalaVersion := "2.13.1",
      name := "example"
    )),
    name := "TestProject",
    libraryDependencies ++= Seq(
      "com.typesafe.akka" %% "akka-http"            % akkaHttpVersion,
      "com.typesafe.akka" %% "akka-actor-typed"     % akkaVersion,
      "com.typesafe.akka" %% "akka-stream"          % akkaVersion,
      "com.typesafe.akka" %% "akka-http-jackson"    % akkaHttpVersion,
      "ch.qos.logback"    % "logback-classic"       % "1.2.3",

      "com.typesafe.akka" %% "akka-testkit"                 % akkaVersion     % Test,
      "com.typesafe.akka" %% "akka-http-testkit"            % akkaHttpVersion % Test,
      "com.typesafe.akka" %% "akka-actor-testkit-typed"     % akkaVersion     % Test,
      "junit"              % "junit"                        % "4.12"          % Test,
      "com.novocode"       % "junit-interface"              % "0.10"          % Test
    ),

    testOptions += Tests.Argument(TestFrameworks.JUnit, "-v")
  )
