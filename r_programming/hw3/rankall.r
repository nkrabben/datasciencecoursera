rankall <- function(outcome, num = "best") {
        
        states <- levels(df.outcome$State)
        answer <- data.frame(hospital = as.character(), State = as.character(), stuff = as.numeric())

        for (state in states) {
                a <- rankhospital(state, outcome, num)
                answer <- rbind(answer, data.frame(hospital <- a[1], State <- a[2]))
        }
        
        names(answer) <- c('hospital', 'state')
        return(answer)
}