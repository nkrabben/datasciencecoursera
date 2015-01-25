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

# q4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# filter all sources for combustion in SCC Level One and coal/coal-based fuels in Level Three
df.combustcoal <- df.classify[grepl('Combustion', df.classify$SCC.Level.One) &
                                      grepl('[cC]oal', df.classify$SCC.Level.Three), ]

df.coal <- df.nei[df.nei$SCC %in% df.combustcoal$SCC, ]
df.coal <- merge(df.coal, df.classify, by = 'SCC')

# after checking various facets, combustion by purpose is the most interesting
df.coalpurp <- df.nei[df.nei$SCC %in% df.combustcoal$SCC, ] %>%
        merge(df.classify, by = 'SCC') %>%
        ddply(.(year, SCC.Level.Two), summarize, total = sum(Emissions))

colnames(df.coalpurp)[2]<-"Purpose"

# plot the sum of all PM2.5 measurements for coal combustion in Baltirmore by purpose
g.coalpurp <- ggplot(df.coalpurp, aes(x=year, y=total, col=Purpose))
g.coalpurp <- g.coalpurp +
        geom_point() +
        geom_line() +
        labs(title = "Coal Combustion Related PM2.5 in Baltimore",
             x = "Year",
             y = "Total PM2.5")

# add an interpretation of the plot to the plot object
annotation <- "Electrical generation comprises the bulk of coal combustion. It has decreased by ~40%."
g.coalpurp <- arrangeGrob(g.coalpurp, sub = textGrob(annotation))

# print plot
png('plot4.png', width = 786)
print(g.coalpurp)
dev.off()

#delete data directory
cleanup(datadir)