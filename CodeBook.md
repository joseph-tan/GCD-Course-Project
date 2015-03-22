# CodeBook  
*Adapted from README.txt and features_info.txt files in UCI HAR Dataset folder*

## Study Design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables (x_test/x_train). 
- Its activity label (y_test/y_train). 
- An identifier of the subject who carried out the experiment (subject_test/subject_train).

## Raw Data

For each subject (subject_test/subject_train) and activity (y_test/y_train), the raw data (x_test/x_train) come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.  The signals can be understood as follows:
* Time domain signals are prefixed with a 't' while frequency domain signals (i.e. after a Fast Fourier Transform (FFT) is applied) are prefixed with an 'f'
* 'Body' and 'Gravity' signals are marked as such
* Acceleration signals captured by the accelerometer are marked as 'Acc' and **are in standard gravity units 'g'**
* Angular velocity signals captured by the gyroscope are marked as 'Gyro' and **are in units of radians per second**
* Linear jerk signals derived in time from body linear acceleration are marked as 'AccJerk' and **are in units of g per second**
* Angular jerk signals derived in time from angular velocity are marked as 'GyroJerk' and **are in units of radians per second^2**
* Magnitude of three-dimensional signals calculated using the Euclidean norm are suffixed with 'Mag' and **follow the units of Acc/Gyro/AccJerk/GyroJerk** (i.e. tBodyAccMag follows the units of Acc (g))
* -X, -Y and -Z are used to denote 3-axial signals in the X, Y and Z directions respectively
**Annex 1** below contains the full list of signals.  

*Derivation of raw data*  
Time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

*Derivation of variables*  
The set of variables that were estimated from these signals are:   

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal   
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between 2 vectors.  Additional vectors obtained by averaging the signals in a signal window sample (gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean) are used on the angle() variable

## Processed Data

* subject_test/subject_train were merged and converted to a factor variable "Subject" with 30 levels - 1:30, each representing one subject.  
* y_test/y_train were merged and converted to a factor variable "Activity" with 6 levels - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, each representing one activity.
* x_test/x_train were merged and only the mean(), std() and meanFreq() variables derived from the signals were retained (79 in all), and considered numeric amounts. Annex 2 below lists the variables in the processed data.
* For each "Subject-Activity" combination (180 in all - 30 subjects x 6 activities), the average of each of the 79 selected variables across all observations of that "Subject-Activity" combination was taken using the summarise_each(funs(mean)) function. 
* The processed data is a 180 x 81 data frame, with 180 observations corresponding to the 180 unique "Subject-Activity" combinations, and for each combination, the average value of each of the 79 selected variables that contain mean(), std() or meanFreq().  

## Annex 1:  Full List of Signals

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

## Annex 2:  Full List of Variables
 [1] "Subject"                       "Activity"                     
 [3] "tBodyAcc.mean.X"               "tBodyAcc.mean.Y"              
 [5] "tBodyAcc.mean.Z"               "tBodyAcc.std_dev.X"           
 [7] "tBodyAcc.std_dev.Y"            "tBodyAcc.std_dev.Z"           
 [9] "tGravityAcc.mean.X"            "tGravityAcc.mean.Y"           
[11] "tGravityAcc.mean.Z"            "tGravityAcc.std_dev.X"        
[13] "tGravityAcc.std_dev.Y"         "tGravityAcc.std_dev.Z"        
[15] "tBodyAccJerk.mean.X"           "tBodyAccJerk.mean.Y"          
[17] "tBodyAccJerk.mean.Z"           "tBodyAccJerk.std_dev.X"       
[19] "tBodyAccJerk.std_dev.Y"        "tBodyAccJerk.std_dev.Z"       
[21] "tBodyGyro.mean.X"              "tBodyGyro.mean.Y"             
[23] "tBodyGyro.mean.Z"              "tBodyGyro.std_dev.X"          
[25] "tBodyGyro.std_dev.Y"           "tBodyGyro.std_dev.Z"          
[27] "tBodyGyroJerk.mean.X"          "tBodyGyroJerk.mean.Y"         
[29] "tBodyGyroJerk.mean.Z"          "tBodyGyroJerk.std_dev.X"      
[31] "tBodyGyroJerk.std_dev.Y"       "tBodyGyroJerk.std_dev.Z"      
[33] "tBodyAccMag.mean"              "tBodyAccMag.std_dev"          
[35] "tGravityAccMag.mean"           "tGravityAccMag.std_dev"       
[37] "tBodyAccJerkMag.mean"          "tBodyAccJerkMag.std_dev"      
[39] "tBodyGyroMag.mean"             "tBodyGyroMag.std_dev"         
[41] "tBodyGyroJerkMag.mean"         "tBodyGyroJerkMag.std_dev"     
[43] "fBodyAcc.mean.X"               "fBodyAcc.mean.Y"              
[45] "fBodyAcc.mean.Z"               "fBodyAcc.std_dev.X"           
[47] "fBodyAcc.std_dev.Y"            "fBodyAcc.std_dev.Z"           
[49] "fBodyAcc.meanFreq.X"           "fBodyAcc.meanFreq.Y"          
[51] "fBodyAcc.meanFreq.Z"           "fBodyAccJerk.mean.X"          
[53] "fBodyAccJerk.mean.Y"           "fBodyAccJerk.mean.Z"          
[55] "fBodyAccJerk.std_dev.X"        "fBodyAccJerk.std_dev.Y"       
[57] "fBodyAccJerk.std_dev.Z"        "fBodyAccJerk.meanFreq.X"      
[59] "fBodyAccJerk.meanFreq.Y"       "fBodyAccJerk.meanFreq.Z"      
[61] "fBodyGyro.mean.X"              "fBodyGyro.mean.Y"             
[63] "fBodyGyro.mean.Z"              "fBodyGyro.std_dev.X"          
[65] "fBodyGyro.std_dev.Y"           "fBodyGyro.std_dev.Z"          
[67] "fBodyGyro.meanFreq.X"          "fBodyGyro.meanFreq.Y"         
[69] "fBodyGyro.meanFreq.Z"          "fBodyAccMag.mean"             
[71] "fBodyAccMag.std_dev"           "fBodyAccMag.meanFreq"         
[73] "fBodyBodyAccJerkMag.mean"      "fBodyBodyAccJerkMag.std_dev"  
[75] "fBodyBodyAccJerkMag.meanFreq"  "fBodyBodyGyroMag.mean"        
[77] "fBodyBodyGyroMag.std_dev"      "fBodyBodyGyroMag.meanFreq"    
[79] "fBodyBodyGyroJerkMag.mean"     "fBodyBodyGyroJerkMag.std_dev" 
[81] "fBodyBodyGyroJerkMag.meanFreq"
