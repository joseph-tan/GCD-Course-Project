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

## Labels data set with descriptive names (lines 36, 41-47)

The columns of xtest and xtrain correspond to the entries in the features.txt file.  So we use read.table() to 
read features.txt into a data frame, and coerce the second column of the data frame (with the names of the features)
into a character vector f1.  These are inherently descriptive and further information can be found in the 
features_info.txt file in the UCI HAR Dataset folder, but we clean up the names by using str_replace_all() to:
* Converting "-"s to "."s for easier reading - this yields f2
* Removing "()"s which don't add to the meaning of the names - this yields f3
* Changing "std" to "std_dev" which is more intuitive as an abbreviation for standard deviation - this yields f4

We then create a column names vector "col" by concatenating the strings "Subject" (corresponding to column 1 or 
the subjtest/subjtrain frame), "Activity" (corresponding to column 2 or the ytest/ytrain frame) and f4, and assign
col as the labels for the data frame "data" using the colnames() function.  





## Extracts mean and standard deviation (




Some people have lost marks in previous courses for not making it easy for their reviewers to give them marks. Don't just make a tidy data set, make it clear to people reviewing it why it is tidy. When you given the variables descriptive names, explain why the names are descriptive. Don't give your reviewers the opportunity to be confused about your work, spell it out to them.
