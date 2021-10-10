## CODEBOOK

## Datasets Used 

*features.txt*: List of all features.
*activity_labels.txt*: Links the class labels with their activity name.

The following datasets would be present under Train folder
  *X_train.txt*: Training set.
  *subject_train.txt*: Each row identifies the subject who performed the activity for each window sample.Its range is from 1 to 30. 
  *y_train.txt*: Training labels

The following datasets would be present under Test folder
*X_test.txt*: Test set.

*subject_test.txt*: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

*y_test.txt*: Test labels

## Variables Used

*activity_labels*: Data table for the activity labels text file

*features_labels*: Data table for the text file with list of features and their labels (features.txt)

*test_data*: Data table for the test set (X_test.txt)

*test_data_activity_ID*: Data table with test set labels which have the activity ID for each observation in 
test set (y_test.txt)

*test_data_subject_ID*: Data table with the subject IDs for each observation from test data (subject_test.txt)

*final_test_data*: Combined test data which has the activity ID, Subject ID and the test data observations

*train_data*: Data table for the training set (X_train.txt)

*train_data_activity_ID*: Data table with training set labels which have the activity ID for each 
observation in training set (y_train.txt)

*train_data_subject_ID*: Data table with the subject IDs for each observation from training data (subject_train.txt)

*final_train_data*: Combined training data which has the activity ID, Subject ID and the training data observations

*Combined_data*: Combined final test and training data

*Combined_data_mean_sd*: Data table which only has the Mean and Standard Deviation measurements from the Combined data

*final_Combined_data_mean_sd*: The final desired primary data table which includes the Activity description for each observation from the Combined_data_mean_sd table based on the Activity ID

*ind_tny_data*: The second independent data table which is the output and calculates average for each variable grouped by the Subject ID and Activity ID

## Process Flow and Transformations in the analysis:

STEP 0: LOADING THE LIBRARIES AND DIRECTORIES

  0.1 Adding libraries for the data processing

  0.2 Creating new directory for downloading files

STEP 1: DOWNLOADING THE FILES, CLEANING AND GATHERING DATA

  1.1 DOwnloading the files and looking through the directories to understand the files and data

  1.2 Gathering label data and adding descriptive names

  1.3 Gathering and Compiling the test data. Also includes adding descriptive names to the each column of data

  1.4 Gathering and Compiling the training data. Also includes adding descriptive names to the each column 
of data

  1.5 Merging test and training data to one set

STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

  Using the grepl function, search for the column names which contain the word mean and std

STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATASET

  3.1 Using merge function combine the Activity labels table with the main table by Activity ID

  3.2 Arrange the main table with respect to Subject ID and Activity ID using arrange function of dplyr 
package

STEP 4: APPROPIATELY LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES

  This step was already carried out earlier in the process in sub-steps 1.1,1.2,1.3 and 3.1

STEP 5 CREATE A SECOND TIDY DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

  5.1 Create the second tiny dataset. Use the group_by function to group by Subject ID and Activity ID and 
calculate mean on the other columns for each group using the summarise function of the dplyr package

  5.2 Write the newly created dataset into a text file which would be the Output

