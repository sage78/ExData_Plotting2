### Source data downloaded 4th Dec 2014 20:47 from 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 
###
### Contents:
### - Source_Classification_Code.rds
### - summarySCC_PM25.rds

### QUESTION: Compare emissions from motor vehicle sources in Baltimore 
### City with emissions from motor vehicle sources in Los Angeles County, 
### California (fips == "06037"). Which city has seen greater changes 
### over time in motor vehicle emissions?

# required libraries
library(ggplot2)

# read in the data
codes <- readRDS("Source_Classification_Code.rds")
emissiondata <- readRDS("summarySCC_PM25.rds")

# subset data to 
# - Baltimore City, Maryland (fips == "24510") and
# - Los Angeles County, California (fips == "06037")
emissiondata <- subset(emissiondata , fips %in% c("24510", "06037"))

# map numeric fips to textual names (adds column county to emissiondata)
emissiondata$county <- sapply(emissiondata$fips, 
	function(x) { 
		if(x == "24510") "Baltimore City, Maryland" 
		else if(x == "06037") "Los Angeles County, California"
		else "unknown"
	})

# select SCCs that are motor vehicle releated sources
sccs <- as.character(codes[grep(".*Veh.*", codes$Short.Name),]$SCC)
emissiondata <- subset(emissiondata , SCC %in% sccs)

# sum data by years and counties (emissions are stored in column x)
yearsums <- aggregate(emissiondata$Emissions, 
			    by=list(year=emissiondata$year, county=emissiondata$county), 
			    FUN=sum)

# plot emissions over years by county, add linear model for visualizing trend
myplot <- qplot(year, 
      x, 
      data=yearsums, 
      facets = . ~ county, 
      geom=c("point", "smooth"), 
      method="lm", 
      main="Total PM2.5 emissions from motor vehicle sources", 
      xlab="Year", 
      ylab="PM2.5 emission (tons)")

# save to plot6.png
ggsave("plot6.png", myplot)