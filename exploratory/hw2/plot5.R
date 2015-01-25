# load libraries
library(plyr)
library(dplyr)
library(ggplot2)
library(gridExtra)

# setup workspace
source('~/dev/datasciencecoursera/utilities.r')
sourcedata <- '~/dev/data/exdata-data-NEI_data.zip'
workingdir <- '~/dev/datasciencecoursera/exploratory/hw2'

# setwd, create data directory, return location
datadir <- setup(workingdir, 'exp2')
unzip(sourcedata, exdir = datadir)

# read datasets
df.nei <- readRDS(paste0(datadir, 'summarySCC_PM25.rds'))
df.classify <- readRDS(paste0(datadir, 'Source_Classification_Code.rds'))

# q5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


# filter for all mobile sources with on- or off-highway use to find mobile vehicles
# this includes brake, tire, and other sources that I assume are included in emissions
# can filter for exhaust in Level Four at this point as well
df.vehiclesources <- df.classify[df.classify$SCC.Level.One == "Mobile Sources" &
                                               grepl('[hH]ighway', df.classify$SCC.Level.Two), ]

# subset the complete dataset for only those SCC related to mobiles vehicles
df.bal <- filter(df.nei, fips == '24510')
df.vehicles <- df.bal[df.bal$SCC %in% df.vehiclesources$SCC, ]

# sum Emmissions by year and SCC Level Two
df.vehiclestot <- merge(df.vehicles, df.classify, by = 'SCC') %>%
        ddply(.(year, SCC.Level.Two), summarize, total = sum(Emissions))

colnames(df.vehiclestot)[2]<-"Type"

g.vehiclestot <- ggplot(df.vehiclestot, aes(x=year, y=total, col=Type))
g.vehiclestot <- g.vehiclestot +
        geom_point() +
        geom_line() +
        labs(title = "Motor Vehicle Related PM2.5 in Baltimore",
             x = "Year",
             y = "Total PM2.5")

annotation <- "Nearly all PM2.5 emissions from motor vehicles in Baltimore are declining, especially diesel and gasoline highway vehicles."
g.vehiclestot <- arrangeGrob(g.vehiclestot, sub = textGrob(annotation))

png('plot5.png', width = 786)
print(g.vehiclestot)
dev.off()

# sum, plot, and print all emissions by third level for more detail
df.vehiclestype <- ddply(df.vehiclesall, .(year, SCC.Level.Three), summarize, total = sum(total))

colnames(df.vehiclestype)[2]<-"Type"

g.vehiclestype <- ggplot(df.vehiclestype, aes(x=year, y=total, col=Type))
g.vehiclestype <- g.vehiclestype +
        geom_point() +
        geom_line() +
        labs(title = "Motor Vehicle Related PM2.5 in Baltimore",
             x = "Year",
             y = "Total PM2.5")

annotation <- "At a higher level of detail, heavy duty diesels (e.g. semis) have seen the greatest reduction."
g.vehiclestype <- arrangeGrob(g.vehiclestype, sub = textGrob(annotation))

png('plot5a.png', width = 786)
print(g.vehiclestype)
dev.off()

#delete data directory
cleanup(datadir)
