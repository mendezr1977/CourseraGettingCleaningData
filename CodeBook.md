# CodeBook for run_analysis.R

This code book describes the elements involve while running the run_analysis.R script

## Data Sources and Description

The below data sources were extracted form the following link

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The files used durign the analysis are:

* activity_labels.txt: friendly names of the 6 activity types performed by the observed subjects
* features.txt: list of all variables in the fact data sets x_train and x_test
* subject_train.txt: list of subject ID per observation during training exercise (per row in x_train)
* X_train.txt: meaurements for each variable performed during training exercise
* y_train.txt: list of activity IDs' per observation

For the test data the description is equivalent as for the training one above.

## Transformation

* first read the files previously saved in local drives, to respective data frames
* clean features data frame to assign friendly names excluding special characters like ")", "(", " ", "," , "-" , "\_".
* after cleansing some names did not result in unique values, tehrefore concatenation of clean name and record ID was done to achieve uniqueness
* with unique names, the x_train and x_test , had it columns renames with clean and unique feature names (variable names)
* merged training labels to new x_test and x_train dat frames
* assign 4 new columns to data frames to identify source, subject ID, Training ID and Trainng label
* rename new columns to friendly names as above.
* merged both clean data sets: xtrain and ytrain
* load dplyr library
* use select statement to extratc and create new data frame only with "std" and "mean" in variable names
* while loop using filter statement by subject ID and activity ID and calculate the mean of each variable extracted in previous step and assign it to new data frame MeanStd_Mean
* assign again training labels to MEanStd_Mean data frame
* write data frame MeanStd_Mean to csv file and provice data frame as output of function

