# GETTING CLEAN DATA  - COURSE PROJECT

# README

## Following from the instruction of the project the "run_analysis" does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent "tidy"" data set with the average of each variable for each activity and each subject. 

## Process and Clean Data
1. The documentation contained in the folder data (see repo), allow us to identify activities and features
2. We first extract the data from zip file, the data is in csv/txt format
3. We "read" both train and test data, and merge them. However, this data frame does not have column names
4. We read features and activity files with the aim to extract a vector of features and activities to use as column names and row labels.
5. We summarize the data by activity and subject (individual)

