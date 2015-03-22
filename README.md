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
into a character vector f1.  

The entries of f1 are inherently descriptive, as they indicate whether they are time (t) or frequency (f) domain signals, 
come from the Body or Gravity, were obtained from the accelerometer (Acc) or gyroscope (Gyro), were processed 
to calculate Jerk or magnitude (Mag), and the axial direction (X, Y, Z).  Further information, particularly on how these
signals were processed to obtain the final variables, can be found in the features_info.txt file in the UCI HAR 
Dataset folder. 

Nonetheless, we clean up the entries by using str_replace_all() to:
* Converting "-"s to "."s for easier reading - this yields f2
* Removing "()"s which don't add to the meaning of the names - this yields f3
* Changing "std" to "std_dev" which is more intuitive as an abbreviation for standard deviation - this yields **f4**

We then create a column names vector "col" by concatenating the strings "Subject" (corresponding to column 1 or 
the subjtest/subjtrain frame), "Activity" (corresponding to column 2 or the ytest/ytrain frame) and **f4**, and assign
col as the labels for the data frame "data" using the colnames() function.  

## Extracts mean and standard deviation (lines 53, 58-59)

Based on the features_info.txt file in the UCI HAR Dataset folder, the variables that represent the means and standard
deviations for each measurement contain "mean()", "std()" or "meanFreq()" in the features data frame.  
We have excluded the variables containing gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean and tBodyGyroJerkMean
as they are used in the "angle()" variable and therefore don't represent a mean or standard deviation quantity.  

We use the grep() function to identify which entries in the features data frame contain "mean" and "std".  This 
captures "mean()", "std()" and "meanFreq()" variables but not the excluded variables with capitalised "Mean", as the 
grep() function is by default case-sensitive.  

The grep() function yields an integer vector corresponding to the column numbers of "data" that contain means or 
standard deviations, but we first have to (i) sort this in ascending order of entries, and (ii) add 2 to this vector 
because the columns of xtest/xtrain (i.e. the entries in the features data frame) are right-shifted by 2 in the "data" 
data frame due to the left-side column binding of subjtest/subjtrain (1 column) and ytest/ytrain (1 column).
This integer vector is stored in selectcols.

Finally, we subset the "data" data frame so only the "Subject", "Activity" and selectcols remain (data2) and wrap 
this using the tbl_df() function in the dplyr package to yield the data frame "data3".  

## Names activities in the data set (lines 37, 64)

The mapping of activity labels (1:6) in the ytest/ytrain files to actual activities can be found in the activity_labels.txt
file.  We therefore read this file into a data frame "activities" using the read.table() function.  

We then mutate the "Activity" column of data3, going over each row using the sapply() function to (i) take in the
activity label (1:6), (ii) match it against the corresponding activity (e.g. walking, standing) in the "activities" 
data frame, and (iii) spit out the activity as a factor.  This activity name then replaces its activity label in the 
"Activity" column, so instead of a number, we have a name of an activity for each observation. 
The mutated data frame is stored as "data4".




Some people have lost marks in previous courses for not making it easy for their reviewers to give them marks. Don't just make a tidy data set, make it clear to people reviewing it why it is tidy. When you given the variables descriptive names, explain why the names are descriptive. Don't give your reviewers the opportunity to be confused about your work, spell it out to them.
