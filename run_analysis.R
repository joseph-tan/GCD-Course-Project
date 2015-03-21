## This analysis assumes that the Samsung data is saved in a folder "UCI HAR Dataset" 
## located in the working directory

library(dplyr)
library(stringr)

## Read test set data into R
## Merge data on subjects that performed the test, test labels and test set ("testdata")

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testdata <- cbind(subjtest,ytest,xtest)

## Read train set data into R
## Merge data on subjects that performed the training, training labels and training set ("traindata")

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Merge training and test sets to create one data set ("data")

data <- rbind(testdata,traindata)

## Read features (i.e. column names of xtest/xtrain) into R
## Read activities (i.e. mapping of ytest labels to activities) into R

features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Define and assign column names of "data"

f1 <- as.character(features[,2])
f2 <- sapply(f1, function(x) str_replace_all(x,"-","."))
f3 <- sapply(f2, function(x) str_replace_all(x,"\\()",""))
f4 <- sapply(f3, function(x) str_replace_all(x,"std","std_dev"))
col <- c("Subject","Activity",as.character(f4))

colnames(data) <- col

## Return the columns in "data" whose names contain either "mean()", "meanFreq()" or "std()"
## We add 2 because the original data is right-shifted two columns
## because of the merging with "Subject" and "Activity"

selectcols <- sort(c(grep("mean",features[,2]),grep("std",features[,2]))) + 2

## "data2" extracts from "data" only the measurements on the mean and 
## standard deviation for each measurement 

data2 <- data[,c(1,2,selectcols)]
data3 <- tbl_df(data2)

## Cross-referencing the "activities" data frame, replaces the indexes in the "Activity"
## column with the corresponding descriptive names

data4 <- mutate(data3, Activity = sapply(Activity, function(x) activities[x,2]))

## Groups "data4" by Subject and Activity
## Creates an independent tidy data set "tidydata" with the average of each variable 
## for each activity and each subject.

tidydata <- data4 %>% 
group_by(Subject, Activity) %>%
summarise_each(funs(mean))

## Writes "tidydata" to a txt file

write.table(tidydata,file="./tidydata.txt", row.names=FALSE)
