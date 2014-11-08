## Warning: this script doesn't download the data for you
## get it from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## extract to ./data/ in you working directory

## This script creates a bar chart showing total Emissions of PM 2.5  
## from motor vehicle sources 
## from year 1999 to 2008 using base plot

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## get motor vehicle related SCC code from SCC data
pos <- grep("Vehicle", SCC$EI.Sector)
motorSCC <- SCC[pos,1]
motorSCC <- as.character(motorSCC)

## get motor vehicle only data from NEI
NEIbalt <- NEI[NEI$fips == "24510",]
NEImotor <- subset(NEIbalt, SCC %in% motorSCC)

NEImotorAgg <- aggregate(NEImotor$Emissions, list(year=NEImotor$year), sum)

barplot(NEImotorAgg$x, 
        names.arg = c("1999", "2002", "2005", "2008"), 
        xlab="Year", ylab="Total PM2.5 Emissions")
title("PM2.5 Emissions From Motor Vehicle In Baltimore")

## output to png file
dev.copy(png, file="plot5.png", width=650)
dev.off()