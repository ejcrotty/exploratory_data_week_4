# Exploratory Data Analysis - Week 4 - Q. #3

# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these 
# four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


# Load the datasets from local machine  (DataLoad.R loaded and unzipped them)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Grab the Balitmore fips metric - Load into BAL 
BAL <- subset(NEI, fips=='24510')


# Create plot3.png using the ggplot2 library
library(ggplot2)

# Generate the graph in the current directory 
png("plot3.png",width=480,height=480,units="px",bg="transparent")


ggp <- ggplot(BAL,aes(factor(year),Emissions,fill=type)) + 
  geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE) +
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions for Baltimore 1999-2008 - by type"))
print(ggp)

dev.off()