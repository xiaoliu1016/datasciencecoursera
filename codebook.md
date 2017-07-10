This is the summarized information for all the functions and how to manipulate the data to get the final tidy dataset.
1. First get the unzip original files by function download.file and unzip(),then using the read.table() get the needed dataset: test.set, train.set, train.labels, subject.test, subject.train and also the features and activity.lables.
2. In order to get the combined dataset, using rbind() and cbind() to get the one dataset.
3. With the colnames() function, assign names to each column and extract the mean and standard deviation by repl() function in each index
4. After using merge() function to merge the two dataset mean_std_measures_data and activity.labels by "activity", using the 
gsub() to replace the confused label names with descriptive variable names
5. Finally, using the function in the dplyr library such as group_by() and summarise_each() to calculate the average value based on each grouped activity and subject.
