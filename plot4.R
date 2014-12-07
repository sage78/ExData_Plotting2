### Source data downloaded 4th Dec 2014 20:47 from 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 
###
### Contents:
### - Source_Classification_Code.rds
### - summarySCC_PM25.rds

### QUESTION: Across the United States, how have emissions from coal 
### combustion-related sources changed from 1999-2008?

# required libraries
library(ggplot2)

# read in the data
codes <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# select SCCs that are coal combustion related
sccs <- as.character(codes[grep(".*Comb.*Coal.*", codes$Short.Name),]$SCC)
coaldata <- subset(NEI, SCC %in% sccs)

# sum emissions by year
sumdata <- aggregate(Emissions ~ year, coaldata, sum)

# plot emissions over years, add linear model for visualizing trend
myplot <- qplot(year,
      Emissions,
      data=sumdata,
      geom=c("point", "smooth"),
      method="lm",
      main="Total PM2.5 emissions in US from coal combustion-related sources",
      xlab="Year",
      ylab="PM2.5 emission (tons)")

# save to plot4.png
ggsave("plot4.png", myplot)