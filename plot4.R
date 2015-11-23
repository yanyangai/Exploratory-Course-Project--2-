# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008? #

# Set the working directory to the local clone of my repository #
setwd("C:/Users/PDAUSER/Desktop/Exploratory-Data-Analysis")

# Install Necessary Packages #
install.packages(c("dplyr","ggplot2"))
library(dplyr)
library(ggplot2)

# First read in the data #
NEI <- readRDS("summarySCC_PM25.rds")

# Find all the coal combustion-related sources of emissions using grep #
coal <- as.character(SCC$SCC[grep("Coal",x=SCC$Short.Name)])

# Create the dataset for the plot #
plot4.dat <- NEI %>%
        group_by(year) %>%
        filter(SCC %in% coal) %>%
        summarize(PM25 = sum(Emissions))
plot4.dat$year <- as.factor(plot4.dat$year)

# plot the subset of PM 2.5 Emissions caused by coal combustion-related sources #
barplot(height = plot4.dat$PM25,        
        names.arg = plot4.dat$year,
        col="red",
        main = "Coal Combustion-Related PM 2.5 Emissions (1999 - 2008)",
        ylab = "PM 2.5 emissions (tons)",
        xlab = "Year")
dev.copy(png,"plot4.png",height=480,width=640)
dev.off()

