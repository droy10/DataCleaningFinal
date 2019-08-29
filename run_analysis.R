# This is a script intended to load, process, and store the accelerometers from the Samsung Galaxy S smartphone. See 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more details.

# Preconditions: 	1- The R session working directory should be the location of the data (at the level higher than the "UCI HAR Dataset" folder)
#			2- The data files have been unzipped in the working directory folder

# We read the features (pointing to the "x" raw data):
features <- read.table("UCI HAR Dataset/features.txt")

# We read the activity labels (pointing to the "y" raw data):
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# We read the raw test and training data (for data, activity and subjects):
xtest <- read.table("UCI HAR Dataset/test/x_test.txt")
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt")

ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

##################################################################
# 1- Merges the training and the test sets to create one data set:
##################################################################

xtotal <- rbind(xtest, xtrain)
ytotal <- rbind(ytest, ytrain)
subjecttotal <- rbind(subject_test, subject_train)

############################################################################################
# 2- Extracts only the measurements on the mean and standard deviation for each measurement:
############################################################################################

# We store the mean and variance features in a new variable, called "cols_to_select":
cols_to_select <- features[grep("mean\\(\\)|std\\(\\)",features$V2), ]

# We keep only the columns related to the mean or variance:
xtotal_mean_var_cols <- xtotal[, cols_to_select[, 1]]

#######################################################################
# 4- Appropriately labels the data set with descriptive variable names:
#######################################################################

# We rename the column names of xtotal_mean_var_cols to more descriptive values, coming from "cols_to_select" table:
names(xtotal_mean_var_cols) <- cols_to_select[, 2]

###################################################################################################################################################
# 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###################################################################################################################################################

# We first need to append the data from question 4, the activities and the subjects:
xtotal_mean_var_cols_acts_sub <- cbind(xtotal_mean_var_cols, ytotal, subjecttotal)

# We rename the activities and subject columns to something more descriptive:
names(xtotal_mean_var_cols_acts_sub)[67] <- "Activity"
names(xtotal_mean_var_cols_acts_sub)[68] <- "Subject"

# For the activities, we store the string coming from activity_labels, instead of integers from 1 to 6:
xtotal_mean_var_cols_acts_sub[, 67] = activity_labels[xtotal_mean_var_cols_acts_sub[, 67], ][, 2]

library(dplyr)
library(stringr)

# The table "newtab" is the same as xtotal_mean_var_cols_acts_sub, but with data stored as doubles, instead of strings:
newtab <- cbind(xtotal_mean_var_cols_acts_sub[, as.double(1:66)], xtotal_mean_var_cols_acts_sub[, 67:68])

# The long cryptic column names create all kinds of issues when summarizing the data, so I temporarily rename them "COL1", ...:
names(newtab)[1] <- "COL1"
names(newtab)[2] <- "COL2"
names(newtab)[3] <- "COL3"
names(newtab)[4] <- "COL4"
names(newtab)[5] <- "COL5"
names(newtab)[6] <- "COL6"
names(newtab)[7] <- "COL7"
names(newtab)[8] <- "COL8"
names(newtab)[9] <- "COL9"
names(newtab)[10] <- "COL10"
names(newtab)[11] <- "COL11"
names(newtab)[12] <- "COL12"
names(newtab)[13] <- "COL13"
names(newtab)[14] <- "COL14"
names(newtab)[15] <- "COL15"
names(newtab)[16] <- "COL16"
names(newtab)[17] <- "COL17"
names(newtab)[18] <- "COL18"
names(newtab)[19] <- "COL19"
names(newtab)[20] <- "COL20"
names(newtab)[21] <- "COL21"
names(newtab)[22] <- "COL22"
names(newtab)[23] <- "COL23"
names(newtab)[24] <- "COL24"
names(newtab)[25] <- "COL25"
names(newtab)[26] <- "COL26"
names(newtab)[27] <- "COL27"
names(newtab)[28] <- "COL28"
names(newtab)[29] <- "COL29"
names(newtab)[30] <- "COL30"
names(newtab)[31] <- "COL31"
names(newtab)[32] <- "COL32"
names(newtab)[33] <- "COL33"
names(newtab)[34] <- "COL34"
names(newtab)[35] <- "COL35"
names(newtab)[36] <- "COL36"
names(newtab)[37] <- "COL37"
names(newtab)[38] <- "COL38"
names(newtab)[39] <- "COL39"
names(newtab)[40] <- "COL40"
names(newtab)[41] <- "COL41"
names(newtab)[42] <- "COL42"
names(newtab)[43] <- "COL43"
names(newtab)[44] <- "COL44"
names(newtab)[45] <- "COL45"
names(newtab)[46] <- "COL46"
names(newtab)[47] <- "COL47"
names(newtab)[48] <- "COL48"
names(newtab)[49] <- "COL49"
names(newtab)[50] <- "COL50"
names(newtab)[51] <- "COL51"
names(newtab)[52] <- "COL52"
names(newtab)[53] <- "COL53"
names(newtab)[54] <- "COL54"
names(newtab)[55] <- "COL55"
names(newtab)[56] <- "COL56"
names(newtab)[57] <- "COL57"
names(newtab)[58] <- "COL58"
names(newtab)[59] <- "COL59"
names(newtab)[60] <- "COL60"
names(newtab)[61] <- "COL61"
names(newtab)[62] <- "COL62"
names(newtab)[63] <- "COL63"
names(newtab)[64] <- "COL64"
names(newtab)[65] <- "COL65"
names(newtab)[66] <- "COL66"

# We will summarize the data by activity and subject:
act_subject_split <- group_by(newtab, Activity, Subject)

# The final table, "summary_table", summarizes by activity and subject, and I use the original, more descriptive, column names:
summary_table <- newtab %>% group_by(Activity, Subject) %>% summarize(
	"tBodyAcc-mean()-X" = mean(COL1),
	"tBodyAcc-mean()-Y" = mean(COL2),
	"tBodyAcc-mean()-Z" = mean(COL3),
	"tBodyAcc-std()-X" = mean(COL4),
	"tBodyAcc-std()-Y" = mean(COL5),
	"tBodyAcc-std()-Z" = mean(COL6),
	"tGravityAcc-mean()-X" = mean(COL7),
	"tGravityAcc-mean()-Y" = mean(COL8),
	"tGravityAcc-mean()-Z" = mean(COL9),
	"tGravityAcc-std()-X" = mean(COL10),
	"tGravityAcc-std()-Y" = mean(COL11),
	"tGravityAcc-std()-Z" = mean(COL12),
	"tBodyAccJerk-mean()-X" = mean(COL13),
	"tBodyAccJerk-mean()-Y" = mean(COL14),
	"tBodyAccJerk-mean()-Z" = mean(COL15),
	"tBodyAccJerk-std()-X" = mean(COL16),
	"tBodyAccJerk-std()-Y" = mean(COL17),
	"tBodyAccJerk-std()-Z" = mean(COL18),
	"tBodyGyro-mean()-X" = mean(COL19),
	"tBodyGyro-mean()-Y" = mean(COL20),
	"tBodyGyro-mean()-Z" = mean(COL21),
	"tBodyGyro-std()-X" = mean(COL22),
	"tBodyGyro-std()-Y" = mean(COL23),
	"tBodyGyro-std()-Z" = mean(COL24),
	"tBodyGyroJerk-mean()-X" = mean(COL25),
	"tBodyGyroJerk-mean()-Y" = mean(COL26),
	"tBodyGyroJerk-mean()-Z" = mean(COL27),
	"tBodyGyroJerk-std()-X" = mean(COL28),
	"tBodyGyroJerk-std()-Y" = mean(COL29),
	"tBodyGyroJerk-std()-Z" = mean(COL30),
	"tBodyAccMag-mean()" = mean(COL31),
	"tBodyAccMag-std()" = mean(COL32),
	"tGravityAccMag-mean()" = mean(COL33),
	"tGravityAccMag-std()" = mean(COL34),
	"tBodyAccJerkMag-mean()" = mean(COL35),
	"tBodyAccJerkMag-std()" = mean(COL36),
	"tBodyGyroMag-mean()" = mean(COL37),
	"tBodyGyroMag-std()" = mean(COL38),
	"tBodyGyroJerkMag-mean()" = mean(COL39),
	"tBodyGyroJerkMag-std()" = mean(COL40),
	"fBodyAcc-mean()-X" = mean(COL41),
	"fBodyAcc-mean()-Y" = mean(COL42),
	"fBodyAcc-mean()-Z" = mean(COL43),
	"fBodyAcc-std()-X" = mean(COL44),
	"fBodyAcc-std()-Y" = mean(COL45),
	"fBodyAcc-std()-Z" = mean(COL46),
	"fBodyAccJerk-mean()-X" = mean(COL47),
	"fBodyAccJerk-mean()-Y" = mean(COL48),
	"fBodyAccJerk-mean()-Z" = mean(COL49),
	"fBodyAccJerk-std()-X" = mean(COL50),
	"fBodyAccJerk-std()-Y" = mean(COL51),
	"fBodyAccJerk-std()-Z" = mean(COL52),
	"fBodyGyro-mean()-X" = mean(COL53),
	"fBodyGyro-mean()-Y" = mean(COL54),
	"fBodyGyro-mean()-Z" = mean(COL55),
	"fBodyGyro-std()-X" = mean(COL56),
	"fBodyGyro-std()-Y" = mean(COL57),
	"fBodyGyro-std()-Z" = mean(COL58),
	"fBodyAccMag-mean()" = mean(COL59),
	"fBodyAccMag-std()" = mean(COL60),
	"fBodyBodyAccJerkMag-mean()" = mean(COL61),
	"fBodyBodyAccJerkMag-std()" = mean(COL62),
	"fBodyBodyGyroMag-mean()" = mean(COL63),
	"fBodyBodyGyroMag-std()" = mean(COL64),
	"fBodyBodyGyroJerkMag-mean()" = mean(COL65),
	"fBodyBodyGyroJerkMag-std()" = mean(COL66)
)


