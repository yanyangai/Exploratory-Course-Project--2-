# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Set the working directory to the local clone of my repository #
setwd("C:/Users/PDAUSER/Desktop/Exploratory-Data-Analysis")

# Install necessary packages #
install.packages(c("dplyr","ggplot2"))
library(dplyr)
library(ggplot2)

# First read in the data #
NEI <- readRDS("summarySCC_PM25.rds")

# Find all the motor vehicle-related sources of emissions using grep #
motor <- as.character(SCC$SCC[grep("Motor",x=SCC$Short.Name)])

# Create the dataset for the plot #
plot5.dat <- NEI %>%
        group_by(year) %>%
        filter(fips == "24510",
               SCC %in% motor) %>%
        summarize(PM25 = sum(Emissions))
plot5.dat$year <- as.factor(plot5.dat$year)

# plot the subset of PM 2.5 Emissions caused by motor vehicle-related sources #
barplot(height = plot5.dat$PM25,        
        names.arg = plot5.dat$year,
        col="red",
        main = "Motor Vehicle-Related PM 2.5 Emissions in Baltimore City (1999 - 2008)",
        ylab = "PM 2.5 emissions (tons)",
        xlab = "Year")
dev.copy(png,"plot5.png",height=480,width=720)
dev.off()
