# This script is designed to insert chosen data to Google Sheets automatically.
# Although it's not the fastest way to fill in the report, one can just launch it and deal with the other stuff while it's working.
# The main disadvantage of this script is it's dependency on certain data structure.
# All values are anchored to the relevant cells and if the order of values is changed, one should change the cells' positioning accordingly.

# Set up working directory
setwd("C:/Users/Input")
library(dplyr)
library(RSelenium)
library(googlesheets)
library(xlsx)
library(stringr)
# Open a Chrome browser
driver<- rsDriver(browser = "chrome")
remDr <- driver[["client"]]
Sys.sleep(2)
# Insert OATH tokens to navigate in google sheets
newAuth <- gs_auth(new_user = TRUE, cache = FALSE,
                   key = "insert_your_key_here",
                   secret = "insert_your_secret_here")
# Go to your google sheets where script will insert the data
remDr$navigate("https://insert_your_link_here")
URL <- gs_url("https://insert_your_link_here")
# Open the input file and prepare the data
data <- read.csv("LTD report.csv", sep=",")
# Fix data types
data$Country <- as.character(data$Country)
data$Date <- as.Date(data$Date)
#Insert Dates and create samples for each weekday
Monday <- as.Date("2020-11-16")
Tuesday <- as.Date(Monday+1)
Wednesday <- as.Date(Monday+2)
Thursday <- as.Date(Monday+3)
Friday <- as.Date(Monday+4)
Mon <- data[(data$Date==Monday),]
Tue <- data[(data$Date==Tuesday),]
Wed <- data[(data$Date==Wednesday),]
Thu <- data[(data$Date==Thursday),]
Fri <- data[(data$Date==Friday),]
#Create Week sample
Week<-rbind(Mon, Tue, Wed, Thu, Fri)
#Create a pivot (for the week in this case) with list of countries and their LTD values
data2 <- group_by(Week, Country)
pivot <- summarize(data2,
                   LTD = sum(Deposit)/sum(Leads)
)
pivot$Country<- as.character(pivot$Country)
# Round Values to 2 digits
pivot$LTD<- round(pivot$LTD,2)
# Prepere the other set of data
Yesterday <- "2020-11-19"
Yfilter <- str_detect(data$Date, Yesterday)
Ydata <- filter(data, Yfilter)
Ydata$Country<-as.character(Ydata$Country)
Ydata<-left_join(Ydata, pivot, by='Country')
# Start inserting each value one by one to googlesheets
ZA <- Ydata[(Ydata$Country=="South Africa"),5] #Search for value in the prepared df 
gs_edit_cells(URL, input=ZA, anchor="E3") # Insert this value to corresponding cell
ZA <- Ydata[(Ydata$Country=="South Africa"),7] # Do it for every value that should be inserted to google sheet
gs_edit_cells(URL, input=ZA, anchor="F3") 
DE <- Ydata[(Ydata$Country=="Germany"),5]
gs_edit_cells(URL, input=DE, anchor="E4")
DE <- Ydata[(Ydata$Country=="Germany"),7]
gs_edit_cells(URL, input=DE, anchor="F4")
