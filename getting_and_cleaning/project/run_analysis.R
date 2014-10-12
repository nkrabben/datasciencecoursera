#Merges the training and the test sets to create one data set.
if (!file.exists("UCI HAR Dataset")) {
        unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}

df.test<-cbind(read.table("UCI HAR Dataset/test/X_test.txt"),
                         read.table("UCI HAR Dataset/test/Y_test.txt"),
                         read.table("UCI HAR Dataset/test/subject_test.txt"))

df.train<-cbind(read.table("UCI HAR Dataset/train/X_train.txt"),
               read.table("UCI HAR Dataset/train/Y_train.txt"),
               read.table("UCI HAR Dataset/train/subject_train.txt"))

df.total<-rbind(df.test,df.train)
#add column names
features<-read.table("UCI HAR Dataset/features.txt")
names(features)<-c('column','feature')
col.names<-c(as.character(features[,2]),'activity','subject')
names(df.total)<-col.names

#Extract only the measurements on the mean and standard deviation for each measurement. 
#filter out measurements using regular expressions to look for mean and std
#\\( is used to filter out measurements where the column measures the mean or std of a secondary variable
# or mean or std is used as a variable in another function e.g. angle()
stdmean.col<-c(grep("mean\\(",features$feature),grep("std\\(",features$feature),562,563)
#subset the data frame for only those columns with desired measurements
df.stdmean<-df.total[,stdmean.col]

#Use descriptive activity names to name the activities in the data set
#completed previously in df.total
#cleaned here by eliminated parentheses
names(df.stdmean)<-gsub('\\(|\\)','', names(df.stdmean))
#function to camel case
#turn first column into key
#map dfStdMean with key
col.names<-gsub("e", "", col.names)

#Appropriately labels the data set with descriptive activity names.
activities<-read.table("UCI HAR Dataset/activity_labels.txt",col.names=(c('activity','name')))
#clean up label names by going to lower case and removing underscores
activity.labels<-tolower(as.character(activities[,2]))
activity.labels<-gsub("_","-",activity.labels)
df.stdmean$activity<-factor(df.stdmean$activity,labels=activity.labels)

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#split into lists according to activity and subject
split.activity<-split(df.stdmean,list(df.stdmean$activity,df.stdmean$subject))
#take column means on each list items
tidy.table<-sapply(split.activity,function(x) colMeans(x[,names(df.stdmean)[1:66]]))
#transpose to place measurements as columns again
tidy.table.transpose<-t(tidy.table)
#create data frame and remove row names from sapply
df.tidy<-data.frame(tidy.table.transpose,row.names=NULL)
#extract activity and subject from row names
activity.subject<-strsplit(rownames(tidy.table.transpose),'\\.')
activity.subject<-unlist(activity.subject)
activity<- activity.subject[seq(1, length(activity.subject), 2)]
subject<- activity.subject[seq(2, length(activity.subject), 2)]
#package everything into a dataframe
df.tidy<-cbind(subject,activity,df.tidy)
write.table(df.tidy,file="tidy.csv")

