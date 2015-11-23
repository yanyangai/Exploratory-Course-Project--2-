# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

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
plot6.dat <- NEI %>%
        group_by(year,fips) %>%
        filter(fips %in% c("24510","06037"),
               SCC %in% motor) %>%
        summarize(PM25 = sum(Emissions))
plot6.dat$year <- as.factor(plot6.dat$year)
plot6.dat$fips <- as.factor(plot6.dat$fips)
levels(plot6.dat$fips) <- c("Los Angeles County","Baltimore City")

# Create plot #
ggplot(data = plot6.dat,
       aes(x = year,
           y = PM25))+
        geom_bar(fill="dark red", stat = "identity", alpha = .65)+
        facet_grid(.~fips)+
        xlab("Year")+
        ylab("PM 2.5 Emissions (tons)")+
        ggtitle("PM 2.5 Emissions from Motor Vehicles (1999-2008)")+
        theme(plot.title = element_text(vjust = .8,face="bold"))
dev.copy(png,"plot6.png",height=480,width=640)
dev.off()

