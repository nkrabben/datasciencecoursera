#q1
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
summary(lm(y ~ x))

#q3
fit <- lm(mpg ~ I(wt-mean(wt)), mtcars)
fit.summ <- summary(fit)$coefficients
fit.summ[1,1] + c(-1, 1) * qt(.975, fit$df) * fit.summ[1,2]

#q5
fit <- lm(mpg ~ wt, mtcars)
predict(fit, data.frame(wt = 3), interval = 'prediction', level=0.95)

#q6
#q3
fit <- lm(mpg ~ I(wt-mean(wt)), mtcars)
fit.summ <- summary(fit)$coefficients
fit.summ[2,1] + c(-1, 1) * qt(.975, fit$df) * fit.summ[2,2]

#q9
fit <- summary(lm(mpg ~ wt, mtcars))
fit2 <- summary(lm(mpg ~ 1, mtcars))
sum(fit$residuals^2)/sum(fit2$residuals^2)
