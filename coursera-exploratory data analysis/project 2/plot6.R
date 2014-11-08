## Warning: this script doesn't download the data for you
## get it from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## extract to ./data/ in you working directory

## This script creates a bar chart showing total Emissions of PM 2.5  
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## get motor vehicle related SCC code from SCC data
pos <- grep("Vehicle", SCC$EI.Sector)
motorSCC <- SCC[pos,1]
motorSCC <- as.character(motorSCC)

## get motor vehicle only data from NEI for Baltimore and Los Angeles
NEIbalt <- NEI[NEI$fips == "24510",]
NEIcal <- NEI[NEI$fips == "06037",]
NEImotorBalt <- subset(NEIbalt, SCC %in% motorSCC)
NEImotorCal <- subset(NEIcal, SCC %in% motorSCC)

NEImotorBaltAgg <- aggregate(NEImotorBalt$Emissions, list(year=NEImotorBalt$year), sum)
NEImotorCalAgg <- aggregate(NEImotorCal$Emissions, list(year=NEImotorCal$year), sum)

## plot
par(mfrow = c(1,2), cex.lab=0.7, cex.axis=0.7, cex.main = 0.6)

## plot for baltimore
barplot(NEImotorBaltAgg$x, 
        names.arg = c("1999", "2002", "2005", "2008"), 
        xlab="Year", ylab="Total PM2.5 Emissions")
title("Motor Vehicle Emission In Baltimore")

## plot for California
barplot(NEImotorCalAgg$x, 
        names.arg = c("1999", "2002", "2005", "2008"), 
        xlab="Year", ylab="Total PM2.5 Emissions")
title("Motor Vehicle Emission In L.A")

## output to png file
dev.copy(png, file="plot6.png", width=650)
dev.off()