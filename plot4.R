

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
## Plot4 
########################################################

par(mfcol=c(2, 2), mar=c(4,4,2,1))

plot(consumption$DateTime, consumption$Global_active_power, frame.plot = T, xlab = "", ylab = "Global Active Power", type = "l")

plot(consumption$DateTime, consumption$Sub_metering_1, frame.plot = T, xlab = "", ylab = "Energy sub metering", type = "l")
lines(consumption$DateTime, consumption$Sub_metering_2, col = "red")
lines(consumption$DateTime, consumption$Sub_metering_3, col = "blue")
legend(legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),"topright", col=c("black", "red", "blue"), lwd=2, cex = 0.5, text.font = 2)

plot(consumption$DateTime, consumption$Voltage, frame.plot = T, xlab = "datetime", ylab = "Voltage", type = "l")

plot(consumption$DateTime, consumption$Global_reactive_power, frame.plot = T, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


