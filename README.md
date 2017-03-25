# CourseraGettingCleaningData
Coursera Getting and Cleaning data final class assigment

## Pre conditions of script:
1. access to url for downloading zip file containing original data sets
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. In workspace for R, create the following directory, and follow zip file stucture of data source:
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
