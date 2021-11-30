package org.ourchitecture.hello.cloud

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class HelloCloudApplication

fun main(args: Array<String>) {
	runApplication<HelloCloudApplication>(*args)
}
