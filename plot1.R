# Code to construct plot1.png for question 1
# Assumes that the dataset needed for this plot is already in working directory

# Reading data from files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)

# Plotting to png in current working directory
png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total US" ~ PM[2.5] ~ "Emissions per year"), col="Blue")
dev.off()