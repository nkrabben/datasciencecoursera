Getting and Cleaning Data - Project Readme
===================
##Purpose
This project was completed for the May version of the Getting and Cleaning Data project on Coursera. 

This project collects, corrlates, and analyzes data collected from the accelerometers from Samsung Galaxy S smartphones. More details on the dataset are here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Specifically these steps were taken:
* Merge the training and the test sets to create one data set.
        ** All data read into a single data.table. Columns names were obtained from features.txt.
*Extract only the measurements on the mean and standard deviation for each measurement.
        ** After selecting columns estimating the std or mean of a measurement, dataset was melted from 10299 observations of 563 variables to 679,734 observations of 66 variables and two id variables.
* Use descriptive activity names to name the activities in the data set
        ** The activity factor was relabeled with the values provided by activity_labels.txt. Labels were set to lower case for readability.
* Appropriately label the data set with descriptive activity names. 
        ** The variable factor was relabeled in the pattern described in features_info.txt, (measurement)-(direction vector if used)-(estimated variable). Additionally, '(', ')', and '-' were removed/replaced from label names because they can cause errors in R scripts.
* Create a second, independent tidy data set with the average of each variable for each activity and each subject.
        ** Dataset was into 180 observations (30 subjects with 6 activities each) of the means of the 66 measured variables previously described. Dataset was saved as tidy.csv.

##Included
* run_analysis.R - an R script that performs the data processing
* tidy.csv - the processed dataset created by run_analysis.R
* CodeBook.md - a codebook describing tidy.csv and run_analysis.R
