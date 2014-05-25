Getting and Cleaning Data Course Project 1
============

Date: 25.05.2013
Author: A.Zuoza

The goals of this scrip are:
- to read and merge test and train data sets.
- to rename variables names.
- to form the final data set with only mean and standard deviation for each measurement.
- to create second data set, with the average of each variable for each activity and each subject.

Reading data
------------
The data was downloaded on 14.04.2014 from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This script assumes that the data was unziped in the Data directory wich is in the current working directory. It is expecting that the names and path of the data are as follows:

|Data file     | Path                   |
|:--------------:|:-----------------------:|
|X_test data   |./Data/test/X_test.txt  |
|y_test data   |./Data/test/y_test.txt  |
|X_train data  |./Data/train/X_train.txt|
|y_train data  |./Data/train/y_train.txt|
|test subjects |./Data/test/subject_test.txt|
|train subjects|./Data/train/subject_train.txt|
|activity labels|./Data/activity_labels.txt|
|variable names |./Data/features.txt|


Renaming variable names
-----------------------

Variables renamed according to the Google R style guide.
By renaming of variables the folowing changes was made:
- minus signs (-) was replaced with dots (.).
- brackets () was replaced with dots (.).
- commas (,) was replaced with dots (.). 
- doble dots (..) was replaced with one dot (.).
- dots (.) at the end of variable name was removed.
- the small and capital letters have not been chnaged.

Final data set
---------------

Final data set was saved in the file named "final_ds.txt", in the current working directory. 

Folowig properties was used:
- Field separator: ;
- Decimal separator: .

Second data set
---------------

The second data set was saved in the file "aver_ds.txt", in the current working directory.

Folowig properties was used:
- Field separator: ;
- Decimal separator: .