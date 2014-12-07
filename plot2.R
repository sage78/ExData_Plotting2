### Source data downloaded 4th Dec 2014 20:47 from 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 
###
### Contents:
### - Source_Classification_Code.rds
### - summarySCC_PM25.rds

### QUESTION: Have total emissions from PM2.5 decreased in the Baltimore 
### City, Maryland (fips == "24510") from 1999 to 2008? Use the base 
### plotting system to make a plot answering this question.

## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")

# subset data to Baltimore City, Maryland (fips == "24510")
NEI <- subset(NEI, fips == "24510")

# calculate emissions sums per year
yearsums <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

# plot graph in plot2.png with linear model for visualizing trend
png(filename = "plot2.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12, 
    bg = "white")

plot(yearsums[[1]], 
     yearsums[[2]], 
     type="p", 
     main="Total PM2.5 emission from all sources in Baltimore City", 
     xlab="Year", 
     ylab="PM2.5 emission (tons)",
     pch=20)
abline(lm(yearsums[[2]] ~ yearsums[[1]]), col="blue")
legend("topright", col="blue", legend="trend", lty="solid")

dev.off()