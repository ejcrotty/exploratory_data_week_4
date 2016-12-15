# Exploratory Data Analysis - Week 4 - Q. #6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?


# Load the datasets from local machine  (DataLoad.R loaded and unzipped them)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")


# Get the vehicle-related data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Baltimore and Los Angeles fips and combine
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# use ggplot2
library(ggplot2)
# Create PNG in the current directory 
png("plot6.png",width=480,height=480,units="px",bg="transparent")


ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) + geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) + guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission in Tons")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions for Baltimore and LA - 1999-2008"))

print(ggp)

dev.off()