# Code to construct plot2.png for question 2
# Assumes that the dataset needed for this plot is already in working directory

# Reading data from files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting only Baltimore's NEI data
baltimore <- subset(NEI, fips=="24510")
tot.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

# Plotting to png in current working directory
png("plot2.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total for Baltimore" ~ PM[2.5] ~ "Emissions per year"), col="Blue")
dev.off()