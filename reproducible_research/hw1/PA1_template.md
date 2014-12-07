---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---


## Loading and preprocessing the data


```r
if (!file.exists('activity.csv')) {
        unzip('activity.zip', exdir='../')
}
```

```
## Warning in unzip("activity.zip", exdir = "../"): error 1 in extracting
## from zip file
```

```r
df <- read.csv('activity.csv')
```

```
## Warning in file(file, "rt"): cannot open file 'activity.csv': No such file
## or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
df$interval <- sprintf('%04d', df$interval)
```

```
## Error in df$interval: object of type 'closure' is not subsettable
```

```r
df$time <- strptime(paste(df$date,df$interval), format='%Y-%m-%d %H%M')
```

```
## Error in df$date: object of type 'closure' is not subsettable
```

## What is mean total number of steps taken per day?

Most devices registered between 0 and 40 steps per day.


```r
steps_mean <- mean(df$steps, na.rm=T)
```

```
## Error in df$steps: object of type 'closure' is not subsettable
```

```r
steps_median <- median(df$steps, na.rm=T)
```

```
## Error in df$steps: object of type 'closure' is not subsettable
```

```r
library(ggplot2)

ggplot(df, aes(x=steps)) + geom_histogram(binwidth=40) + xlab('Number of Steps (grouped by 40)') + ylab('Frequency') + geom_vline(aes(xintercept=steps_median), linetype='dashed', size=1, colour='blue') + geom_vline(aes(xintercept=steps_mean), linetype='dashed', size=1, colour='red')
```

```
## Error: ggplot2 doesn't know how to deal with data of class function
```

















