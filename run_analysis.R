# This R Script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(reshape2)
require(data.table)

# check if data directory exist
if(!file.exists("UCI HAR Dataset")){

    # download and unzip if it doesn't    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile="UCI HAR Dataset.zip", method="curl")
    unzip("UCI HAR Dataset.zip")
}

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

# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
melted_data <- melt(merged_data, id = c("Subject", "Activity"), measure.vars = colnames(merged_data)[3:length(merged_data)])
tidy_data <- dcast(melted_data, Subject + Activity ~ variable, mean)

# write data set as a txt file created with write.table() using row.name=FALSE
write.table(tidy_data, file="./final_data.txt", row.name=FALSE)