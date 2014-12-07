#q1
cube <- function(x, n) {
        x^3
}
cube(3)

#q3
f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}
z<-10
f(3)