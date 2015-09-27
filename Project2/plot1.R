# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# Read in data and source code files from local directory
NEI <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/Source_Classification_Code.rds")

# Check for missing observations
NEI[!complete.cases(NEI),]  # [1] fips SCC  Pollutant Emissions type year     
                            # <0 rows> (or 0-length row.names)
                            # so no need to omit.na

# Check for number of observations
str(NEI)  # 6497651

# Aggregate by year and calculate the average emmision
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), sum)
Emissions$PM2.5 <- round(Emissions$x, 2)

# Make the plot in base
png(filename = "plot1.png")
barplot(Emissions$PM2.5/1000000, names.arg = Emissions$Group.1, 
        main = expression(paste('Total Emission of PM'[2.5], ' in the United States from 1999 to 2008')), 
        xlab = 'Year', 
        ylab = expression(paste('PM', ''[2.5], "10^6", ' in Kilotons')))
dev.off()
