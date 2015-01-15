setwd('/Users/m3ta2/dev/datasciencecoursera/getting_and_cleaning')

#q1
fHouseURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
fHouse<-'housing.csv'
download.file(fHouseURL, destfile=fHouse,method='curl')
fHouseD <- date()
fHouseD

df1<-read.csv(fHouse)
# total $1e6+ houses in the dataset
sum(df1$VAL==24,na.rm=T)


#q3
library(xlsx)
fNatGasURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
fNatGas<-'natgas.xlsx'
download.file(fNatGasURL, destfile=fNatGas,method='curl')
fNatGasD <- date()
fNatGasD

dat=read.xlsx(fNatGas,sheetIndex=1,header=T,rowIndex=18:23,colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

#q4
library(XML)
fRestURL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml' 
fRest<-'restaurants.xml'
download.file(fRestURL, destfile=fRest,method='curl')
fRestD <-date()
fRestD

doc <- xmlTreeParse(fRest,useInternal=T)
fRestRoot <- xmlRoot(doc)
zips <- xpathSApply(fRestRoot,'//zipcode',xmlValue)
zips[zips=="21231"]

#q5
library(data.table)
fHouse2URL<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
fHouse2<-'housing2.csv'
download.file(fHouse2URL, destfile=fHouse2,method='curl')
DT <-fread(fHouse2)


DT[,mean(pwgtp15),by=SEX]
mean(DT$pwgtp15,by=DT$SEX)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
tapply(DT$pwgtp15,DT$SEX,mean)
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

trial_size <- 200
collected_results <- numeric(trial_size)
for (i in 1:trial_size){
        single_function_time <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
        collected_results[i] <- single_function_time[1]
}
print(mean(collected_results))
