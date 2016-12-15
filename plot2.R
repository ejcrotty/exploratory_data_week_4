# Exploratory Data Analysis - Week 4 - Q. #2


# Loading provided datasets from current directory
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")


# Subset data and append two years in one data frame
BAL <- subset(NEI, fips=='24510')

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Generate the graph in the current directory 
png(filename='./plot2.png')

# make another barplot
barplot(tapply(X=BAL$Emissions, INDEX=BAL$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()