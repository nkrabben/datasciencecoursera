Getting and Cleaning Data - Project Codebook
===================
##run_analysis.R
* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement. 
* Use descriptive activity names to name the activities in the data set
** All activity names were transformed from integers to R-safe versions of their labels, e.g. 1 -> walking.
* Appropriately label the data set with descriptive activity names. 
** All variable names were transformed to R-safe versions of their original pattern as defined in the codebook, e.g. tBodyAcc-mean()-X -> tBodyAcc_X_mean.
* Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
** Tall dataset was reshaped as a wide dataset with a row for each subject and activity pair and columns of the average for each variable that measured standard deviation or mean. Dataset saved as tidy.csv as described below.

##tidy.csv
The dataset contains 180 rows of 68 variables. Each row describes the standard deviation and mean of measurements taken by a Samsung smartphone recording 6 activities by 30 subjects. The variables are named in the header.
* subject - 1:30 to denote a distinct experimental subject
* activity - [walking, walking-upstairs, walking-downstairs, sitting, standing, laying] as coded by the experiment
* columns 3:68 - means and standard variations of all measurements taken by the smartphone, column names have been transformed to match the original codebook (measurement)-(direction vector if used)-(estimated variable)

## Full process
1. Merge the training and the test sets to create one data set.
1. Check for data, and download if not available
2. Read columns from the measurements, test run, and subjects for test and training sets into data tables
3. Merge data tables.
4. Add column names from features.txt.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
1. Find measurements of mean and std while ignoring those where mean or std is used as a variable in another function e.g. angle().
2. Melt the mean and std columns according to subject and activity.
3. Use descriptive activity names to name the activities in the data set.
1. Import activity labels from activity_labels.txt.
2. Change labels to lower case.
4. Appropriately label the data set with descriptive activity names.
1. Remove unsafe characters ('(', ')', and '-') from variable labels.
2. Change order of variable labels to match original codebook, (measurement)-(direction vector if used)-(estimated variable).
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
1. Take mean of all variables according to subject and activity.
2. Save data table as CSV.