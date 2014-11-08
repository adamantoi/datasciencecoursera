## this script won't download the data file for you
## download and extract the zip file to ./data directory in you working directory
## data url: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## this script assume you have household_power_consumption.txt in ./data directory

## tidy data
library(dplyr)
data <- read.csv("./data/household_power_consumption.txt", stringsAsFactors=F, sep = ";")
data <- filter(data, Date=="1/2/2007" | Date=="2/2/2007")
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data$TD <- strptime(paste(data$Date, data$Time, sep=","),
                    format="%d/%m/%Y, %H:%M:%S")  

## plot histogram
par(mfrow = c(1,1),oma=c(1,1,1,0))
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     col="red",cex.lab=0.8, cex.axis=0.8)

## output to png file
dev.copy(png, file="plot1.png")
dev.off()