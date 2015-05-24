setwd("~/Box Sync/Data_Science/Getting_and_cleaning_data/project/UCI HAR Dataset")

#read test data
X_test <- read.table("test/X_test.txt", sep = "", header = F)
y_test <- read.table("test/y_test.txt", sep = "", header = F)
subject_test <- read.table("test/subject_test.txt", sep = "", header = F)

#combine test data
test <- cbind(subject_test, y_test, X_test)

#read train data
X_train <- read.table("train/X_train.txt", sep = "", header = F)
y_train <- read.table("train/y_train.txt", sep = "", header = F)
subject_train <- read.table("train/subject_train.txt", sep = "", header = F)

#combine train data
train <- cbind(subject_train, y_train, X_train)

#combine test and train data
allData <- rbind(train, test)

#name each column
features <- read.table("features.txt", sep = "", header = F)
features <- as.character(features[,2])
names(allData) <- c("subject", "activity", features)

#meger activity labels with activity names
activity_labels <- read.table("activity_labels.txt", sep = "", header = F)
allDataLabeled <- merge(activity_labels, allData, by.x = "V1" , by.y = "activity", all = T)

#rename each column of the whole data
names(allDataLabeled) <- c("activity_label", "activity", "subject", features)

#extract the measurements on the mean and standard deviation for each measurement
extract1 <- grep("std|mean", names(allDataLabeled), value = T)
extract2 <- grep("meanFreq", names(allDataLabeled), value = T, fixed = T)
extractSumStd <- allDataLabeled[,setdiff(extract1, extract2)]
newData <- cbind(allDataLabeled[,2:3],extractSumStd)

#summary table for average of each variable for each activity and each subject
library(plyr)
summary <- ddply(newData, .(subject, activity), colwise("mean"))
write.table(summary, file = "summary.txt", row.name=FALSE)