setup <- function(wd, data) {
        setwd(wd)
        dir.create(file.path('~/dev/data/', data), showWarnings = FALSE)
          
        return(datadir)
}

cleanup <- function(data) {
        unlink(paste0('~/dev/data/', data))       
}