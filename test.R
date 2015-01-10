# Beginning of Excercise one
#
# Various test code some of which will bes used for final plotting
#
# Data Location
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
#require("lubridate")
require("chron")
## read in date/time info in format 'm/d/y h:m:s'
dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
times <- c("23:03:00", "22:29:00", "01:03:00", "18:21:00", "16:56:00")
x <- paste(dates, times)
strptime(x, "%m/%d/%y %H:%M:%S")



setwd("J:/coursera/ExploreData/EXData_Plotting1")
myFile <- "../data/household_power_consumption.txt"
colnames = colnames(read.table(myFile, nrow = 1, header = TRUE, sep=";"))

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
date_f1 <- "2006-12-16 17:24:00"

date_r1 <- "2007-02-01 00:00:00"
date_r2 <- "2007-02-03 00:00:00"
myMins <- difftime(date_r1,date_f1,units='mins') #, format="%M")
as.numeric(myMins)

rows_to_skip <- as.numeric(myMins) +1
rows_to_read <- (24*60*2)  # 24 hr/day, 60 min/nr 2 days

#myPower <- read.table("data/household_power_consumption.txt", sep=";", header=T)
rm(myPower)
#myPower <- read.table("data/household_power_consumption.txt", 
myPower <- read.table(myFile, 
                      header=F, col.names = colnames, sep=";", 
                      skip= rows_to_skip, nrows=rows_to_read, 
                      stringsAsFactors=F)
head(myPower,3)
tail(myPower,3)
str(myPower)
min(myPower$Sub_metering_1)
max(myPower$Sub_metering_1)
min(myPower$Sub_metering_2)
max(myPower$Sub_metering_3)
min(myPower$Sub_metering_3)
max(myPower$Sub_metering_3)

#png("D:/temp/graph3.png")
#hist(read)
#dev.off()
png("myGraph1.png")
hist(myPower$Global_active_power,col="red", main="Global Active Power",xlab="Global Active Power (killowatts) ")
axis(side=2, at=seq(0, 1200, by=200))
dev.off()

#box()

