pollutantmean <- function(directory, pollutant, id = 1:332) {
        setwd("~/dev/datasciencecoursera/r_programming/hw1")
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        file_list <- list.files(directory, full.names=T)
        
        dat <- data.frame()
        
        for (i in id) {
                dat <- rbind(dat, read.csv(file_list[i]))
        }
        
        return(mean(dat[,pollutant], na.rm=T))
}