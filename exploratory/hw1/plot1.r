#plot1 Global Active Power histogram
source('get_data.r')

#function to check if file is downloaded, and download and unzip if not, returns file name
#check get_data.r
fPowerD <- check_grab()

#function to extract the necessary data, convert time data, and dump it all in a data frame
#check get_data.r
df <- create_frame(fPowerD)

png('plot1.png', bg='transparent')
hist(df$Global_active_power, main="Global Active Power", col='red', xlab="Global Active Power (kilowatts)")
par(mar=c(6,5,5,3), cex=0.8)
dev.off()
