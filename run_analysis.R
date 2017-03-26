run_analysis <- function() {
        
        
        #define source of each file in local folder structure
        
        actlabelfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/activity_labels.txt"
        featfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/features.txt"
        
        subtrainfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/train/subject_train.txt"
        xtrainfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/train/X_train.txt"
        ytrainfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/train/y_train.txt"
        
        subtestfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/test/subject_test.txt"
        xtestfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/test/X_test.txt"
        ytestfile <- "./ProgrammingAssignmentGettingCleaningData/DataSet/test/y_test.txt"
        
        #read each data source needed in the data set analysis
        
        actlabel <- read.delim(actlabelfile ,header = FALSE, sep = "")        
        feat <- read.delim(featfile ,header = FALSE, sep = "");        
        
        subtrain <- read.delim(subtrainfile ,header = FALSE, sep = "") 
        xtrain <- read.delim(xtrainfile ,header = FALSE, sep = "") 
        ytrain <- read.delim(ytrainfile ,header = FALSE, sep = "")
        
        subtest <- read.delim(subtestfile ,header = FALSE, sep = "") 
        xtest <- read.delim(xtestfile ,header = FALSE, sep = "") 
        ytest <- read.delim(ytestfile ,header = FALSE, sep = "")
        
        
        #first clean original Features names to remove special characters
        featclean <- feat
        featclean[,2] <- gsub("\\(","",feat[,2])
        featclean[,2]<- gsub("\\)","",featclean[,2])
        featclean[,2] <- gsub("\\,","",featclean[,2])
        featclean[,2] <- gsub("-","",featclean[,2])
        featclean[,2] <- gsub(" ","",featclean[,2])
        featclean[,2] <- gsub("_","",featclean[,2])
        
        #before merging both datasets, need to homologate header names with friendly names
        #included ID row in the column names in order to make the name unique, so that later
        #can use select statement from dplyr library
        i=1
        while (i<=dim(xtrain)[2]) {
                colnames(xtrain)[i] <- paste(featclean[i,1], "_" , featclean[i,2], sep = "")
                colnames(xtest)[i] <- paste(featclean[i,1], "_" , featclean[i,2], sep = "")
                i=i+1
        }
        
        #assign training labels to ytrain and ytest
        ytrainlab <- merge(actlabel,ytrain,by.x ="V1",by.y = "V1" )
        ytestlab <- merge(actlabel,ytest,by.x ="V1",by.y = "V1" )
                
        #add column identifying the type of source, before merging both data sets,: train and test
        # bind columns for activity labels and subject ID for test and training main data sets
        xtrain  <-  cbind("train", subtrain, ytrainlab, xtrain)
        xtest  <-  cbind("test", subtest, ytestlab, xtest)
        
        #rename new columns
        colnames(xtrain)[1] <- "Source"
        colnames(xtrain)[2] <- "SubjectID"
        colnames(xtrain)[3] <- "TrainingID"
        colnames(xtrain)[4] <- "TrainingLabel"
        
        colnames(xtest)[1] <- "Source"
        colnames(xtest)[2] <- "SubjectID"
        colnames(xtest)[3] <- "TrainingID"
        colnames(xtest)[4] <- "TrainingLabel"
        
        
        #merge both data sets
        xtraintest <- rbind(xtrain,xtest)
        
        #extract only variables related to mean and standard deviation measurements
        #load library dplyr to use select statement
        library(dplyr)
        xtraintest_MeanStd <- select(xtest,grep("*std*|*mean*|SubjectID|TrainingID",names(xtraintest)))
        
        #loop through the data set a filtering by Activity ID and subject ID, and calculate the mean to each variable
        #then rbing each result in new dataset
        
        #counter for activity labels, max =6
        i=1
        while (i<=6) {
                #counter for number of subjects, max=30
                j=1       
                 while (j<=30) {
                        if(i==1 & j==1){
                                #initiate list
                                MeanStd_Mean <- (colMeans(filter(xtraintest_MeanStd,TrainingID == i,SubjectID == j),na.rm = TRUE))
                                j=j+1
                        }
                        else {
                                #rbind next mean of subject/Activity
                                MeanStd_Mean <- rbind(MeanStd_Mean, (colMeans(filter(xtraintest_MeanStd,TrainingID == i,SubjectID == j),na.rm = TRUE)))
                                j=j+1
                        }
                        }
                i=i+1
        }
        
        
        #final output: average of each std and meand variables of test and train original data sets,
        #per subject and activity
        
        #assign again Training labels to new data set, and rename variables with friendly names
        MeanDataSet <- merge(actlabel, MeanStd_Mean[complete.cases(MeanStd_Mean),],by.x = "V1", by.y =  "TrainingID")
        colnames(MeanDataSet)[1] <- "TrainingID"
        colnames(MeanDataSet)[2] <- "TrainingLabel"
        
        #for output and validation purpose only
        write.csv(MeanDataSet, file = "./mean.csv", ,quote = FALSE, sep = ",",col.names = TRUE)
        
        #for submitting assignment
        write.table(MeanDataSet, "MeanDataSet.txt", row.names = FALSE)
        
        MeanDataSet
        
}

