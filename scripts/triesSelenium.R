#install.packages("RSelenium")
library("RSelenium")
# startServer()
rsDriver(verbose = F)
mybrowser <- remoteDriver()
mybrowser$open()
mybrowser$navigate("http://www.weather.gov")
mybrowser$findElement(using = 'css selector', "#inputstring")
wxbox <- mybrowser$findElement(using = 'css selector', "#inputstring")
wxbox$sendKeysToElement(list("01701"))
wxbutton <- mybrowser$findElement(using = 'css selector', "#btnSearch")
wxbutton$clickElement()
mybrowser$goBack()
wxbox <- mybrowser$findElement(using = 'css selector', "#inputstring")
wxbox$sendKeysToElement(list("01701", "\uE007"))

###


#Check whether a Selenium Server is running. You can try running one automatically:

library(RSelenium)
library(wdman)
selServ <- wdman::selenium(verbose = FALSE)

#You can then check the logs to see if there are any issues:

selServ$log()

#Alternatively you can try running a Selenium Server manually:

library(RSelenium)
library(wdman)
selServCmd <- wdman::selenium(retcommand = TRUE, verbose = FALSE)
cat(selServCmd)

#Then manually run the output from cat(selServ) in a terminal:
#/usr/bin/java -Dwebdriver.chrome.driver='/Users/admin/Library/Application Support/binman_chromedriver/mac64/2.27/chromedriver' -Dwebdriver.gecko.driver='/Users/admin/Library/Application Support/binman_geckodriver/macos/0.14.0/geckodriver' -Dphantomjs.binary.path='/Users/admin/Library/Application Support/binman_phantomjs/macosx/2.1.1/phantomjs-2.1.1-macosx/bin/phantomjs' -jar '/Users/admin/Library/Application Support/binman_seleniumserver/generic/3.0.1/selenium-server-standalone-3.0.1.jar' -port 4567
