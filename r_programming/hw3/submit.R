library(plyr)
library(dplyr)

outcome_raw <- read.csv("~/dev/data/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
hospitals <- read.csv("~/dev/data/rprog-data-ProgAssignment3-data/hospital-data.csv", colClasses = "character")

df.outcome <- select(outcome_raw, Provider.Number, Hospital.Name, State, starts_with('Hospital.30.Day.Death.'))
names(df.outcome) <- c('provider', 'hospital', 'State', 'heartAttack', 'heartFailure', 'pneumonia')
df.outcome <- mutate(df.outcome,
                  State = factor(State),
                  heartAttack = as.numeric(heartAttack),
                  heartFailure = as.numeric(heartFailure),
                  pneumonia = as.numeric(pneumonia))

setwd('~/dev/datasciencecoursera/r_programming/hw3')
source('best.R')
source('rankhospital.R')
source('rankall.R')
source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")
submit()

