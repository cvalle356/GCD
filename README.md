# GCDproject

===================================
Project Submission for Getting and Cleaning Data Course
===================================

This describes am R script designed to create a tidy data set from a study that collected data from "wearable" technology to study participants readings during certain activity. The data collected by the original researchers were process and cleaned for noise and made available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The README file contains the description of the study and what is contained in the zip file. Although these (link) data have been processed, for our purposes we will call them the raw data. The script will produce two tidy data files from the original data.

STUDY DESIGN
This is an excerpt for the study design from the original authors' README file. 
	"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. "
	
=====================================
The script - run_analysis.R	
=====================================
SET UP
Before running script, you must ensure that you set up the environment to successfully produce the tidy data output. Start by downloading the the raw data zip from the link provided above. Unzip the file to the R working directory and rename the root folder (folder produced by unzipping) to data. Do not move the files or edit the files inside. Make sure you have the DPLYR package installed available in the CRAN network.

RUNNING THE SCRIPT
Run the run_analysis.R script. The script will produce two tidy data files (combinedtidy.csv and tidy2.csv) in the output folder in the R working directory. The combinedtidy.csv merged the test and training data set, applied descriptive labels to the activity groups, attributed the data to the participant via an ID number, and labelled the data descriptively in a tidy data format. Read the included CodeBook.md for more detail of the transformations. Only the measures where mean() and std() were applied were included in the final tidy data file. The second file (tidy2.csv) is based on the first file (combinedtidy.csv) but provides averages for the observations for participants by activity label on each of he measurements inluded in the original file. Note: This script depends on the DPLYR R package.
