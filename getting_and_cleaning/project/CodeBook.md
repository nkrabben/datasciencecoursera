Getting and Cleaning Data - Project Codebook
===================
##run_analysis.R
*Merge the training and the test sets to create one data set.
*Extract only the measurements on the mean and standard deviation for each measurement. 
*Use descriptive activity names to name the activities in the data set
*Appropriately label the data set with descriptive activity names. 
*Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

##tidy.csv
The dataset contains 180 rows of 68 variables. Each row describes the standard deviation and mean of measurements taken by a Samsung smartphone recording 6 activities by 30 subjects. The variables are named in the header.
subject - 1:30 to denote a distinct experimental subject
activity - [walking,walking-upstairs,walking-downstairs,sitting,standing,laying] as coded by the experiment
columns 3:68 - means and standard variations of all measurements taken by the smartphone.
