# URL navigation script was designed literally to browse through websites ^_^.
# Personally I needed this to check flows of ad campaigns my agency is running.
# So I wrote a function that navigates through the number of campaigns (it's pretty helpful when n=500+)

library(RSelenium)
library(devtools)
#Open Mozilla
driver <- rsDriver(browser="firefox")
remDr <- driver[["client"]]
remDr$open()
#This function loops through lendings that I'll provide later on
LandClick1 <- function(n) {
  # Open url
  remDr$navigate(n)
  Sys.sleep(0.5)
  # Navigate with hyperlink in text(it's the same for all campaigns/links as they lead to the same offer page
  remDr$navigate("https://hyperlink.com/click")
  Sys.sleep(0.5)
}
# Further I put the vector with links I want to click through
links <- c("https://link.com/n=1",
           "https://link.com/fhs=156",
           "https://link.com/c=98")
# Inserting links to function one by one
sapply(links, LandClick1)

