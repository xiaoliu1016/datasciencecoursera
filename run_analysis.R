####1.Download the dataset
fileUrl1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl1,destfile = "./getdataproject.zip")
unzip(zipfile = "./getdataproject.zip")
####2.Merges the training and the test sets to create one data set.
###get all the needed datasets from the original file
test.set<-read.table("./UCI HAR Dataset/test/X_test.txt")
test.labels<-read.table("./UCI HAR Dataset/test/y_test.txt")
train.set<-read.table("./UCI HAR Dataset/train/X_train.txt")
train.labels<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject.test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject.train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
#get the features and activiey labels from the major folder
features<-read.table("./UCI HAR Dataset/features.txt")
activity.labels<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activity", 'activity.name'))
##merge the test and train data
train.dataset<-cbind(train.set,subject.train,train.labels)
test.dataset<-cbind(test.set,subject.test,test.labels)
combined.dataset <- rbind(train.dataset, test.dataset)
##Assign column names
colnames(combined.dataset) <- c(as.character(features$V2), "subject", "activity")
name_list <- colnames(combined.dataset)
##Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_measure <- grepl("activity", name_list) |
  grepl("subject", name_list) |
  grepl("mean..", name_list) | 
  grepl("std..", name_list) 
mean_std_measure_data <- combined.dataset[,mean_std_measure]
##Uses descriptive activity names to name the activities in the data set
mean_std_measure_data <- merge(mean_std_measure_data, activity.labels, by.x = "activity", by.y = "activity",
                               all.x = TRUE)
##Appropriately labels the data set with descriptive variable names.
colnames(mean_std_measure_data) <- gsub('-mean', 'Mean', colnames(mean_std_measure_data))
colnames(mean_std_measure_data) <- gsub('-std', 'StandardDev', colnames(mean_std_measure_data))
colnames(mean_std_measure_data) <- gsub('^t', 'Time', colnames(mean_std_measure_data))
colnames(mean_std_measure_data) <- gsub('^f', 'Frequency', colnames(mean_std_measure_data))
colnames(mean_std_measure_data) <- gsub('\\()', '', colnames(mean_std_measure_data))
##From the data set in step 4, creates a second, independent tidy data set with the average of 
##each variable for each activity and each subject.
library(dplyr)
final.data <- mean_std_measure_data %>% group_by(activity, subject) %>% summarise_each(funs(mean))
write.table(final.data,"./cleandataset.txt",row.name=FALSE)
