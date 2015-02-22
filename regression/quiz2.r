#q1
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
summary(lm(y ~ x))

#q3
fit <- summary(lm(mtcars$mpg ~ mtcars$wt))$coefficients 
fit[1,1] + c(-1, 1) * qt(.975, lm(mtcars$mpg ~ mtcars$wt)$df) * fit [1,2]

#q5
fit <- lm(mpg ~ wt, mtcars)
predict(fit, newdata=data.frame(wt=mean(mtcars$wt)), interval = 'prediction', level=0.95)

#q9
cor(mtcars$mpg, mtcars$wt)^2
