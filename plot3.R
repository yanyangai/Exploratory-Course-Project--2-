# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?

# Set the working directory to the local clone of my repository #
setwd("C:/Users/PDAUSER/Desktop/Exploratory-Data-Analysis")

# Install Necessary Packages #
install.packages(c("dplyr","ggplot2"))
library(dplyr)
library(ggplot2)

# First read in the data #
NEI <- readRDS("summarySCC_PM25.rds")

# Then sum the PM25 emissions by year and source and filter them to include Baltimore only #
plot3.dat <- NEI %>%
        group_by(year, type) %>%
        filter(fips == "24510") %>%
        summarize(PM25 = sum(Emissions))
plot3.dat$year <- as.factor(plot3.dat$year)


# Plot Emissions by type then facet it by year #
ggplot(data = plot3.dat,
      aes(x = year,
      y = PM25))+
        geom_bar(fill="dark red", stat = "identity", alpha = .85)+
        facet_wrap(~type,ncol=2)+
        xlab("Year")+
        ylab("PM 2.5 Emissions (tons)")+
        ggtitle("PM 2.5 Emissions in Baltimore by type (1999-2008)")+
        theme(plot.title = element_text(vjust = .8,face="bold"))
dev.copy(png,"plot3.png",height=640,width=640)
dev.off()


