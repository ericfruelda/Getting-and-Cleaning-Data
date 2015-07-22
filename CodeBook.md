This CodeBook describes the variables, the data and all the transformations that were performed to get a tidy data by running the script "run_analysis.R". Please read the ReadMe file in this repo if you want to know how the script works. A copy of the output tidy data is also located in this repo in the file "tidy_data.txt".

The is the site where the original data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project was downloaded from this address:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The "run_analysis.R" script is run in RStudio to run the analysis of the data set.
First, the working directory is saved to workingdirectory variable.
Then code checks the working directory for a folder named "UCI HAR Dataset" which is supposed to contain all the required data sets and supporting files.
If the folder is not found, a message is displayed to notify the user that the data cannot be found or wrong folder is used and the code prompts the user to press "ENTER" to continue.
The address from where the file should be downloaded is given above and this is saved to a variable named url.
The required files are downloaded from url which is actually inside a zip file. The downloaded zip file is named "dataset.zip" and is saved in the working directory.
The script automatically extracts all the files in the working directory and then deletes the downloaded zip file.

The folder "UCI HAR Dataset" should now be located in the working directory and will have the following contents:
train			[folder]
test			[folder]
activity_labels.txt	[file]
features.txt		[file]
features_info.txt	[file]
README.txt		[file]
The folder "train" will have the following contents:
Inertial Signals	[folder]
subject_train		[file]
X_train.txt		[file]
y_train.txt		[file]
The folder "Inertial Signals" inside "train" folder will have the following contents:
body_acc_x_train.txt	[file]
body_acc_y_train.txt	[file]
body_acc_z_train.txt	[file]
body_gyro_x_train.txt	[file]
body_gyro_y_train.txt	[file]
body_gyro_z_train.txt	[file]
total_acc_x_train.txt	[file]
total_acc_y_train.txt	[file]
total_acc_z_train.txt	[file]
The folder "test" will have the following contents:
Inertial Signals	[folder]
subject_test		[file]
X_test.txt		[file]
y_test.txt		[file]
The folder "Inertial Signals" inside "test" folder will have the following contents:
body_acc_x_test.txt	[file]
body_acc_y_test.txt	[file]
body_acc_z_test.txt	[file]
body_gyro_x_test.txt	[file]
body_gyro_y_test.txt	[file]
body_gyro_z_test.txt	[file]
total_acc_x_test.txt	[file]
total_acc_y_test.txt	[file]
total_acc_z_test.txt	[file]

For this analysis, the contents of the folder "Inertial Signals" from the "train" and "test" folders are not used. This is because the future steps will require the extraction of the means and standard measurements only so the data from the "Inertial Signals" folder will still have to be removed anyway.

The train_address variable is created to provide a path to the "train" folder.
The data from the files X_train.txt, y_train.txt and subject_train.txt from the train_address path are read and stored in X_train_data [7352x561 data frame], y_train_data [7352x1 data frame] and subject_train_data [7352x1 data frame] variables respectively.
In the same way, the test_address variable is created to provide a path to the "test" folder.
The data from the files X_test.txt, y_test.txt and subject_test.txt from the test_address path are read and stored in X_test_data [2947x561 data frame], y_test_data [2947x1 data frame] and subject_test_data [2947x1 data frame] variables respectively.
Then, the X_train_data, y_train_data and subject_train_data are combined to become train_data which is a 7352x563 data frame.
In the same way, the X_test_data, y_test_data and subject_test_data are combined to become test_data which is a 2947x563 data frame.
Finally, train_data and test_data are combined to create all_data which is a 10299x563 data frame.

The data from features.txt file from the "UCI HAR Dataset" folder is read and stored in a variable called features [561x2 data frame].
The elements of column 2 of features are used to provide descriptive variable names to the columns of all_data with the addition of "ACTIVITY" and "SUBJECT" to name the last 2 columns.

The all_data variable is processed to remove the columns that have duplicated names which results to a 10299x479 data frame. 
Then, the "SUBJECT", "ACTIVITY" and all columns that has mean and standard deviation measurements are extracted from all_data resulting to a 10299x81 data frame called meanstd_data.
The mean and standard deviation measurements are extracted by selecting all column names that contain the words "mean" or "std" but the column names that contain the word "angle" are excluded even if they have the words "mean" or "std" because they are not exactly part of the mean and standard deviation measurements that are required for the final dataset.
Furthermore, the column names that contain the word "meanFreq" were included because they are considered part of the mean measurements of the variables.

Next, the data from activity_labels.txt file from the "UCI HAR Dataset" folder is read and stored in a variable called activity [6x2 data frame].
The column 2 elements of activity are used with reference to column 1 elements to convert the numeric elements of "ACTIVITY" column of meanstd_data to their respective descriptive activity names i.e. 1 is converted to WALKING, 2 is converted to WALKING_UPSTAIRS, etc.

Finally, a tidy data set is created with the average of each measurement for each activity and each subject. This results to a 180x81 data frame and named tidy_data.
All column names of tidy_data except for "SUBJECT" and "ACTIVITY" are converted to uppercase and prefixed with "AVRG_".
A text file for tidy_data is then created in the working directory with the file name "tidy_data.txt".

The resulting column names of tidy_data are below:

"SUBJECT"
"ACTIVITY"
"AVRG_TBODYACC-MEAN()-X"
"AVRG_TBODYACC-MEAN()-Y"
"AVRG_TBODYACC-MEAN()-Z"
"AVRG_TGRAVITYACC-MEAN()-X"
"AVRG_TGRAVITYACC-MEAN()-Y"
"AVRG_TGRAVITYACC-MEAN()-Z"
"AVRG_TBODYACCJERK-MEAN()-X"
"AVRG_TBODYACCJERK-MEAN()-Y"
"AVRG_TBODYACCJERK-MEAN()-Z"
"AVRG_TBODYGYRO-MEAN()-X"
"AVRG_TBODYGYRO-MEAN()-Y"
"AVRG_TBODYGYRO-MEAN()-Z"
"AVRG_TBODYGYROJERK-MEAN()-X"
"AVRG_TBODYGYROJERK-MEAN()-Y"
"AVRG_TBODYGYROJERK-MEAN()-Z"
"AVRG_TBODYACCMAG-MEAN()"
"AVRG_TGRAVITYACCMAG-MEAN()"
"AVRG_TBODYACCJERKMAG-MEAN()"
"AVRG_TBODYGYROMAG-MEAN()"
"AVRG_TBODYGYROJERKMAG-MEAN()"
"AVRG_FBODYACC-MEAN()-X"
"AVRG_FBODYACC-MEAN()-Y"
"AVRG_FBODYACC-MEAN()-Z"
"AVRG_FBODYACC-MEANFREQ()-X"
"AVRG_FBODYACC-MEANFREQ()-Y"
"AVRG_FBODYACC-MEANFREQ()-Z"
"AVRG_FBODYACCJERK-MEAN()-X"
"AVRG_FBODYACCJERK-MEAN()-Y"
"AVRG_FBODYACCJERK-MEAN()-Z"
"AVRG_FBODYACCJERK-MEANFREQ()-X"
"AVRG_FBODYACCJERK-MEANFREQ()-Y"
"AVRG_FBODYACCJERK-MEANFREQ()-Z"
"AVRG_FBODYGYRO-MEAN()-X"
"AVRG_FBODYGYRO-MEAN()-Y"
"AVRG_FBODYGYRO-MEAN()-Z"
"AVRG_FBODYGYRO-MEANFREQ()-X"
"AVRG_FBODYGYRO-MEANFREQ()-Y"
"AVRG_FBODYGYRO-MEANFREQ()-Z"
"AVRG_FBODYACCMAG-MEAN()"
"AVRG_FBODYACCMAG-MEANFREQ()"
"AVRG_FBODYBODYACCJERKMAG-MEAN()"
"AVRG_FBODYBODYACCJERKMAG-MEANFREQ()"
"AVRG_FBODYBODYGYROMAG-MEAN()"
"AVRG_FBODYBODYGYROMAG-MEANFREQ()"
"AVRG_FBODYBODYGYROJERKMAG-MEAN()"
"AVRG_FBODYBODYGYROJERKMAG-MEANFREQ()"
"AVRG_TBODYACC-STD()-X"
"AVRG_TBODYACC-STD()-Y"
"AVRG_TBODYACC-STD()-Z"
"AVRG_TGRAVITYACC-STD()-X"
"AVRG_TGRAVITYACC-STD()-Y"
"AVRG_TGRAVITYACC-STD()-Z"
"AVRG_TBODYACCJERK-STD()-X"
"AVRG_TBODYACCJERK-STD()-Y"
"AVRG_TBODYACCJERK-STD()-Z"
"AVRG_TBODYGYRO-STD()-X"
"AVRG_TBODYGYRO-STD()-Y"
"AVRG_TBODYGYRO-STD()-Z"
"AVRG_TBODYGYROJERK-STD()-X"
"AVRG_TBODYGYROJERK-STD()-Y"
"AVRG_TBODYGYROJERK-STD()-Z"
"AVRG_TBODYACCMAG-STD()"
"AVRG_TGRAVITYACCMAG-STD()"
"AVRG_TBODYACCJERKMAG-STD()"
"AVRG_TBODYGYROMAG-STD()"
"AVRG_TBODYGYROJERKMAG-STD()"
"AVRG_FBODYACC-STD()-X"
"AVRG_FBODYACC-STD()-Y"
"AVRG_FBODYACC-STD()-Z"
"AVRG_FBODYACCJERK-STD()-X"
"AVRG_FBODYACCJERK-STD()-Y"
"AVRG_FBODYACCJERK-STD()-Z"
"AVRG_FBODYGYRO-STD()-X"
"AVRG_FBODYGYRO-STD()-Y"
"AVRG_FBODYGYRO-STD()-Z"
"AVRG_FBODYACCMAG-STD()"
"AVRG_FBODYBODYACCJERKMAG-STD()"
"AVRG_FBODYBODYGYROMAG-STD()"
"AVRG_FBODYBODYGYROJERKMAG-STD()"

NOTE:
In order to view the elements of "tidy_data.txt" in a neat fomat, the command to use in RStudio is {data <- read.table("tidy_data.txt", header = TRUE); View(data)}. However, this command will change some characters of the column names particularly the dash{-} into a dot{.} and the parenthesis{()} into 2 dots{..} but all the other elements will be the same as the original text file.