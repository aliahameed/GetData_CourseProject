## Set the working directory to the UCI HAR Dataset 
## setwd("/.../UCI HAR Dataset")

## The test and training datasets are read into memory, as well as activity
## and subject identifiers (in separate files) for each set
xtrain = read.table("train/x_train.txt")
xtest = read.table("test/x_test.txt")

ytrain = read.table("train/y_train.txt")
ytest = read.table("test/y_test.txt")

subjecttrain = read.table("train/subject_train.txt")
subjecttest = read.table("test/subject_test.txt")

## Activity and subject identifiers are added to each set using cbind() to 
## create new columns, and colnames() to name them appropriately
xtrain2 <- cbind(xtrain, ytrain, subjecttrain)
colnames(xtrain2)[562] <- "ACTIVITY";
colnames(xtrain2)[563] <- "SUBJECT";
xtest2 <- cbind(xtest, ytest, subjecttest);
colnames(xtest2)[562] <- "ACTIVITY";
colnames(xtest2)[563] <- "SUBJECT";

## Now, test and training sets are merged using a call to rbind()
fullset <- rbind(xtrain2, xtest2);

## Features containing information pertaining to the mean and standard deviation
## are identified using a case-insensitive regular expression search in the 
## features.txt file.
features = read.table("features.txt");
stdtable <- subset(features, regexpr("std", tolower(features$V2)) > 0);
meantable <- subset(features, regexpr("mean", tolower(features$V2)) > 0);

## The two new activity and subject columns are added to this list
colnames <- c(paste("V", stdtable$V1, sep=""), paste("V", meantable$V1, sep=""), "ACTIVITY", "SUBJECT");

## These columns are now extracted from the dataset
extract <- subset(fullset, select=colnames)

## The activity field is converted to a factor, using the labels provided
extract$ACTIVITY <- factor(extract$ACTIVITY,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"));

## The columns containing the features are renamed according to the descriptive
## feature names provided, with the illegal characters removed
colnames(extract) <- c(gsub("\\.", "", make.names(paste(stdtable$V2))), gsub("\\.", "", make.names(paste(meantable$V2))), "ACTIVITY", "SUBJECT");

## The mean of each variable is then obtained by aggregating over activity and
## subject
aggdata <- aggregate(extract[1:79], by=list(extract$ACTIVITY, extract$SUBJECT), FUN=mean);

## Aggregated data column names are reset to maintain clarity
colnames(aggdata)[1] <- "ACTIVITY";
colnames(aggdata)[2] <- "SUBJECT";

## Output file
write.table(aggdata,"means_of_mean_and_std_features.txt",row.names=FALSE);
