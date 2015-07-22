## For the given set of data for the Coursera Getting and Cleaning Data Course
## Project (Course ID: getdata-030), this script does the following:

## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each
## measurement.
## 3) Uses descriptive activity names to name the activities in the data set.
## 4) Appropriately labels the data set with descriptive variable names.
## 5) From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
## For other details, please read the ReadMe file.

  library(data.table)
  library(dplyr)
  workingdirectory <- getwd()
   
  ## Checking for folder with name "UCI HAR Dataset". If folder is not found,
  ## notification to download files is displayed and proceeds to download when
  ## ENTER is pressed.
  if(!file.exists("UCI HAR Dataset")) {
    invisible(readline(prompt = "Data Not Found or Wrong Folder.
                       Downloading Files... Press [ENTER] to continue"))
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, dest="dataset.zip", mode="wb") 
    unzip("dataset.zip", exdir = workingdirectory)
    unlink("dataset.zip")
  }
  
  ## Reading train data
  train_address <- paste(workingdirectory,"/UCI HAR Dataset/train/",sep="")
  X_train_data <- read.table(paste(train_address,"X_train.txt",sep=""))
  y_train_data <- read.table(paste(train_address,"y_train.txt",sep=""))
  subject_train_data <- read.table(paste(train_address,"subject_train.txt",
                                         sep=""))
  ## Reading test data
  test_address <- paste(workingdirectory,"/UCI HAR Dataset/test/",sep="")
  X_test_data <- read.table(paste(test_address,"X_test.txt",sep=""))
  y_test_data <- read.table(paste(test_address,"y_test.txt",sep=""))
  subject_test_data <- read.table(paste(test_address,"subject_test.txt",sep=""))
  
  ## Merging all data
  train_data <- cbind(X_train_data, y_train_data, subject_train_data)
  test_data <- cbind(X_test_data, y_test_data, subject_test_data)
  all_data <- rbind(train_data, test_data)
  
  ## Adding descriptive variable names to columns of all_data
  features <- read.table(paste(workingdirectory,"/UCI HAR Dataset/features.txt",
                               sep=""))
  colnames(all_data) <- c(as.vector(features[,2]),"ACTIVITY","SUBJECT")
  
  ## Extracting mean and standard deviation measurements
  all_data <- all_data[!duplicated(names(all_data))]      ## Removes duplicates
  meanstd_data <- select(all_data, SUBJECT, ACTIVITY, contains("mean"),
                         contains("std"), -contains("angle"))
  
  ## Converting numeric elements of activity columns to descriptive names
  activity <- read.table(paste(workingdirectory,
                               "/UCI HAR Dataset/activity_labels.txt", sep=""))
  for(i in 1:nrow(meanstd_data)) {
    for (l in 1:6) {
      if((meanstd_data[i,"ACTIVITY"] == l) == TRUE)
        meanstd_data[i,"ACTIVITY"] <- as.character(activity[l,2])
    }
  }
  
  ## Creating a tidy data set with the average of each variable for each
  ## activity and each subject.
  tidy_data <- aggregate(. ~ SUBJECT+ACTIVITY, data = meanstd_data, mean)
  colnames(tidy_data)[3:ncol(tidy_data)] <-
    paste("AVRG", toupper(colnames(tidy_data)[3:ncol(tidy_data)]), sep="_")
  write.table(tidy_data, "tidy_data.txt", row.names=FALSE)
