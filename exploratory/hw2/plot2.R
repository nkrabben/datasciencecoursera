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

# q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

# take baltimore subset of all data
df.bal <- df.nei[df.nei$fips == '24510', ]

# create new data frame with sum of all measurements by year
df.baltot <- ddply(df.bal, .(year), summarize, total = sum(Emissions), samples = length(year))
df.baltot$avg <- df.baltot$total/df.baltot$samples

# plot and print the sum of all PM2.5 measurements in Baltirmore
png('plot2.png', width = 786)
par(mar = c(8, 4, 4, 2) + 0.1)
plot(df.baltot$year, df.baltot$total,
     main = "Total PM2.5 Measurements in Baltimore",
     xlab = "Year",
     ylab = "Total PM2.5")
lines(df.baltot$year, df.baltot$total)
mtext('This plot shows that the total of PM2.5 measurements has decreased, but spiked in 2006.
As in #Q1, this plot hides if there was an increase or decrease in the number of measurements',
      side = 1, line = 6)
dev.off()

# plot and print the average of all PM2.5 measurements in Baltirmore
png('plot2a.png', width = 786)
par(mar = c(8, 4, 4, 2) + 0.1)
plot(df.baltot$year, df.baltot$avg,
     main = "Average PM2.5 Measurements in Baltimore by Year",
     xlab = "Year",
     ylab = "Average PM2.5")
lines(df.baltot$year, df.baltot$avg)
mtext('This plot shows that an increase in measurement sites contributed to the spike of PM2.5
measurement in 2006',
      side = 1, line = 6)
dev.off()

#delete data directory
cleanup(datadir)
