setup <- function(wd, datadir) {
        setwd(wd)
        
        datadir <- paste0('~/dev/data/', datadir, '/')
        dir.create(file.path(datadir), showWarnings = FALSE)
          
        return(datadir)
}

cleanup <- function(datadir) {
        unlink(datadir)       
}