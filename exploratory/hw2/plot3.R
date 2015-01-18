# load libraries
library(plyr)
library(ggplot2)
library(gridExtra)

# setup workspace
source('~/dev/datasciencecoursera/utilities.r')
sourcedata <- '~/dev/data/exdata-data-NEI_data.zip'
workingdir <- '~/dev/datasciencecoursera/exploratory/hw2'

# setwd, create data directory, return location
datadir <- setup(workingdir, 'exp2')
unzip(sourcedata, exdir = datadir)

# read dataset
df.nei <- readRDS(paste0(datadir, 'summarySCC_PM25.rds'))

# q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make
# a plot answer this question.


# take baltimore subset of all data
df.bal <- df.nei[df.nei$fips == '24510', ]

# create new data frame with sum of all measurements by year and type
df.baltot <- ddply(df.bal, .(year, type), summarize, total = sum(Emissions), samples = length(year))
df.baltot$avg <- df.baltot$total/df.baltot$samples


# plot the sum of all PM2.5 measurements in Baltirmore
g.bal <- ggplot(df.baltot, aes(x=year, y=total, col=type))
g.bal <- g.bal +
        geom_point() +
        geom_line() +
        labs(title = "Total PM2.5 Measurements in Baltimore by Year and Type",
             x = "Year",
             y = "Total PM2.5")

# add an interpretation of the plot to the plot object
annotation <- "Point sources have are the only type of source to have increased measurements \
of PM2.5 in Baltimore from 1999-2008. They likely caused the spike in overall \
PM2.5 measurement."
g.bal <- arrangeGrob(g.bal, sub = textGrob(annotation))

# print plot
png('plot3.png', width = 786)
print(g.bal)
dev.off()

# plot the average of all PM2.5 measurements in Baltirmore
g.balavg <- ggplot(df.baltot, aes(x=year, y=avg, col=type))
g.balavg <- g.balavg +
        geom_point() +
        geom_line() +
        labs(title = "Average PM2.5 Measurements in Baltimore by Year and Type",
             x = "Year",
             y = "Average PM2.5")

# add an interpretation of the plot to the plot object
annotation <- "The average of each measurement reflects the same information, except for point sources. /
The spike in 2005 has been converted into a dip in 2002."
g.balavg <- arrangeGrob(g.balavg, sub = textGrob(annotation))

# print plot
png('plot3a.png', width = 786)
print(g.balavg)
dev.off()

#delete data directory
cleanup(datadir)