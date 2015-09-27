# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

# Read in data and source code files from local directory
NEI <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/Source_Classification_Code.rds")

# Select Coal-related SCC
SCC_coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merge NEI and SCC_coal data by SCC ID
merge <- merge(x = NEI, y = SCC_coal, by = 'SCC')
merge_sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge_sum) <- c('Year', 'Emissions')

# Make the plot
png(filename = 'plot4.png', width = 900, height = 600, units = 'px')
ggplot(merge_sum, aes(x = Year, y = Emissions / 1000000)) + 
        geom_line(aes(group = 1, col = Emissions)) + 
        geom_point(aes(size = 2, col = Emissions)) + 
        ggtitle(expression(paste('Total Emission of PM'[2.5], ' from Coal Combustion-related Sources in the United States from 1999 to 2008'))) + 
        ylab(expression(paste('Emission PM', ''[2.5], "10^6", ' in Kilotons'))) +
        theme(legend.position = 'none')
dev.off()


