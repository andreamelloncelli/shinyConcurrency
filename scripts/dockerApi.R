
###############
## docker working procedure
library(RSelenium)
library(dplyr)
library(XML)
# "docker pull selenium/standalone-firefox:2.53.0"
docker_ps  <- "docker ps"
docker_run <- function(port = 4445L) {
	docker_run <- paste0("docker run -d -p ", as.character(port), ":4444 selenium/standalone-firefox:2.53.0")
	hash <- system(docker_run, intern = TRUE)
	list(hash = hash
			 , port = port)
}
docker_kill <- function(container) {
	kill_cmd <- paste0("docker kill ", container$hash)
	system(kill_cmd)
}
browser_get <- function(id, port = 4445L) {
	mybrowser <- remoteDriver(remoteServerAddr = "127.0.0.1",
														port = port)
	mybrowser
}
container_get <- function(mybrowser) {
	mybrowser$open()
	mybrowser$navigate("http://ec2-52-201-221-131.compute-1.amazonaws.com:8080/app/test_app")
	# mybrowser$getPageSource()[[1]] %>% 
	# 	htmlParse
	Sys.sleep(3)
	str <- mybrowser$getPageSource()[[1]] %>% 
		strsplit(split = "\n") %>% 
		.[[1]] %>% 
		.[81]
	mybrowser$close()
	str
}

url_get <- function(id, wait_container = 5) {
	port <- 4445L + id
	docker_container <- docker_run(port = port)
	Sys.sleep(wait_container)
	mybrowser <- browser_get(id, port = docker_container$port)
	web_route <- container_get(mybrowser)
	docker_kill(docker_container)
	web_route
}
url_get(id = 1)

library(parallel)
browsers <- lapply(1:2, browser_get)
t <- system.time(containers <- mclapply(browsers, container_get))
t
t2 <- system.time(containers_2 <- mclapply(mc.cores = 40, 1:20, url_get))
containers_2
t2
containers
container_get(mybrowser)
