# Coursera - Getting and Cleaning Data: Course-Project

## Introduction
This repository contains the files for Coursera's Getting and Cleaning Data Course Project. 

## About the data
The data is based on "Human Activity Recognition Using Smartphones Data Set". The data can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and the description can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## Usage
Run "run_analysis.R" in RStudio without any parameters which will:

1) Check if the "UCI HAR Dataset" folder exists, download and unzip if it doesn't
2) Load datasets into R, label variables appropriately and merge all data sets into a single tidy dataset
3) Creates a second, independent tidy data set with the average of each variable for each activity and each subject and write it to a text file called "final_data.txt"

## Dependencies
- reshape2
- data.table
