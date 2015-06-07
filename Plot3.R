## Downloading the data and loading it into R
if(!file.exists("./data")) {dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./data/power_consumption.zip")
unzip("./data/power_consumption.zip")
df<-read.table("./household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,colClasses=c("character","character",rep("numeric",7)))

## Loading the required libraries
library(lubridate)
library(dplyr)

## Subsetting the df to the required date range
df<-filter(df,Date == "1/2/2007" | Date == "2/2/2007")

## Converting the Date and Time columns from character vectors to date and time classes and combining them into a timestamp column
df$Date<-dmy(df$Date)
df$Time<-hms(df$Time)
df$Timestamp<-df$Date + df$Time
df$Weekday<-format(df$Timestamp,"%a")

## Opening the graphics device (png - file)
png("plot3.png", width = 600, height = 600)

## Plotting the graph
plot(df$Timestamp,df$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(df$Timestamp,df$Sub_metering_2,col="red")
lines(df$Timestamp,df$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))

## Closing the graphics device connection
dev.off()