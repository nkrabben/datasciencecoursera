#plot3 Simultaneous plot of sub meters 1, 2, and 3
source('get_data.r')

#function to check if file is downloaded, and download and unzip if not, returns file name
#check get_data.r
fPowerD <- check_grab()

#function to extract the necessary data, convert time data, and dump it all in a data frame
#check get_data.r
df <- create_frame(fPowerD)

png('plot3.png', bg='transparent')
with(df,plot(datetime, Sub_metering_1, type='n', ylab="Energy sub metering", xlab=''))
#each line individually
lines(df$datetime, df$Sub_metering_1)
lines(df$datetime, df$Sub_metering_2, col='red')
lines(df$datetime, df$Sub_metering_3, col='blue')
legend('topright', lty=c(1,1), col=c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
box()
dev.off()
