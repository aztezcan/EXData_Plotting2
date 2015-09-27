# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Read in data and source code files from local directory
NEI <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/summarySCC_PM25.rds")

# Define years as categorical variable
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Subsets data for MD fips = 24510 and select type = ON-ROAD 
MD_onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Group emission by type and find mean
MD_On=
        MD_onroad %>%
        group_by(year) %>% 
        summarise(avgEm = mean(Emissions))

# Make the plot to represent the change over the years
png('plot5.png', width = 800, height = 500, units = 'px')
ggplot(MD_On, aes(x = year, y = avgEm)) + 
        geom_line(aes(group = 2)) + 
        ggtitle(expression(paste('Average Emission of PM'[2.5], ' from Motor Vehicles in Baltimore City, MD 1999 - 2008'))) + 
        ylab(expression(paste('Average emission PM', ''[2.5], ' in Kilotons'))) +
        theme(legend.position = 'none')
dev.off()