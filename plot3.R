# Code to construct plot3.png for question 3
# Assumes that the dataset needed for this plot is already in working directory

library(ggplot2)
library(plyr)

# Reading data from files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting only Baltimore's NEI data
baltimore <- subset(NEI, fips=="24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

# Renaming column to Emissions
colnames(typePM25.year)[3] <- "Emissions"

# Plotting to png in current working directory
png("plot3.png")
print(qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by type and year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")))
dev.off()