# GCD-Course-Project

## Objective

This README explains the code in the run_analysis.R file, which:
* Merges the training and the test sets to create one data set;
* Extracts only the measurements on the mean and standard deviation for each measurement; 
* Uses descriptive activity names to name the activities in the data set;
* Appropriately labels the data set with descriptive variable names; and
* From the data set created, creates a second, independent tidy data set with 
    the average of each variable for each activity and each subject.
    
## Merge training and test sets (lines 16-19, 24-27, 31)

We use the read.table() function to read the x_test.txt, y_test.txt and subject_test.txt files into data frames
in R.  Each data frame has the same number of rows (2947).  As subjtest and ytest serve as labels for the test
subjects and the activities being measured, we column bind them to the left of the test data (xtest) using the
cbind() function.  

We use the read.table() function to read the x_train.txt, y_train.txt and subject_train.txt files into data frames
in R.  Each data frame has the same number of rows (7352).  As subjtrain and ytrain serve as labels for the training
subjects and the activities being measured, we column bind them to the left of the traing data (xtrain) using the
the cbind() function.  

To merge the test and training data into a new data frame called "data", we use the rbind() function.  The test
and training data have the same number of columns (563 - 1 from subject, 1 from y, 561 from x).  

## Labels data set with descriptive names (lines 36-37, 41-47)

The columns of xtest and xtrain correspond to the entries in the features.txt file.  So we use read.table() to 
read features.txt into a data frame, and coerce the second column of the data frame (with the names of the features)
into a character vector f1.  



## Extracts mean and standard deviation (




Some people have lost marks in previous courses for not making it easy for their reviewers to give them marks. Don't just make a tidy data set, make it clear to people reviewing it why it is tidy. When you given the variables descriptive names, explain why the names are descriptive. Don't give your reviewers the opportunity to be confused about your work, spell it out to them.
