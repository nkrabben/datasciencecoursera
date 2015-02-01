rankhospital <- function(state, outcome, num = "best") {
        ifelse(outcome == 'heart attack',
               outcome <- 'heartAttack',
               ifelse(outcome == 'heart failure',
                      outcome <-'heartFailure',
                      ifelse(outcome == 'pneumonia',
                             outcome <- outcome,
                             stop('invalid outcome'))))
        
        
        ifelse(state %in% unique(df.outcome$State),
               state <- state,
               stop('invalid state'))
        
        answer <- filter(df.outcome, State == state) %>%
                select_('hospital', outcome) %>%
                arrange_(outcome, 'hospital')
        
        answer <- answer[!is.na(answer[, 2]), ]
        
        ifelse(is.numeric(num),
               num <- num,
               ifelse(num == 'best',
                      num <- 1,
                      ifelse(num == 'worst',
                             num <- nrow(answer))))
        
        ifelse(is.numeric(num),
               return(c(hospital = answer[num, 1], State = state)),
               return(NA))
}