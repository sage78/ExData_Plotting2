### Source data downloaded 4th Dec 2014 20:47 from 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 
###
### Contents:
### - Source_Classification_Code.rds
### - summarySCC_PM25.rds

### QUESTION: How have emissions from motor vehicle sources changed 
### from 1999-2008 in Baltimore City?

# required libraries
library(ggplot2)

# read in the data
codes <- readRDS("Source_Classification_Code.rds")
emissiondata <- readRDS("summarySCC_PM25.rds")

# subset data to Baltimore City, Maryland (fips == "24510")
emissiondata <- subset(emissiondata , fips == "24510")

# select SCCs that are motor vehicle releated sources
sccs <- as.character(codes[grep(".*Veh.*", codes$Short.Name),]$SCC)
emissiondata <- subset(emissiondata , SCC %in% sccs)

# sum emissions by year
sumdata <- aggregate(Emissions ~ year, emissiondata, sum)

# plot emissions over years, add linear model for visualizing trend
myplot <- qplot(year,
      Emissions,
      data=sumdata,
      geom=c("point", "smooth"),
      method="lm",
      main="Total PM2.5 emissions in Baltimore City from motor vehicle sources",
      xlab="Year",
      ylab="PM2.5 emission (tons)")

# save to plot5.png
ggsave("plot5.png", myplot)