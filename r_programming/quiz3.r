#q1
library(datasets)
data(iris)
mean(iris[iris$Species == 'virginica', 1])

#q2
colMeans(iris[, 1:4])
apply(iris[, 1:4], 2, mean)

#q3
library(datasets)
data(mtcars)
tapply(mtcars$mpg, mtcars$cyl, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)

#q4
avghp <- tapply(mtcars$hp, mtcars$cyl, mean)
abs(avghp[1]-avghp[3])
