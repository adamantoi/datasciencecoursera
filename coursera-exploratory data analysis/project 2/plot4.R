## Warning: this script doesn't download the data for you
## get it from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## extract to ./data/ in you working directory

## This script creates a bar chart showing total Emissions of PM 2.5  
## from coal combustion-related sources 
## from year 1999 to 2008 using base plot

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## get Coal related SCC code from SCC data
pos <- grep("Coal", SCC$EI.Sector)
coalSCC <- SCC[pos, 1]
coalSCC <- as.character(coalSCC)

## get Coal only data from NEI
NEIcoal <- subset(NEI, SCC %in% coalSCC)
NEIcoalAgg <- aggregate(NEIcoal$Emissions, list(year = NEIcoal$year), sum)

## plot
barplot(NEIcoalAgg$x, 
        names.arg = c("1999", "2002", "2005", "2008"), 
        xlab="Year", ylab="Total PM2.5 Emissions")
title("PM2.5 Emissions From Coal In United State")

## output to png file
dev.copy(png, file="plot4.png", width=650)
dev.off()