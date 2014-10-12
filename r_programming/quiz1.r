#q4
x <- 4
print(class(x))

#q5
x <- c(4, TRUE)
print(class(x))

#q6
x <- c(1,3, 5)
y <- c(3, 2, 10)
cbind(x,y)

#q8
x <- list(2, "a", "b", TRUE)
y <- x[[2]]
print(class(y))

#q9
x <- 1:4
y <- 2:3
x+y

#q10
x <- c(3, 5, 1, 10, 12, 6)
x[x <= 5] <- 0
print(x)

#q11
if (!file.exists("hw1_data.zip")) {
        dataURL<-'https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fquiz1_data.zip'
        data<-'quiz1_data.zip'
        download.file(dataURL, destfile=data,method='curl')
        unzip(data)
}

df <- read.csv("hw1_data.csv")

head (df,2)

#q13
nrow(df)

#q14
tail(df,2)

#q15
df[47,1]

#q16
sum(is.na(df[,1]))

#q17
mean(df[,1], na.rm=T)

#q18
df.sub <- subset(df, Ozone > 31 & Temp > 90)
mean(df.sub[,2])

#q19
mean(df[df$Month==6,4])

#q20
max(df[df$Month==5,1], na.rm=T)
