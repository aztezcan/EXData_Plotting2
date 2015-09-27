# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system 
# to make a plot answer this question.

# Read in data and source code files from local directory
NEI <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/Source_Classification_Code.rds")

install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)

# Subsets data for MD fips = 24510
MD <- subset(NEI, fips == 24510)

# Group emission by type and year
MDGr =
        MD %>%
        group_by(type, year) %>% 
        summarise(avgEmission = mean(Emissions))


# Plot change in emission by year per group
png('plot3.png', width = 800, height = 500, units = 'px')
ggplot(MDGr, aes(x = year, y= avgEmission, group= type)) +
        geom_line(aes( color = type)) +
        ggtitle('Emission from Four Sources in Baltimore City, Maryland 1999 - 2008') +
        ylab(expression(paste('Average', ' PM'[2.5], ' Emission in Kilotons'))) +
        xlab('Year') +
        theme(legend.position = c(0.9, 0.8)) +
        labs(color='Source')
dev.off()


