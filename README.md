# GettingAndCleaningData_Project
The R version used here is 3.2.0 (2015-04-16). 

The code in run_analysis.R is used to prepare tidy data for Samsung data. 

#####First step is to combine test and train data togather.
- All data (including X_test.txt, y_test.txt, subject_test.txt, X_train.txt, y_train.txt, subject_train.txt) are read into R by function ```read.table```.
- Test data and train data are combined seperately by function ```cbind```.
- Test data and train data are combined togather by function ```rbind```.

#####Next step is to assign names to each column in the data table generated in previous step.
- Variable names are read into R from file features.txt. The second column in the file includes all variable names.

#####In this step, activity names are assigned to each row corresponding to the activity labels.
- Activity names are read into R from file activity_labels.txt.
- This data table is merged with data table including all test and train data to generate a new data table.
- We will rename all variable in this new data table.

######Extract the measurements on the mean and standard deviation for each measurement.
- First, we extract variables including "std" or "mean". However, variables including "meanFreq" cannot be excluded in this step.
- Second, we extract variables including "meanFreq".
- Variables including "meanFreq" are excluded by function ```setdiff```.
- A new data table is generated including Subject, Activity, and all variables including either "std" or "mean".

######Summary data
- Using function ```ddply``` from package ```plyr```, we can get the average of each variable for each activity and each subject.
