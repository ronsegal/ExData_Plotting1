

########################################################
## Download the data source file and read-in the data 
########################################################

require(lubridate)
setwd('/home/ron/Coursera/EDanal/week1')

## If data file doesn't already exist, download and unzip the dataset source file 
if (!file.exists("household_power_consumption.txt"))
{
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="dataset.zip",method="wget") # NB - wget rather than curl on my Linux system 
    unzip(zipfile="dataset.zip",exdir="./")
}

########################################################
## Convert Date and Time to DateTime 
########################################################

#setClass('myDate')
#setAs("character","myDate", function(from) parse_date_time(from, "dmy"))
    
cols <- c('character','character','numeric','numeric','numeric','numeric','factor','factor','factor')

colnms <- c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity','Sub_metering_1','Sub_metering_2','Sub_metering_3')

# import only date range of interest into data frame - works on Linux system at least

consumption <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),sep=";", na.strings="?", col.names=colnms)

# Combine Date and Time character columns and parse into datetime type
datetime <- parse_date_time(paste(consumption$Date,consumption$Time), "dmyhms");

consumption$DateTime <- datetime #add new datetime column

########################################################
## Plot1 
########################################################

hist(consumption$Global_active_power, main="Global Active Power", col="red", density=100,xlab = "Global Active Power (kilowatts)", ylab="Frequency")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

