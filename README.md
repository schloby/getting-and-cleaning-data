#README for Getting and Cleaning Data Course Project - tidy_means.txt

##To perform this analysis:

Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into the working directory. 
This code assumes the data is already present in the working directory. 

Run the script run_analysis.R which does the following:

* Reads in each of the x, y, and subject datasets and merges them into one dataset. 
* Reads in the feature list and applies the appropriate variable names.
* Selects only the variables with "mean" or "std" in the name. 
* Reads in the activity labels and applies this to the dataset. 
* Calculates the mean of each of those variables by Subject and Activity.
* Writes this result to the file "tidy_means.txt".
