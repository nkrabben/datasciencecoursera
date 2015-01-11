#plot4
source('get_data.r')

#function to check if file is downloaded, and download and unzip if not, returns file name
#check get_data.r
fPowerD <- check_grab()

#function to extract the necessary data, convert time data, and dump it all in a data frame
#check get_data.r
df <- create_frame(fPowerD)

png('plot4.png', bg='transparent')
par(mfrow=c(2,2))

with(df,{
#plot 1 from plot2
        plot(datetime, Global_active_power,type='l', ylab="Global Active Power (kilowatts)", xlab='')

#plot 2 Voltage over time
        plot(datetime,Voltage, type='l')

#plot 3 from plot3
        plot(datetime, Sub_metering_1, type='n', ylab="Energy sub metering", xlab='')
                lines(df$datetime, df$Sub_metering_1)
                lines(df$datetime, df$Sub_metering_2, col='red')
                lines(df$datetime, df$Sub_metering_3, col='blue')
                legend('topright', bty='n', lty=c(1,1), col=c('black','red','blue'),
                       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#plot 4 Global Reactive Power over time
        plot(datetime, Global_reactive_power, type='l')
box()

dev.off()
})

