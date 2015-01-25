## Finding the inverse of a matrix can be computationally expensive
## These methods create a class of matrix objects that store both the value of a matrix and its inverse
## This way, the inverse is only computed once and can be retrieved from memory in the future

## makeCacheMatrix is a function that creates an object with 4 methods
## 1. set the value of the object's matrix
## 2. retrieve the value of the object's matrix
## 3. set the value of the inverse of the object's matrix
## 4. retrieve the value of the inverse of the object's matrix

## the function initializes the matrix inverse as null, to be set by cachesolve()

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setinverse <- function(mean) m <<- mean
        getinverse <- function() m
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## cacheSolve inverts the matrix of a makeCacheMatrix object and caches the inverse in the object

## it first checks if the inverse has already been stored in the object with the objects getinverse() method
## if the inverse has not been stored, the function retrieves the value of the object's matrix with get()
## calculates the mean, and then stores it in the object with setinverse().

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getinverse()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- solve(data, ...)
        x$setinverse(m)
        m
}