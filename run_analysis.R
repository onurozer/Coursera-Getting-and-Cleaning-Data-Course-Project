# You will be required to submit: 
#    1) a tidy data set as described below
#    2) a link to a Github repository with your script for performing the analysis, and 
#    3) a code book that describes the variables, the data, and any transformations or 
#    work that you performed to clean up the data called CodeBook.md. 

# A full description is available at the site where the data was obtained:     
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Here are the data for the project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Please upload your data set as a txt file created with write.table() using row.name=FALSE

# read activity labels (categories)
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# read features (variable names)
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# logical vector for extracting mean and standard variables
required_vars <- grepl("mean|std", features)

# read test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# appropriately labels the data set with descriptive variable names. 
names(x_test) = features

# extracts only the measurements on the mean and standard deviation for each measurement.
x_test <- x_test[,required_vars]

# merge test data
test_data <- cbind(subject_test, y_test, x_test)

# set column names
colnames(test_data)[1:2] <- c("Subject", "Activity")

# read training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# assign variable names to training data
names(x_train) = features

# extracts only the measurements on the mean and standard deviation for each measurement.
x_train <- x_train[,required_vars]

# merge training data
training_data <- cbind(subject_train, y_train, x_train)

# set column names
colnames(training_data)[1:2] <- c("Subject", "Activity")

# merge test and training data together
merged_data <- rbind(test_data, training_data)

# Uses descriptive activity names to name the activities in the data set
merged_data$Activity <- factor(merged_data$Activity, levels=activities$V1, labels = activities$V2)


