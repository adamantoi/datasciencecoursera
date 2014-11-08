## Warning: this script doesn't download the data for you
## get it from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## extract to ./data/ in you working directory

## This script creates a bar chart showing total Emissions of PM 2.5 
## from year 1999 to 2008 in United State using base plot

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
##SCC <- readRDS("./data/Source_Classification_Code.rds")

## summing all emission base on each year
NEIagg <- aggregate(NEI$Emissions, list(year=NEI$year), sum)

## create base plot bar chart
barplot(NEIagg$x, 
        names.arg = c("1999", "2002", "2005", "2008"), 
        xlab="Year", ylab="Total PM2.5 Emissions")
title("PM2.5 Emissions In United State")

## output to png file
dev.copy(png, file="plot1.png")
dev.off()