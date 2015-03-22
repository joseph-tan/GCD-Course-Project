# GCD-Course-Project

## Objective

This README explains the code in the run_analysis.R file, which:
* Merges the training and the test sets to create one data set;
* Extracts only the measurements on the mean and standard deviation for each measurement; 
* Uses descriptive activity names to name the activities in the data set;
* Appropriately labels the data set with descriptive variable names; and
* From the data set created, creates a second, independent tidy data set with 
    the average of each variable for each activity and each subject.

As stated in the run_analysis.R file, we assume that the UCI HAR Dataset folder is saved in the user's
working directory.  

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
to calculate Jerk or magnitude (Mag), and the axial direction (X, Y, Z).  The variable names are already long enough as
they are, so I decided not to expand them further, but instead, further information, particularly on how these
signals were processed to obtain the final variables, can be found in the Code Book and the features_info.txt file 
in the UCI HAR Dataset folder. 

Nonetheless, we clean up the entries by using str_replace_all() to:
* Convert "-"s to "."s for easier reading - this yields f2
* Remove "()"s which don't add to the meaning of the names - this yields f3
* Change "std" to "std_dev" which is more intuitive as an abbreviation for standard deviation - this yields **f4**

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
data frame, and (iii) spit out the activity name as a factor.  This activity name then replaces its activity label 
(i.e. a number) for each observation in the "Activity" column. 
The mutated data frame is stored as "data4".

## Creates second tidy data set with average of each variable for each Subject/ Activity (lines 70-72, 76)

We start with data4 and chain several functions under the dplyr package.  First, we group_by() the "Subject" and
"Activity" columns - this yields 180 unique groups (30 subjects x 6 activities).  Then we use the summarise_each()
function to find the mean of all the observations of each variable (i.e. column) for each unique group.  This is
done by applying funs(mean) to each column.  

This should yield a tidy data set "tidydata".  The data is tidy because each measurement (i.e. variable) is in a separate
column, and each observation of the grouped data is in a separate row.  Each observation of the grouped data corresponds to 
the measurements of one subject carrying out one activity.  There is also a row at the top of tidydata with the variable
names.  Where these may not be human-readable, we have explained them in the Code Book.  

Finally, we write the tidydata data frame into a file called "tidydata.txt" which is saved in the user's working directory.  

This file can be opened in R using the following code:  
data100 <- read.table("./tidydata.txt", header = TRUE)  
View(data100)

References:  
https://class.coursera.org/getdata-012/forum/thread?thread_id=9  
"The components of tidy data" lecture slides
