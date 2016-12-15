# Exploratory Data Analysis - Week 4 - Q. #5

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Load ggplot2 library
library(ggplot2)

# Load the datasets from local machine  (DataLoad.R loaded and unzipped them)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



# Get the vehicle-related data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
baltimoreVehicles <- vehiclesNEI[vehiclesNEI$fips=="24510",]

# Create PNG in the current directory 
png("plot5.png",width=480,height=480,units="px",bg="transparent")


ggp <- ggplot(baltimoreVehicles,aes(x=factor(year),y=Emissions)) + 
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) + 
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission in Tons")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions for Baltimore - 1999-2008"))
print(ggp)

dev.off()