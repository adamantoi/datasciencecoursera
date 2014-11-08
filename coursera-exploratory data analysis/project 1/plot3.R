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

## plot line multivariate
par(mfrow = c(1,1),oma=c(0,1,0,0))
plot(data$TD,data$Sub_metering_1, type="l", ylab="Energy Sub Metering",
     xlab="", cex.lab=0.8, cex.axis=0.8)
points(data$TD, data$Sub_metering_2, col="red", type="l")
points(data$TD, data$Sub_metering_3, col="blue", type="l")
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd="1",col=c("black", "red", "blue"), cex = 0.7)

## output to png file
dev.copy(png, file="plot3.png")
dev.off()