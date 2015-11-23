# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# Using the base plotting system, I made a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

# Set the working directory to the local clone of my repository #
setwd("C:/Users/PDAUSER/Desktop/Exploratory-Data-Analysis")

# Install Necessary Packages #
install.packages(c("dplyr"))
library(dplyr)

# First I read in the data #
NEI <- readRDS("summarySCC_PM25.rds")

# Then I summed the PM25 emissions by year #
plot1.dat <- NEI %>%
        group_by(year) %>%
        summarize(PM25 = sum(Emissions))

# Finally, I turned off the scientific notation option and created the plot #
getOption("scipen")
opt <- options("scipen" = 20)
getOption("scipen")

barplot(height = plot1.dat$PM25,        
        names.arg = plot1.dat$year,
        col="red",
        main = "PM 2.5 Emissions (1999 - 2008)",
        ylab = "PM 2.5 emissions from all sources (tons)",
        xlab = "Year")
dev.copy(png,"plot1.png",height=480,width=480)
dev.off()
options(opt)
