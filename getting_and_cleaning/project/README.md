Getting and Cleaning Data - Project Readme
===================
##Purpose
This project was completed for the May version of the Getting and Cleaning Data project on Coursera. 

This project collects, corrlates, and analyzes data collected from the accelerometers from Samsung Galaxy S smartphones. More details on the dataset are here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Specifically these steps were taken:
*Merge the training and the test sets to create one data set.
*Extract only the measurements on the mean and standard deviation for each measurement. 
*Use descriptive activity names to name the activities in the data set
*Appropriately label the data set with descriptive activity names. 
*Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

##Included
*run_analysis.R - an R script that performs the data processing
*tidy.csv - the processed dataset created by run_analysis.R
*CodeBook.md - a codebook describing tidy.csv and run_analysis.R
*getdata-projectfiles-UCI HAR Dataset.zip - the zipped dataset used by run_analysis.R
*/UCI HAR Dataset - the dataset unzipped by run_analysis.R