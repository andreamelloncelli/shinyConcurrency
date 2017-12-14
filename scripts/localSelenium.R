########
## local working procedure
library(RSelenium)
library(dplyr)
library(XML)
localDriver <- rsDriver(verbose = T, port = 4568L)
#mybrowser <- remoteDriver()
mybrowser<- localDriver$client
mybrowser$open(silent = T)

remDr <- remoteDriver(remoteServerAddr = "127.0.0.1",
											port = 4445L)
mybrowser<-remDr

container_get <- function(mybrowser) {
	mybrowser$open()
	mybrowser$navigate("http://ec2-52-201-221-131.compute-1.amazonaws.com:8080/app/test_app")
	# mybrowser$getPageSource()[[1]] %>% 
	# 	htmlParse
	Sys.sleep(3)
	html <- mybrowser$getPageSource()[[1]] %>% 
		strsplit(split = "\n") %>% 
		.[[1]] 
	str <- html[grepl("iframe", html)]
	mybrowser$close()
	str
}
container_get(mybrowser)
