# This script provides .csv output containing a non-formatted pivot table with several groupings
# The output will present a summary on Managers' KPIs divided by traffic sources they use.
# The tricky part is that different Managers can work with the same Traffic Source and we should calculate 
# all data considering this issue.
library(stringr)
library(dplyr)
library(devtools)
library(lubridate)
library(formattable)
# Set up working directory for input
setwd("C:/Users/Input")
# Open input data from comma-separated .csv file
data <-read.csv("Data.csv", sep=",")
# Convert Factor variables to strings|character variables(in my case Campaign var)
data$Campaign <- as.character(data$Campaign)
#Writing easy function "AutoDaily1" that takes in Traffic Source names as an argument and does rest of the work.
AutoDaily1 <-function(n){
  filterPrp <- str_detect(OSNetw$Campaign,n) #Filters Manager's dataset by network
  Prpdata <- filter(OSNetw, filterPrp)# Applies filter
  #Calculates Cost, Leads, Deposits(Actions), Revenue, Profit ROI for every Traffic Source 
  #and applies it to the table 1 by 1
  dt<-matrix(c(format(sum(as.numeric(Prpdata$Cost)), decimal.mark = ","),
               sum(as.numeric(Prpdata$Leads)),
               sum(as.numeric(Prpdata$Deposit)),
               format((sum(as.numeric(Prpdata$Revenue))-sum(as.numeric(Prpdata$Cost)))/sum(as.numeric(Prpdata$Cost)), decimal.mark = ","),
               sum(as.numeric(Prpdata$Revenue)), 
               format((sum(as.numeric(Prpdata$Revenue))-sum(as.numeric(Prpdata$Cost))), decimal.mark = ",")), 
             ncol=1, byrow=T)  
  return(dt)
}
############
#Using function
#First, filter the basic input by particular Manager and create sample for that Manager
OSFilter <- str_detect(data$Campaign, "MG") #MG here is the initials we search for.
OSNetw <- filter(data, OSFilter==TRUE) # Only data containing initials "MG" will be filtered to sample
#Form the First Column 
dt<-AutoDaily1("TrafficSource1")
dt<-as.data.frame(dt)
colnames(dt)<-"TrafficSource1"
#Define rownames
rownames(dt)<-c("Cost", "Leads",  "FTDs", "ROI", "Revenue", "Profit")
#As Traffic Sources are predefined, list them in vector. You can use as many TS's as you need. 
OS<-c("TrafficSource2",	"TrafficSource3", "TrafficSource4", "TrafficSource5")
#Function will be gradually applied to every listed TS.
dt<-cbind(dt, sapply(OS,AutoDaily1))
#Add an empty column to divide different Managers
dt$Empty1<-""
############
#Repeat script for every Manager
OSFilter <- str_detect(data$Campaign, "GM")
OSNetw <- filter(data, OSFilter==TRUE)

DC<-c("TrafficSource2",	"TrafficSource3", "TrafficSource4", "TrafficSource5")# Although we search for the same TS,
# results will be different, as far as we're using the other data sample "GM"
dt<-cbind(dt, sapply(DC,AutoDaily1))
dt$Empty3<-""
# Choose working directory for the Output (step may be ommited)
setwd("C:/Users/Outputs")
#Write down simple .csv table
write.table(dt, "Output.csv", row.names = TRUE, col.names=TRUE, sep=';', dec = ".")

#Save ordinary pic
formattable(dt, #use dataset
            align =c("c","c","c","c","c", "c", "c", "c", "c"), # col alignment l - left, c - center, r - right
            list(`Indicator Name` = formatter(#list of formatting instructions
              "span", style = ~ style(color = "grey",font.weight = "bold")) 
            ))

