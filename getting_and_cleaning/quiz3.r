#q1
fHouseURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
fHouse<-'housing.csv'
download.file(fHouseURL, destfile=fHouse,method='curl')
fHouseD <- date()
fHouseD

df1<-read.csv(fHouse)
agricultureLogical<-df1$ACR>2 & df1$AGS>5
ag.out<-df1[which(agricultureLogical),]
head(ag.out[1],3)

#q2
library(jpeg)
instrURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
instr<-'jeff.jpg'
download.file(instrURL,destfile=instr,method='curl')
quantile(readJPEG(instr,native=TRUE),c(.3,.8))

#q3
gdpURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdp<-'gdp.csv'
eduURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
edu<-'edu.csv'
download.file(gdpURL,destfile=gdp,method='curl')
download.file(eduURL,destfile=edu,method='curl')
df2<-read.csv(gdp,skip=4)
df2<-df2[1:215,1:5]
df2<-df2[(df2$X.4 != '..' & df2$X.4 != ''),]
df3<-read.csv(edu)
df3<-df3[,1:3]
df.merge<-merge(df2,df3,by.x='X',by.y='CountryCode',all=F)
df.merge$X.4<-as.character(df.merge$X.4)
df.merge$X.4<-gsub(",","",df.merge$X.4)
df.merge$X.4<-gsub(" ","",df.merge$X.4)
df.merge$X.4<-as.numeric(df.merge$X.4)
df.mergeOrd<-df.merge[order(df.merge$X.4),]
df.mergeOrd[13,]

#q4
df.mergeOrd$X5<-rev(order(df.mergeOrd$X.4))

tapply(df.mergeOrd$X5,df.mergeOrd$Income.Group,mean)

#q5
library(Hmisc)
df.mergeOrd$X5groups<-cut2(df.mergeOrd$X5,g=5)
table(df.mergeOrd$Income.Group,df.mergeOrd$X5groups)

