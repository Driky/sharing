package formationelk

import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class FormationElkSimulation extends Simulation {

	val uri1 = "http://localhost:8080"

	val httpProtocol = http
		.baseURL(uri1)
//		.proxy(Proxy("localhost", 8080).httpsPort(8081))
		.inferHtmlResources()

	val headers_0 = Map("Accept" -> "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")

	val cssHeaders = Map("Accept" -> "text/css,*/*;q=0.1")

	val pngHeaders = Map("Accept" -> "image/png,image/*;q=0.8,*/*;q=0.5")

	val jsonHeaders = Map("Accept" -> "application/json, text/plain, */*","Content-Type" -> "application/json;charset=utf-8")


	val scn = scenario("FormationElkSimulation")
		.exec(http("GetPage")
			.get("/")
			.headers(headers_0)
			.resources(http("request_1")
					.get(uri1 + "/main.css")
					.headers(cssHeaders),
				http("request_2")
					.get(uri1 + "/angular-material.min.css")
					.headers(cssHeaders),
				http("request_3")
					.get(uri1 + "/angular.min.js"),
				http("request_4")
					.get(uri1 + "/angular-resource.min.js"),
				http("request_5")
					.get(uri1 + "/angular-aria.min.js"),
				http("request_6")
					.get(uri1 + "/angular-animate.min.js"),
				http("request_7")
					.get(uri1 + "/angular-material.min.js"),
				http("request_8")
					.get(uri1 + "/main.js"),
				http("request_9")
					.get(uri1 + "/icon-zenika.png")
					.headers(pngHeaders),
				http("request_10")
					.get(uri1 + "/rest")
					.headers(jsonHeaders)
			))
		.pause(10)
		.exec(repeat(10,"n") {
			exec(http("PostNormal")
				.post("/rest")
				.headers(jsonHeaders)
				.body(RawFileBody("FormationElkSimulation_0011_request.txt")))
			.pause(10)
			.exec(http("PostLent")
				.post("/rest")
				.headers(jsonHeaders)
				.body(RawFileBody("FormationElkSimulation_0012_request.txt")))
			.pause(10)
			.exec(http("PostErreur")
				.post("/rest")
				.headers(jsonHeaders)
				.body(RawFileBody("FormationElkSimulation_0013_request.txt")))
			.pause(10)
			.exec(http("GetErreur")
				.get("/notfound")
				.headers(jsonHeaders)
				.check(status.is(404)))
			.pause(10)
		})


	setUp(scn.inject(atOnceUsers(4))).protocols(httpProtocol)
}