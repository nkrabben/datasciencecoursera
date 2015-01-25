#q1
fHouseURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
fHouse<-'housing.csv'
download.file(fHouseURL, destfile=fHouse,method='curl')
fHouseD <- date()
fHouse

df1<-read.csv(fHouse)
strsplit(names(df1), 'wgtp')[123]

#q2
gdpURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdp<-'gdp.csv'
download.file(gdpURL, destfile=gdp,method='curl')
gdpD <- date()
gdpD

df2<-read.csv(gdp,skip=4, strip.white = T, encoding='UTF-8')
df2 <- df2[1:190,]
df2$US.dollars. <- gsub(',','',df2$X.4)
df2$US.dollars. <- as.numeric(df2$X.4)
mean(df2$X.4, na.rm=T)

#q3
countryNames <- as.character(df2$X.3)
grep("^United",countryNames)

#q4
fedURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
fed<-'fed.csv'
download.file(fedURL,destfile=fed,method='curl')
df3<-read.csv(fed)
df.merge<-merge(df2,df3,by.x='X',by.y='CountryCode',all=F)
notes<-df.merge$Special.Notes
notes<-notes[grepl('[Jj]une', notes)]
sum(grepl('[Ff]iscal', notes))

#q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
sampleTimes2012 <- sampleTimes[grepl('2012', year(sampleTimes))]
length(sampleTimes2012)
sum(grepl('2', wday(sampleTimes2012)))

