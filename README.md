# Project
# This is a project for the DS3 course
# with the script run_analysis.R we have to collect, work with, and clean data sets
# the script checks local existence of training and test datasets and their features of the UCI HAR Dataset
# if the files exist, they are read in, cleaned and merged 
# in a last step, a summarizing tidy dataset is created with mean values for all original variables containing describing means 
# or standardeviations, and these data are summarized per activity (n=5) and per subject (n=30) resulting in a tidy dataset 
# with 180 cases and 81 variables (79 means of means and standarddeviations, and two grouping variables activity and subject)
