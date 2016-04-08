#This script, run_analysis.R, does the following:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Step 0: Set up the working directory and load any libraries
setwd("~/data science coursework/Lesson 3 Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
library(plyr)

#Step 1: Merges the training and the test sets to create one data set.


#Read in each of the datasets

#Read in subject data
subject_train<-read.table("train/subject_train.txt")
subject_test<-read.table("test/subject_test.txt")
subject_full<-rbind(subject_train, subject_test)

#Read in X data
x_train<-read.table("train/x_train.txt")
x_test<-read.table("test/x_test.txt")
x_full<-rbind(x_train, x_test)

#Read in Y data
y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
y_full<-rbind(y_train, y_test)

#combine into one data set
full_data<-cbind(subject_full, y_full, x_full)

#give the full dataset sensible names by reading in the features
#This is also Step 4: Appropriately labels the data set with descriptive variable names.

features<-read.table("features.txt")
feature_list<-as.character(features$V2)
full_data_names<-c("Subject", "Activity", feature_list)
names(full_data)<-full_data_names

#Inertial tables not added per this guide: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/


#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

#Keep subject and activity and look only for mean and std in the names, subset the data based on that

fields<-c("Subject", "Activity", grep("mean|std", names(full_data), ignore.case=TRUE, value=TRUE))
field_subset<-full_data[,fields]



#Step 3: Uses descriptive activity names to name the activities in the data set

#Read in activity labels
activities<-read.table("activity_labels.txt")

#Update the activity column with the name from the activity lables
field_subset[,2]<-activities[field_subset[, 2], 2]


#Step 4: Appropriately labels the data set with descriptive variable names.
#Done within Step 1
#names(field_subset) gives the result:

# [1] "Subject"                              "Activity"                             "tBodyAcc-mean()-X"                   
# [4] "tBodyAcc-mean()-Y"                    "tBodyAcc-mean()-Z"                    "tBodyAcc-std()-X"                    
# [7] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                     "tGravityAcc-mean()-X"                
# [10] "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                 "tGravityAcc-std()-X"                 
# [13] "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                  "tBodyAccJerk-mean()-X"               
# [16] "tBodyAccJerk-mean()-Y"                "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"                
# [19] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                 "tBodyGyro-mean()-X"                  
# [22] "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                   "tBodyGyro-std()-X"                   
# [25] "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                    "tBodyGyroJerk-mean()-X"              
# [28] "tBodyGyroJerk-mean()-Y"               "tBodyGyroJerk-mean()-Z"               "tBodyGyroJerk-std()-X"               
# [31] "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"                "tBodyAccMag-mean()"                  
# [34] "tBodyAccMag-std()"                    "tGravityAccMag-mean()"                "tGravityAccMag-std()"                
# [37] "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"                "tBodyGyroMag-mean()"                 
# [40] "tBodyGyroMag-std()"                   "tBodyGyroJerkMag-mean()"              "tBodyGyroJerkMag-std()"              
# [43] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                    "fBodyAcc-mean()-Z"                   
# [46] "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"                    
# [49] "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"               
# [52] "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"                "fBodyAccJerk-mean()-Z"               
# [55] "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                 "fBodyAccJerk-std()-Z"                
# [61] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                   "fBodyGyro-mean()-Z"                  
# [64] "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                   
# [67] "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
# [70] "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                    "fBodyAccMag-meanFreq()"              
# [58] "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
# [73] "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"            "fBodyBodyAccJerkMag-meanFreq()"      
# [76] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"               "fBodyBodyGyroMag-meanFreq()"         
# [79] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"           "fBodyBodyGyroJerkMag-meanFreq()"     
# [82] "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)" "angle(tBodyGyroMean,gravityMean)"    
# [85] "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"                 "angle(Y,gravityMean)"                
# [88] "angle(Z,gravityMean)" 


#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
#The above dataset is already tidy, so a subset of it will also be tidy.

#use plyr to get the column means by subject and activity 
means<-ddply(field_subset, .(Subject, Activity), function(x) colMeans(x[, 3:88]))

#Write this out to a new text file
write.table(means, "tidy_means.txt", row.name=FALSE)

#This is the wide dataset as mentioned in the instructions.



