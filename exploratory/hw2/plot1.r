# load libraries
library(plyr)

# setup workspace
source('~/dev/datasciencecoursera/utilities.r')
sourcedata <- '~/dev/data/exdata-data-NEI_data.zip'
workingdir <- '~/dev/datasciencecoursera/exploratory/hw2'

# setwd, create data directory, return location
datadir <- setup(workingdir, 'exp2')
unzip(sourcedata, exdir = datadir)

# read dataset
df.nei <- readRDS(paste0(datadir, 'summarySCC_PM25.rds'))

# q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

# create new data frame with sum of all measurements, number of measurements, and mean, all by year
df.tot <- ddply(df.nei, .(year), summarize, total = sum(Emissions), samples = length(year))
df.tot$avg <- df.tot$total/df.tot$samples

# plot and print the sum of all PM2.5 measurements
png('plot1.png', width = 786)
par(mar = c(8, 4, 4, 2) + 0.1)
plot(df.tot$year, df.tot$total,
     main = "Total PM2.5 Measurements by Year",
     xlab = "Year",
     ylab = "Total PM2.5")
lines(df.tot$year, df.tot$total)
mtext('This plot shows that the total of PM2.5 measurements has decreased. However,
     this hides if there was an increase or decrease in the number of measurements',
      side = 1, line = 6)
dev.off()

# plot and print the average of all PM2.5 measurements
png('plot1a.png', width = 786)
par(mar = c(8, 4, 4, 2) + 0.1)
plot(df.tot$year, df.tot$avg,
     main = "Average PM2.5 Measurements by Year",
     xlab = "Year",
     ylab = "Average PM2.5 per Measurement")
lines(df.tot$year, df.tot$avg)
mtext('By taking the average of all measurements we show that the average at each 
measurement site has declined as well. However, we still haven\'t controlled for location.',
      side = 1, line = 6)
dev.off()

#delete data directory
cleanup(datadir)