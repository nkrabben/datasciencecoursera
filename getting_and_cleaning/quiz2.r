#q4
con = url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlDoc = readLines(con)
close(con)
nchar(htmlDoc[c(10,20,30,100)])

#q5
fHouse2URL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for'
fHouse2<-'data.for'
download.file(fHouse2URL, destfile=fHouse2,method='curl')
df <- read.fwf('data.for', c(10,9,4,9,4,9,4,9,4),skip=4)
answer<-sum(df[,4])