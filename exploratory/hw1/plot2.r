#plot2 Global Active power over time
source('get_data.r')

#function to check if file is downloaded, and download and unzip if not, returns file name
#check get_data.r
fPowerD <- check_grab()

#function to extract the necessary data, convert time data, and dump it all in a data frame
#check get_data.r
df <- create_frame(fPowerD)

png('plot2.png', bg='transparent')
with(df,plot(datetime, Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab=''))
box()
dev.off()
