setwd("~/dev/datasciencecoursera/exploratory/hw1")
fPowerURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
fPowerD <- '../household_power_consumption.zip'

check_grab <- function() {
        if (!file.exists(fPowerD)) {
                download.file(fPowerURL, destfile=fPowerD,method='curl')
                unzip(fPowerD, exdir='../')
        }
        return('../household_power_consumption.txt')
}

create_frame <- function(file) {
        df<-read.csv(file,sep=';',na.strings="?", stringsAsFactors=F, skip=66636,
                 nrows=2880, col.names=c('Date','Time','Global_active_power','Global_reactive_power',
                                         'Voltage','Global_intensity','Sub_metering_1','Sub_metering_2',
                                         'Sub_metering_3'))
        df$datetime <- paste(df$Date, df$Time, sep=' ')
        df$datetime = strptime(df$datetime,format="%d/%m/%Y %H:%M:%S")
        
        return(df)
}

