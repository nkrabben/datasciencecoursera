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

# read datasets
df.nei <- readRDS(paste0(datadir, 'summarySCC_PM25.rds'))
df.classify <- readRDS(paste0(datadir, 'Source_Classification_Code.rds'))

# q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources
# in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# filter for all mobile sources with on- or off-highway use to find mobile vehicles
# this includes brake, tire, and other sources that I assume are included in emissions
# can filter for exhaust in Level Four at this point as well
df.vehiclesources <- df.classify[df.classify$SCC.Level.One == "Mobile Sources", ]
df.vehiclesources <- df.vehiclesources[grep('[hH]ighway', df.vehiclesources$SCC.Level.Two), ]

# subset the complete dataset for only those SCC related to motor vehicles in Baltimore and LA
df.balla <- df.nei[df.nei$fips == '24510' | df.nei$fips == '06037', ]
df.ballavehicles <- df.balla[df.balla$SCC %in% df.vehiclesources$SCC, ]

df.ballavehicles <- merge(df.ballavehicles, df.classify, by = 'SCC')

# sum, plot, and print by second level
df.ballavehiclesall <- ddply(df.ballavehicles, .(year, fips), summarize, total = sum(Emissions))

# clean up the summarized dataset
colnames(df.ballavehiclesall)[2]<-"City"
df.ballavehiclesall$City <- factor(df.ballavehiclesall$City)
levels(df.ballavehiclesall$City) <- c('LA', 'Baltimore')

# plot and print
g.ballavehiclesall <- ggplot(df.ballavehiclesall, aes(x=year, y=total, col=City))
g.ballavehiclesall <- g.ballavehiclesall +
        geom_point() +
        geom_line() +
        labs(title = "Motor Vehicle Related PM2.5 in Baltimore and LA",
             x = "Year",
             y = "Total PM2.5")

annotation <- "While LA and Baltimore have similar shifts in the amount of PM2.5 emissions, in opposite directions \
Baltimore has the greatest proportional reduction since it only emitted ~8% of LA's ammount in 1998, and now less \
less than 4%."
g.ballavehiclesall <- arrangeGrob(g.ballavehiclesall, sub = textGrob(annotation))

png('plot6.png', width = 786)
print(g.ballavehiclesall)
dev.off()

# sum, plot, and print by second level for greater detail
df.ballavehiclestype <- ddply(df.ballavehicles, .(year, fips, SCC.Level.Two), summarize, total = sum(Emissions))

# clean up the summarized dataset
colnames(df.ballavehiclestype)[2]<-"City"
df.ballavehiclestype$City <- factor(df.ballavehiclestype$City)
levels(df.ballavehiclestype$City) <- c('LA', 'Baltimore')
colnames(df.ballavehiclestype)[3]<-"Type"

# plot and print
g.ballavehiclestype <- ggplot(df.ballavehiclestype, aes(x=year, y=total, col=Type))
g.ballavehiclestype <- g.ballavehiclestype +
        geom_point() +
        geom_line() +
        facet_grid(. ~ City) +
        labs(title = "Motor Vehicle Related PM2.5 in Baltimore and LA",
             x = "Year",
             y = "Total PM2.5")

annotation <- "Interestingly, LA seems to be bucking the national trend in overall emissions decline. No single trend \
describes every category of motor vehicle in LA."
g.ballavehiclestype <- arrangeGrob(g.ballavehiclestype, sub = textGrob(annotation))

png('plot6a.png', width = 786)
print(g.ballavehiclestype)
dev.off()

#delete data directory
cleanup(datadir)
