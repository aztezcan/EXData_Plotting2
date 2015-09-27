# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Read in data and source code files from local directory
NEI <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/Source_Classification_Code.rds")

# Subsets data for MD fips = 24510
MD <- subset(NEI, fips == '24510')

# Aggregate by year and calculate the average emmision
EmissionMD <- aggregate(MD[, 'Emissions'], by = list(MD$year), sum)
EmissionMD$PM2.5 <- round(EmissionMD$x, 2)

# Make the plot 
png(filename = 'plot2.png')
barplot(EmissionMD$PM2.5, names.arg = EmissionMD$Group.1, 
        main = expression(paste('Total Emission of PM'[2.5], ' in Baltimore City, MD from 1999 to 2008')), 
        xlab = 'Year', 
        ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()



