# Code to construct plot4.png for question 4
# Assumes that the dataset needed for this plot is already in working directory

library(ggplot2)
library(plyr)

# Reading data from files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting data for only coal-combustion
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs -    Coal"))
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

# Getting PM25 values
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

# Renaming column to Emissions
colnames(coalcomb.pm25year)[3] <- "Emissions"

# Plotting to png in current working directory
png("plot4.png")
print(qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)")))
dev.off()