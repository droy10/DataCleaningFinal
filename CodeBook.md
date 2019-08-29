Here are the steps I took to perform this project:
1- I downloaded the zip file containing the raw data, from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2- I unzipped it in my R session working directory
3- I read the features into table "features"
4- I read the activity labels into table "activity_labels"
5- I read the raw test data into table "xtest"
6- I read the raw training data into table "xtrain"
7- I read the activity test data into table "ytest"
8- I read the activity training data into table "ytrain"
9- I read the subject test data into table "subject_test"
10- I read the subject training data into table "subject_train"
11- I merged the raw data, from tables xtest and xtrain, into new table "xtotal".
12- I merged the activity data, from tables ytest and ytrain, into new table "ytotal".
13- I merged the subject data, from tables subject_test and subject_train, into new table "subjecttotal".
14- Using the function "grep", I created a new table, called "xtotal_mean_var_cols", containing only the columns for the measurements on the mean and standard deviation
15- I renamed the columns of xtotal_mean_var_cols to more descriptive names
16- I added the activity and subject columns to the table xtotal_mean_var_cols, and called this new table "xtotal_mean_var_cols_acts_sub"
17- I renamed the columns of xtotal_mean_var_cols_acts_sub to more descriptive names for the subjects and activities
18- In xtotal_mean_var_cols_acts_sub, I replaced the activity numbers to their description, instead of digits 1 to 6
19- I created table "newtab" to contain the same info as xtotal_mean_var_cols_acts_sub, but numbers stored, instead of strings
20- I temporarily replaced the column names, in newtab, to easier to handle names, in newtab.
21- The final summary table, "summary_table", was created by summarizing the table "newtab", by activity and subject.
