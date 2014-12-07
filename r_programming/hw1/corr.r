corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        
        file_list <- list.files(directory, full.names=T)
        
        dat <- vector()
        
        for (i in file_list) {
                df <- read.csv(i)
                nobs <- sum(complete.cases(df))
                if (nobs > threshold){
                        dat <- c(dat, cor(df$sulfate, df$nitrate, use='complete.obs'))
                }
        }
        
        return(dat)
        
        #return(lapply(cormean(dat[,pollutant], na.rm=T))
}