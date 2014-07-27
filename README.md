Required libraries:
reshape2


Required files:

features.txt
subject_test.txt
subject_test.txt
X_test.txt
Y_test.txt
X_train.txt
Y_train.txt


This script expects the files above to be in the working directory or it will not work.

Running the files:

The tidy dataset is created by running run_analysis(). This function returns a dataset.

To create the 2nd dataset run the average_data function passing it your dataset created in Step 1. This function also returns a dataset.

For example:
To create a tidy dataset callled my_tidy_data:
my_tidy_data <- run_analysis()

To then average all the variables in this data set run into a dataset called my_average_data:

my_average_data <- average_data(my_tidy_data)


Steps involved in creating the tidy data set:

There are a number of steps to create a tidy data set for analysis.

Step 1: Load features.txt in a list

Step 2: Load the test files
	subject_test.txt
	X_test.txt
	Y_test.txt

Step 3: Load the training files
	subject_train.txt
	X_train.txt
	y_train.txt

Step 4: join the test tables together by column-bind

Step 5: join the train tables together by column-bind

Step 6: union the train and test tables together (row bind)

Step 7:Keep columns 1-3 (Subject \ Activity \ Type ) and remove all columns that don't contain mean.. \ Mean. \ or std

Step 8: Add descriptive names in the Activity column

Step 9: Clean up the column names

