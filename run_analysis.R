## STEP 0: LOADING THE LIBRARIES AND DIRECTORIES

# 0.1 Adding libraries for the data processing
library("dplyr")


# 0.2 Creating new directory for downloading files
if (!file.exists("./data")){
  dir.create("./data")
}


## STEP 1: DOWNLOADING THE FILES, CLEANING AND GATHERING DATA

# 1.1 DOwnloading the files and looking through the directories to understand the files and data
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url1,"./data/files.zip")
unzip("./data/files.zip",exdir = "./data")
list.files(path="./data/UCI HAR Dataset")
list.files(path="./data/UCI HAR Dataset/test")
list.files(path="./data/UCI HAR Dataset/train")


# 1.2 Gathering label data
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("Activity ID","Activity")
features_labels <- read.table("./data/UCI HAR Dataset/features.txt")

# 1.3 Gathering and Compiling the test data
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")                           # Reading the test data
names(test_data) <- features_labels[,2]                                                     # Adding descriptive column names to the test data
test_data_activity_ID <- read.table("./data/UCI HAR Dataset/test/y_test.txt")               # Reading activity ID for test data
names(test_data_activity_ID) <- c("Activity ID")                                            # Adding descriptive column name to the Activity ID
test_data_subject_ID <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")          # Reading subject ID for test data
names(test_data_subject_ID) <- c("Subject ID")                                              # Adding descriptive column name to the Subject ID
final_test_data <- cbind(test_data_subject_ID,test_data_activity_ID,test_data)              # Combining all the above data into a final test dataset

# 1.4 Gathering and Compiling the training data
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")                        # Reading the training data
names(train_data) <- features_labels[,2]                                                    # Adding descriptive column names to the training data
train_data_activity_ID <- read.table("./data/UCI HAR Dataset/train/y_train.txt")            # Reading activity ID for training data
names(train_data_activity_ID) <- c("Activity ID")                                           # Adding descriptive column name to the Activity ID
train_data_subject_ID <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")       # Reading subject ID for training data
names(train_data_subject_ID) <- c("Subject ID")                                             # Adding descriptive column name to the Subject ID
final_train_data <- cbind(train_data_subject_ID,train_data_activity_ID,train_data)          # Combining all the above data into a final training dataset

# 1.5 Merging test and training data to one set
Combined_data <- rbind(final_test_data,final_train_data)


## STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
Combined_data_mean_sd <- Combined_data[,grepl("mean|std|Activity|Subject",names(Combined_data))]

## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATASET

# 3.1 Include Activity Names by matching the IDs between the tables
final_Combined_data_mean_sd <- merge(activity_labels,Combined_data_mean_sd,by = "Activity ID")    

# 3.2 Arrange with respect to Subject ID and Activity ID
final_Combined_data_mean_sd <- arrange(final_Combined_data_mean_sd,final_Combined_data_mean_sd$`Subject ID`,final_Combined_data_mean_sd$`Activity ID`)   


## STEP 4: APPROPIATELY LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES
# This step is already covered under Steps 1.3,1.4 and 3.1


## STEP 5 CREATE A SECOND TIDY DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

# 5.1 Create the second tiny dataset
ind_tny_data <- final_Combined_data_mean_sd %>% group_by(`Subject ID`,`Activity ID`,Activity) %>% 
  summarise(across(!c(1:3),mean))

# 5.2 Write the newly created dataset into a text file
write.table(ind_tny_data,file = "./data/final output.txt",row.names = FALSE)

