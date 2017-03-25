# CourseraGettingCleaningData
Coursera Getting and Cleaning data final class assignment

## Pre conditions of script:
1. access to url for downloading zip file containing original data sets
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. In workspace for R, create the following directory, and follow zip file structure of data source:
./ProgrammingAssignmentGettingCleaningData/DataSet
./ProgrammingAssignmentGettingCleaningData/DataSet/test
./ProgrammingAssignmentGettingCleaningData/DataSet/train

## Post conditions of script:
1. If process runs successfully, the script will generate a mean.csv file in root workspace directory:
"./mean.csv"

with the mean values of all *std* and *mean* variables per subject ID and Activity labels


## Script "run_analysis.R" description:

1. define source of each file in local folder structure

2. read each data source needed in the data set analysis and assign it to respective data frames

3. clean original Features names to remove special characters, from the features.txt source file

4. then will prepare data sets to be able to merge both data sets, X_trian.txt and X_test.txt data sets
		4.1. Before merging both datasets, need to homologate header names of variables with friendly names
        including the ID row in the column names of features.txt, in order to make the name unique, so that later
        can use select statement from dplyr library
				
5. assign training labels to ytrain and ytest, merging the data sets with the activity_labels.txt data frame

6. I decided to add  column identifying the type of source, before merging both data sets,: "train" and "test"

7. Bind columns from 3 data frames: for activity labels and subject ID for test and training main data sets

8. Then rename first 4 columns of merged data set : Source, SubjectID, TrainingID, TrainingLAbel

9. Only now it is possible to merge both main dataframes X_train and X_test

10. Load dplyr library and create new data frame only containing the variables with part of the name containing the string "mean" and "std", for mean and standard deviation variables. Use select statement from dplyr library

11. Loop through the data set and filtering by Activity ID and subject ID, and calculate the mean to each variable then rbing each result in new dataset MeanStd_Mean

12. Final output: average of each std and meand variables of test and train original data sets, per subject and activity, and stored in new data frame MeanDataSet

13. Generate csv output to root workspace folder for this last data frame, file named "mean.csv"
		


