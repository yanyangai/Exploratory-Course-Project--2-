# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

# Set the working directory to the local clone of my repository #
setwd("C:/Users/PDAUSER/Desktop/Exploratory-Data-Analysis")

# Install Necessary Packages #
install.packages(c("dplyr"))
library(dplyr)

# First read in the data #
NEI <- readRDS("summarySCC_PM25.rds")

# Then sum the PM25 emissions by year and filter it to include Baltimore only #
plot2.dat <- NEI %>%
        group_by(year) %>%
        filter(fips == "24510") %>%
        summarize(PM25 = sum(Emissions)) 

# Finally, create a barplot for Baltimore #
dev.copy(png,"plot2.png",height=480,width=640)
barplot(height = plot2.dat$PM25,        
        names.arg = plot2.dat$year,
        col="red",
        main = "PM 2.5 Emissions in Baltimore City, Maryland (1999 - 2008)",
        ylab = "PM 2.5 emissions from all sources (tons)",
        xlab = "Year")
dev.off()
        