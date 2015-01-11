# Plot 1
# Beginning of Excercise one
# Requires R version greater than 3.02
#
# Various test code some of which will bes used for final plotting
#
# Data Location (As Provided by COurse assignment)
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
require("chron")

# ## read in date/time info in format 'm/d/y h:m:s'
# ## 
# dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
# times <- c("23:03:00", "22:29:00", "01:03:00", "18:21:00", "16:56:00")
# x <- paste(dates, times)
# strptime(x, "%m/%d/%y %H:%M:%S")

myWD <- "J:/coursera/ExploreData/EXData_Plotting1"
setwd(myWD)
getwd()


dataDir <- "../data"# referenced to the current directory
subDir  <- "data"
mainDir <-  "J:/coursera/ExploreData"

# If my Data directory for the 129MB files does not exist -- create it...

if (!file.exists(dataDir)) {
    dir.create(file.path(mainDir, subDir))
    }

#
# The zip file plus the extracted text exceed the size of a free GitHub acct. 
# So the data is stored external to the project files and only a small extract is taken.
# 
#
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "../data/exdata_data_household_power_consumption.zip"
td <- "../data"
download.file(downloadURL, destFile)

# get the name of the first file in the zip archive
fname = unzip(destFile, list=TRUE)$Name[1]
# unzip the file to the temporary directory
unzip(destFile, files=fname, exdir=td, overwrite=TRUE)
# fpath is the full path to the extracted file
myFile <- file.path(td, fname)



colnames = colnames(read.table(myFile, nrow = 1, header = TRUE, sep=";"))

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# Dates provided as per assignment...
date_f1 <- "2006-12-16 17:24:00"
date_r1 <- "2007-02-01 00:00:00"
date_r2 <- "2007-02-03 00:00:00"
myMins <- difftime(date_r1,date_f1,units='mins') #, format="%M")
as.numeric(myMins)

rows_to_skip <- as.numeric(myMins) +1
rows_to_read <- (24*60*2)  # 24 hr/day, 60 min/nr 2 days

myPower <- read.table(myFile, 
                      header=F, col.names = colnames, sep=";", 
                      skip= rows_to_skip, nrows=rows_to_read, 
                      stringsAsFactors=F)
head(myPower,3)
tail(myPower,3)
str(myPower)

myPower2 <- myPower
xx <- as.Date(strptime(myPower2$Date, "%d/%m/%Y"))
myPower2 <- cbind(myPower2,Date1=xx)
myPower2$day <- strftime(as.Date(myPower2$Date1), format = "%a")

# End of Data inport
# --------------------

# Plot Region 

# Start Plot 1
# ------------

png("plot1.png", width = 480, height = 480)
hist(myPower$Global_active_power,col="red", main="Global Active Power",xlab="Global Active Power (killowatts) ")
axis(side=2, at=seq(0, 1200, by=200))
dev.off()

