This ReadMe file describes how "run_analysis.R" script works.

The script can be run in RStudio using {source("run_analysis.R")} command.
The code first loads the required function libraries (data.table and dplyr).
Then it checks the current working directory for a folder named "UCI HAR Dataset" which is supposed to contain all the required data sets and supporting files.
If the folder is not found, a message is displayed to notify the user that the data cannot be found or wrong folder is used. The code prompts the user to press "ENTER" to continue and the required files will be downloaded.
The files are downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and is saved in the current directory as "dataset.zip".
The files are extracted in the same directory and then the file "dataset.zip" is removed.
The code reads the all the data from the Train and Test folders except for the data inside Inertial Signals folder and combines all those data to a single data set called "all_data".
Then, the descriptive variable names from the file "features.txt" are supplied to name the columns of all_data with the addition of "ACTIVITY" and "SUBJECT".
Only the mean and standard deviation measurements are required so they are extracted from all_data together with "SUBJECT" and "ACTIVITY" columns.
The extracted data set is named "meanstd_data".
Next, the code converts numeric elements of activity columns to descriptive names using the file "activity_labels.txt" as reference.
Finally, a tidy data set is created with the average of each variable for each activity and each subject.
A file named "tidy_data.txt" is then created which contains the tidy data set.

In order to view the data in a neat fomat, the command to use in RStudio is {data <- read.table("tidy_data.txt", header = TRUE); View(data)}. This command will change some characters of the column names particularly the dash{-} into a dot{.} and the parethesis{()} into 2 dots{..} but all the other elements will be the same as the original text file.
The tidy data set should contain 180 rows and 81 columns where each feature is in one column and a different observation of the feature is in a different row.