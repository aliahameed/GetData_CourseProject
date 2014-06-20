Human Activity Recognition - Modified Smartphones Dataset
=========================================================
### Alia Hameed ###

This dataset was prepared as part of the Coursera **Getting and Cleaning Data** Course Project. It is based on the **Human Activity Recognition** dataset prepared by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto of Smartlab - Non Linear Complex Systems Laboratory in Genoa, Italy (see reference provided below).

The original dataset was randomly partitioned into two sets, a training set containing 7352 observations and a test set containing 2947 observations. Each record consisted of a 561-feature vector with time and frequency domain variables, an activity label (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING), and an identifier of the subject (one of a group of 30 volunteers). Separate files also provided additional observations such as the triaxial acceleration from the accelerometer (total acceleration), estimated body acceleration and triaxial angular velocity from the gyroscope.

For the purposes of this project, the training and test sets (*train/X_train.txt* and *test/X_test.txt*) were merged to create one data set. In order to do this, additional columns were created for the activity labels and subject identifiers, initially stored in separate files. Once this information had been added into both training and test sets using cbind(), the two datasets were merged to create a new dataset containing 10299 observations of 563 variables (the 561-feature vector, plus the new activity and subject variables).

The original data included the *features.txt* file containig a list of all features. This was used to to extract only the measurements on the mean and standard deviation for each measurement, using a basic case-insensitive regular expression search for all features containing the phrase "mean" or "std". It was then possible to extract only these columns from the new dataset, leaving us with a subset containing 10299 observations of 81 variables (the 79 relevant features, plus activity and subject identifiers for each record).

To further simplify the data, I convert the activity variable to a factor, using the labels provided in the original *activity_labels.txt* file. In the same manner, I chose to label the new dataset columns using the descriptive feature names provided in the original *features.txt* file, after a preliminary call to gsub() to strip them of illegal characters.

Finally, the mean of each variable was obtained by aggregating the data over activity and subject, resulting in a new, tidy dataset containing 180 observations of 81 variables each.

### Reference: ###
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
