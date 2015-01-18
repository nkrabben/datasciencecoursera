library(data.table)
library(reshape2)
source('utilities.r')

dt.pm25 <- readRDS('summarySCC_PM25.rds')
dt2 <- data.table(dt.pm25)
df <- data.frame(dt.pm25)
dt.pm25$year <- factor(dt.pm25$year)
dt.pm25$Pollutant <- factor(dt.pm25$Pollutant)
dt.classify <- readRDS('Source_Classification_Code.rds')

df.2 <- dcast(df, df$year ~ df$Emissions, sum, value.var = Emissions)

aggregate(df, formula = year ~ Emissions, FUN = sum)
