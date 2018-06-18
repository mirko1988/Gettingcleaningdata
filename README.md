# Description of Code 

## Introduction

The code reported in the GitHub repository in the dile "run_analysis.R" has the objective to restructure the accelerometer data recovered from the Samsung Galaxy S smartphone.

## Step

1- Merges the training and the test sets to create one data set.

In the first part of the code, the dataset related to training and test subjects are imported in R.
Datasets are merged with the instruction rbind.

2- Extracts only the measurements on the mean and standard deviation for each measurement.

Firstly, the datasets "features" is imported and the measurements on mean and std are extracted with the command "grep".
Then, the data.frame x_data is subsetted using as parameter the positions of the measurements related to mean and standard deviation extracted from "features".

3- Uses descriptive activity names to name the activities in the data set.

Firstly, the DB "acvitivity_labels" is imported in R.With a for loop, the names of the activities are associated with the corresponding numeric codification.

4- Appropriately labels the data set with descriptive variable names.

The "all_data" DB is built and with the rename function of the plyr package are named the columns of the DB

5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

We get a new dataset from the "all_data" grouping by the variables subject and activity. Later, with the "summarize_all" function, we get the mean of the all other variables.
Finally,we write on a file.txt the "all_data_final" DB. 
