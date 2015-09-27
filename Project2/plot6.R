# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Read in data and source code files from local directory
NEI <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/my_coursera2/ExData_Plotting2/exdata-data-NEI_data/Source_Classification_Code.rds")

# Define years as categorical variable
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Subset Baltimore City, MD fips = 24510, Los Angeles County, CA fips = 06037
# and motor vehicle sources type = ON-ROAD for each city
MD_onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA_onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Get total emisison by year and create a data frame for each city
MD_df <- aggregate(MD_onroad[, 'Emissions'], by = list(MD_onroad$year), sum)
colnames(MD_df) <- c('year', 'Emissions')
MD_df$City <- paste(rep('MD', 4))

CA_df <- aggregate(CA_onroad[, 'Emissions'], by = list(CA_onroad$year), sum)
colnames(CA_df) <- c('year', 'Emissions')
CA_df$City <- paste(rep('CA', 4))

# row bind the city data frames
MD_CA_df <- as.data.frame(rbind(MD_df, CA_df))
MD_CA_df$Emissions <- round(MD_CA_df$Emissions, 0)

png('plot6.png', width = 900, height = 600, units = 'px')
ggplot(MD_CA_df, aes(x = year, y = Emissions)) + 
        geom_bar(aes(fill = City), stat = "identity")  + 
        ggtitle(expression(paste('Total Emission of PM'[2.5], ' from Motor Vehicles in Baltimore City, MD and Los Angeles, CA 1999 - 2008'))) + 
        ylab(expression(paste('Total emission PM', ''[2.5], ' in Kilotons'))) + 
        xlab('Year') + 
        theme(legend.position = c(0.9, 0.8)) + 
        facet_grid(. ~ City) +
        theme(legend.position = 'none')
dev.off()

 
