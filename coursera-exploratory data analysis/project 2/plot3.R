## Warning: this script doesn't download the data for you
## get it from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## extract to ./data/ in you working directory

## This script creates a bar chart showing total Emissions of PM 2.5 per type
## from year 1999 to 2008 in Baltimore City, Maryland using ggplot

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI$type <- as.factor(NEI$type)
## select baltimore data
NEIbalt <- NEI[NEI$fips == "24510",]

## create scatter plot
library(ggplot2)
qplot(year, Emissions, data = NEIbalt, facets = .~type, 
      geom =c("point","smooth"), method = "lm" )+ylim(0,100)

## output to png file
dev.copy(png, file="plot3.png", width=650)
dev.off()