library(data.table)
library(reshape2)

#Merge the training and the test sets to create one data set.
# check for data, and download if not available
if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile="getdata_projectfiles_UCI HAR Dataset.zip",method='curl')
        unzip("getdata_projectfiles_UCI HAR Dataset.zip", exdir='../')
}

# bind columns from the measurements, test run, and subjects for test and training sets
dt.test <- cbind(read.table("UCI HAR Dataset/test/subject_test.txt"),
                 read.table("UCI HAR Dataset/test/Y_test.txt"),
                 read.table("UCI HAR Dataset/test/X_test.txt"))

dt.train <- cbind(read.table("UCI HAR Dataset/train/subject_train.txt"),
                  read.table("UCI HAR Dataset/train/Y_train.txt"),
                  read.table("UCI HAR Dataset/train/X_train.txt"))

# bind the rows of test and training together
dt.total <- rbind(dt.test,dt.train)

# add column names
features <- read.table("UCI HAR Dataset/features.txt")
dt.total.colnames <- c('subject', 'activity', as.character(features[, 2]))
names(dt.total) <- dt.total.colnames

# Extract only the measurements on the mean and standard deviation for each measurement. 
# filter out measurements using regular expressions to look for mean and std

# \\( is used to filter out measurements of mean or std of a secondary variable
# and where mean or std is used as a variable in another function e.g. angle()

# add 2 to the results in order to account for subject and activity columns
col.means <- grep("mean\\(", features[ , 2]) + 2
col.stds <- grep("std\\(", features[ , 2]) + 2

# melt the data frame for only those columns with desired measurements
dt.meanstds <- melt(dt.total, id.vars = c(1, 2), measure.vars = c(col.means, col.stds))

# Use descriptive activity names to name the activities in the data set
dt.activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c('activity', 'name'),
                            stringsAsFactors = F)
dt.activities$name <- tolower(dt.activities$name)
dt.meanstds$activity <- factor(dt.meanstds$activity)
levels(dt.meanstds$activity) <- dt.activities$name

#Appropriately labels the data set with descriptive activity names.
variable.names <- levels(dt.meanstds$variable)
# () is unsafe in R, drop
variable.names <- gsub('\\(|\\)','', variable.names)
# - is unsafe in R, change to _
variable.names <- gsub('-','_', variable.names)
# switch order to that described in features
variable.names <- gsub('(_mean|_std)(_[XYZ])','\\2\\1', variable.names)
levels(dt.meanstds$variable) <- variable.names


#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
dt.tidymeanstds <- dcast(dt.meanstds, subject + activity ~ variable, mean)

write.table(dt.tidymeanstds, file = "tidy.csv", row.names = F)

