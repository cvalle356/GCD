===================================
Project Submission for Getting and Cleaning Data Course Project
===================================
This CodeBook details the script used to create two tidy data files: combinedtidy.csv and tidy2.csv. The data collected by the original researchers were process and cleaned for noise and made available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

=========================
STUDY DESIGN & BACKGROUND
=========================
This is an excerpt for the study design from the original authors' README file. 
	"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. "

=========================
ORIGINAL DATA
=========================
The original data were spread across multiple files. The measurement data for the test and training observations were in the 'test/X_test.txt' and 'train/X_train.txt' respectively. Labels for the data sets were in the 'features.txt' file. Subjects IDs (1-30: for all thirty participants) for the observations were in the 'train/subject_train.txt' and 'test/subject_test.txt' files. The activity code (1-6) for each observation were on the 'test/y_test.txt' and 'data/train/y_train.txt' files. The labels for the activity codes are in the 'activity_labels.txt' file. These data files were used, merged and filtered to create the two tidy data sets. 

File descriptions from original authors' README(only files used by script are listed here):
	- 'features_info.txt': Shows information about the variables used on the feature vector.
	- 'features.txt': List of all features.
	- 'activity_labels.txt': Links the class labels with their activity name.
	- 'train/X_train.txt': Training set.
	- 'train/y_train.txt': Training labels.
	- 'test/X_test.txt': Test set.
	- 'test/y_test.txt': Test labels.
	The following files are available for the train and test data. Their descriptions are equivalent. 
	- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

=========================	
PROCESSED DATA
=========================
The following are the steps to create the two tidy data files using the above listed files. 

creation of 'combinedtidy.csv' by run_analysis.R script 

1. reads all data files listed above and creates data frames using the files
2. Loads package dplyer
3. Creates a third variable for the features data frame by combining the row index and feature name from the feature list. This is done to avoid issues with repeat variable names
4. Creates a vector of feature (measure) names using the newly created variable in data frame from step 3
5. Converts all data frames into DPLYR data frames using tbl_df()
6. Renames columns on the activity label and subject data frames to avoid duplicate variable names when merged measurement data frames
7. Adds activity labels and subjects colums to main measurement data sets (test and train)
8. Adds group variable to keep track of training and test groups before merging rows
9. Applies the vector with feature(measure) names to the colums of the main measurement data set (train and test: 561 columns)
10. Combines both test and train data sets by using rbind() function and removes large data sets not being used to clear memory
11. Applies descriptive labels by matching the activity label ID on the main data set to the activity label data frame. Or recodes the activity label by joining activity labels data fram to the full data frame
12. Converts working data frame into DPLYR data frames using tbl_df() 
13. Filters subject, activitylabel, and any other variables using mean() and std() functions to new data frames and then they were merged to create a new filtered data frame. Removes any other data frames not used to clear memory.
14. Cleans up variable names for remaining measure/feature variables. Used 'feature_info.txt' to interpret variable names/codes. Used gsubs to replace coding pattern with descriptive pattern.
15. Writes 'combinedtidy.csv' file to output directory. Will create directory if it does not exist. The resulting data file contains a table with the variables listed below.


creation of 'combinedtidy.csv' by run_analysis.R script 

1. Uses the resulting data frame (combining test and train data) from the above listed steps.
2. Groups the row/observation by 'subjects' and 'activity' using the DPLYR group_by() function.
3. Collapses the observations by subject by activity and creates new rows based on the mean using each measure/feature.
4.  Writes 'tidy2.csv' file to output directory. Will create directory if it does not exist. The resulting data file contains a table with the summary (mean) of the variables by subject by activity for the variables listed below.


=========================
List of variables included in tidy data files:
=========================
(Variable Name)	: short description / additional description

subject	: ID of study participant 
group	: whether the observation was from the test or train data set
activitylabel	: descriptive label of activity performed during the measurements
time-body-linear-acceleration-meanofX-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-meanofY-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-meanofZ-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-gravity-acceleration-meanofX-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-gravity-acceleration-meanofY-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-gravity-acceleration-meanofZ-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-Jerk-meanofX-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-Jerk-meanofY-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-Jerk-meanofZ-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-meanofX-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-meanofY-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-meanofZ-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-Jerk-meanofX-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-Jerk-meanofY-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-Jerk-meanofZ-direction	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-Euclidean-norm-mean	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-gravity-acceleration-Euclidean-norm-mean	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-linear-acceleration-JerkEuclidean-norm-mean	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-Euclidean-norm-mean	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
time-body-angular-velocity-JerkEuclidean-norm-mean	: mean of time (time at constant rate of 50 Hz) of measurement  type by direction X,Y,or Z
frequency-body-linear-acceleration-meanofX-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-meanofY-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-meanofZ-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Jerk-meanofX-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Jerk-meanofY-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Jerk-meanofZ-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-angular-velocity-meanofX-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-angular-velocity-meanofY-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-angular-velocity-meanofZ-direction	: mean frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Euclidean-norm-mean	: mean frequency domain signals  of measurement type by direction
fBodyBodyAccJerkEuclidean-norm-mean	: mean frequency domain signals  of measurement type by direction
fBodyBodyGyroEuclidean-norm-mean	: mean frequency domain signals  of measurement type by direction
fBodyBodyGyroJerkEuclidean-norm-mean	: mean frequency domain signals  of measurement type by direction
time-body-linear-acceleration-standarddeviationofX-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-standarddeviationofY-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-standarddeviationofZ-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-gravity-acceleration-standarddeviationofX-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-gravity-acceleration-standarddeviationofY-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-gravity-acceleration-standarddeviationofZ-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-Jerk-standarddeviationofX-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-Jerk-standarddeviationofY-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-Jerk-standarddeviationofZ-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-standarddeviationofX-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-standarddeviationofY-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-standarddeviationofZ-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-Jerk-standarddeviationofX-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-Jerk-standarddeviationofY-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-Jerk-standarddeviationofZ-direction	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-Euclidean-norm-standarddeviation	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-gravity-acceleration-Euclidean-norm-standarddeviation	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-linear-acceleration-JerkEuclidean-norm-standarddeviation	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-Euclidean-norm-standarddeviation	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
time-body-angular-velocity-JerkEuclidean-norm-standarddeviation	: standard deviation of time (time at constant rate of 50 Hz) of measurement type by direction
frequency-body-linear-acceleration-standarddeviationofX-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-standarddeviationofY-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-standarddeviationofZ-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Jerk-standarddeviationofX-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Jerk-standarddeviationofY-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Jerk-standarddeviationofZ-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-angular-velocity-standarddeviationofX-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-angular-velocity-standarddeviationofY-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-angular-velocity-standarddeviationofZ-direction	: standard deviation of frequency domain signals  of measurement type by direction
frequency-body-linear-acceleration-Euclidean-norm-standarddeviation	: standard deviation of frequency domain signals  of measurement type by direction
fBodyBodyAccJerkEuclidean-norm-standarddeviation	
fBodyBodyGyroEuclidean-norm-standarddeviation	
fBodyBodyGyroJerkEuclidean-norm-standarddeviation	
