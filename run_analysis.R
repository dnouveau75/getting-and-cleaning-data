## Step 1 and 2
## Load packages that are needed to run the script

library(data.table)
library(dplyr)

## Read and loop through the features file to identify the columns of target
## variables, i.e. mean and standard-deviation for each measurement.

features <- read.table("features.txt")
target_var_index <- vector()
target_var_names <- vector()
for(i in seq(along = features[,2])){
  if((grepl("mean()", features[i,2]) & grepl("meanFreq", features[i,2]) == FALSE) | 
     grepl("std", features[i,2])){
    target_var_index <- c(target_var_index, i)
    target_var_names <- c(target_var_names, as.character(features[i, 2]))
    ## Previous line is used for step 4
  }
}

## Read the file containing activity IDs as well as subject
## numbers for each observation

y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")

## Read the file containing the observations for each measurement, using
## fread to extract only the target variables.

X_test <- fread("X_test.txt", select = target_var_index)
X_train <- fread("X_train.txt", select = target_var_index)

## Use rbind and cbind to merge the data sets, 

xy <- rbind(cbind(subject_test, y_test, X_test), 
               cbind(subject_train, y_train, X_train))

## Assign temporary variable names: count the number of target
## variables and create simple variable names using the paste function

nvar <- ncol(xy) -2
list_var <- paste("var", 1:nvar, sep="")
names(xy) <- c("subject", "activity_id", list_var)

## Step 3
## Read the file mapping each activity ID to an activity name and
## add those names to the previous data set using the merge function

activities <- read.table("activity_labels.txt", 
                         col.names = c("activity_id", "activity"))
data_set <- merge(xy, activities, by.x="activity_id", by.y="activity_id")

## Step 4 & 5
## Use the dplyr package to group the data set by activity and subject
## Compute averages for each activity and subject using the summarize function

groups <- group_by(data_set, activity, subject)
tidy_data <- summarize_each(groups, funs(mean), -activity_id)
names(tidy_data) <- c("activity", "subject", target_var_names)
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)