best <- function(state, outcome) {
        ## Read outcome data
        ## Check that state and outcome are valid
        ifelse(outcome == 'heart attack',
               outcome <- 'heartAttack',
               ifelse(outcome == 'heart failure',
                      outcome <-'heartFailure',
                      ifelse(outcome == 'pneumonia',
                             outcome <- outcome,
                             stop('invalid outcome'))))
        
        ifelse(state %in% df.outcome$State,
               state <- state,
               stop('invalid state'))
        
        answer <- filter(df.outcome, State == state) %>%
                arrange_(outcome)
        
        return(answer[1, 2])
}