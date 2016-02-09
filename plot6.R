# Code to construct plot6.png for question 6
# Assumes that the dataset needed for this plot is already in working directory

library(ggplot2)
library(plyr)
library(grid)

# Reading data from files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking the levels for types of vehicles defined
mv.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
mv.sourcec <- SCC[SCC$EI.Sector %in% mv.sourced, ]["SCC"]

# Subsetting our data Baltimore City
emMV.ba <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "24510", ]

# Subsetting our data Los Angeles County
emMV.LA <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "06037", ]

# Binding the data created in steps above
emMV.comb <- rbind(emMV.ba, emMV.LA)
  
# Finding the emmissions due to motor vehicles in Baltimore and Los Angeles
tmveYR.county <- aggregate (Emissions ~ fips * year, data =emMV.comb, FUN = sum ) 
tmveYR.county$county <- ifelse(tmveYR.county$fips == "06037", "Los Angeles", "Baltimore")

# Plotting to png in current working directory
png("plot6.png", width=750)
print(qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions")))
dev.off()