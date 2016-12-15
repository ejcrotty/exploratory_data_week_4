# Exploratory Data Analysis - Week 4 - Q. #4

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?


# Load the datasets from local machine  (DataLoad.R loaded and unzipped them)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")


# Find coal combustion-related sources
is.combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[is.combustion.coal,]

# Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

# group by year
emissions.by.year <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

# plot using ggplot 
library(ggplot2)

# Generate the graph in the current directory 
png("plot4.png")

ggp <- ggplot(emissions.by.year, aes(x=factor(year), y=Emissions/1000)) +
  geom_bar(stat="identity") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Kilotons)")) +
  ggtitle("US Emissions from coal combustion-related sources")

print(ggp)

dev.off()