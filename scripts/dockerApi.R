
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
docker_kill_all <- function() {
  kill_cmd <- "docker kill $(docker ps -q) "
  system(kill_cmd)
}
browser_get <- function(id, port = 4445L) {
	mybrowser <- remoteDriver(remoteServerAddr = "127.0.0.1",
														port = port)
	mybrowser
}
container_get <- function(mybrowser, proxy_server = "ec2-107-23-143-101.compute-1.amazonaws.com", times = 1) {
	mybrowser$open()
	str <- character()
	for (i in 1:times) {
	  mybrowser$deleteAllCookies()
	  mybrowser$navigate(paste0("http://", proxy_server, ":8080/app/test_app"))
	  # mybrowser$getPageSource()[[1]] %>%
	  # 	htmlParse
	  Sys.sleep(10) #3
	  buf <- mybrowser$getPageSource()[[1]] %>%
	    strsplit(split = "\n") %>%
	    .[[1]] %>%
	    .[81]
	  str <- c(str, buf)
	}
	mybrowser$close()
	str
}

url_get <- function(id, wait_container = 5, proxy_server = "ec2-107-23-143-101.compute-1.amazonaws.com", times = 1) {
  port <- 4445L + id
  docker_container <- docker_run(port = port)
  Sys.sleep(wait_container)
  mybrowser <- browser_get(id, port = docker_container$port)
  web_route <- container_get(mybrowser, proxy_server = proxy_server, times = times)
  docker_kill(docker_container)
  web_route
}

containerNames_get <- function(containers) {
  flat_conteiners <- purrr::flatten_chr(containers)
  clean_vec_1 <- grep(pattern = "    <iframe width=\"100%\" src=\"\""
                    , x = flat_conteiners
                    , value = TRUE
                    , invert = TRUE)
  clean_vec_2 <- grep(pattern = "Error in checkError\\(res\\) : \n  Undefined error in httr call. httr output:.*"
                    , x = clean_vec_1
                    , value = TRUE
                    , invert = TRUE)
  name_vec <- gsub(pattern = "    <iframe width=\"100%\" src=\"/(.*)/\" id=\"shinyframe\" style=\"height: 688px;\"></iframe>"
                   , replacement = "\\1"
                   , x = clean_vec_2)
  name_vec
}

# conf_var ----------------------------------------------------------------

proxy_server <- "ec2-35-153-83-243.compute-1.amazonaws.com"

# simple_example ----------------------------------------------------------
container <- docker_run(4445L)
browsers <- lapply(1:2, browser_get, port = container$port)
browsers[[1]]$open()
browsers[[1]]$deleteAllCookies()
browsers[[1]]$getSessions() %>% str
browsers[[1]]$navigate(paste0("http://", proxy_server, ":8080/app/test_app"))
Sys.sleep(10)
(str <- browsers[[1]]$getPageSource()[[1]] %>%
  strsplit(split = "\n") %>%
  .[[1]] %>%
  .[81])

browsers[[1]]$close()
docker_kill(container)

# api_example -------------------------------------------------------------

url_get(id = 1, proxy_server = proxy_server)


# concurrent_example ------------------------------------------------------

library(parallel)
#
# t <- system.time(containers <- mclapply(browsers, container_get))
# t

n_cores <- 20
times <- 1
docker_kill_all()
t2 <- system.time(containers_2 <- mclapply(mc.cores = n_cores, 1:n_cores, url_get, wait_container = 10, proxy_server = proxy_server, times = times))
(nam <- containerNames_get(containers_2))
t2
containerStrings <- nam[!is.na(nam)]
# other -------------------------------------------------------------------



