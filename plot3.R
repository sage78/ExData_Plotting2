### Source data downloaded 4th Dec 2014 20:47 from 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 
###
### Contents:
### - Source_Classification_Code.rds
### - summarySCC_PM25.rds

### QUESTION: Of the four types of sources indicated by the type 
### (point, nonpoint, onroad, nonroad) variable, which of these 
### four sources have seen decreases in emissions from 1999-2008 
### for Baltimore City? Which have seen increases in emissions 
### from 1999-2008? Use the ggplot2 plotting system to make a 
### plot answer this question.

# required libraries
library(ggplot2)

# read in the data
NEI <- readRDS("summarySCC_PM25.rds")

# subset data to Baltimore City, Maryland (fips == "24510")
NEI <- subset(NEI, fips == "24510")

# sum emissions on years and types (emissions are stored in column x)
yearsums <- aggregate(NEI$Emissions, 
			    by=list(year=NEI$year,type=NEI$type), 
			    FUN=sum)

# plot emissions over years, add a smooth linear model for visualizing trend
myplot <- qplot(year, 
      x, 
      data=yearsums, 
      facets = . ~ type, 
      geom=c("point", "smooth"), 
      method="lm", 
      main="Total PM2.5 emissions in the Baltimore City, by type", 
      xlab="Year", 
      ylab="PM2.5 emission (tons)")

# save to plot3.png
ggsave("plot3.png", myplot)