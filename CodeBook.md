=======================================================================
Getting and Cleaning Data - CodeBook pertaining to the final project
=======================================================================

1 -  Information about variables

The tidy data set, which represents the output of the final project,
for this course, contains three distinct groups of variables:

 a - activity
 
This variable corresponds to the type of activity performed by the subjects 
of the experiments, i.e. the individual wearing the smartphone measuring 
signals that will later be analyzed.There are six types of activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
and each type was performed multiple times by each individual, which 
introduces a need to average data (precisely the goal of the tidy data).

 b - subject
 
This variable corresponds to the number assigned to each participant to 
the experiment. Those participants (the subjects) are not identified by
their name, but by a unique number, ranging from 1 to 30 (the number of
volunteers). There is no unit measure for this variable.
 
 c - measurements
 
The last group of variables comprises of 66 variables, each corresponding
to either the mean or the standard-deviation of a specific type of 
measurement (the features) performed by the device, averaged across
each type of activity and experiment subject. See below the extract 
of the README file of the original data describing how those variables were initially obtained:

"The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain 
signals (prefix 't' to denote time) were captured at a constant rate of 50 
Hz. Then they were filtered using a median filter and a 3rd order low pass 
Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low 
pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived 
in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using 
the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, 
tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals 
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain 
signals).

These signals were used to estimate variables of the feature vector for 
each pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and 
Z directions."

As mentioned above, only the mean and the standard deviation entered the
scope of this project, and all other component of the feature vector
(for instance the median, min and max values) were dropped. As a result, 
the tidy data set only contains 66 out of the initial 561 variables were
kept. Moreover, those variables were then averaged across each activity type 
and subject (more details in the next section), although the variable names 
were kept as such for the sake of simplicity. See below the full list of 
"measurement" variables included in the tidy data set. It is important to 
note that all features are normalized, i.e. they are bound between -1 and 1, 
and no unit is needed to interpret the data, since all variables have a 
common scale.

tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-mean()
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-mean()
fBodyAccMag-std()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-std()


2 - Summary choices

 a - Extracting only the mean and standard-deviation of each measure
 
As mentioned above, the instructions of the project specify that only
the mean and standard deviation of each measure should be selected for
the purpose of constructing a tidy data set. 

In addition, it should be noted that those measures (the features) were 
themselves summaries ofthe raw data, since (per the README file) :
"The sensor signals (accelerometer and gyroscope) were pre-processed by 
applying noise filters and then sampled in fixed-width sliding windows of 
2.56 sec and 50% overlap (128 readings/window). The sensor acceleration 
signal, which has gravitational and body motion components, was separated 
using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, 
a vector of features was obtained by calculating variables from the time 
and frequency domain."

 b - Averaging measurements by activity and by subject
 
Since each activity was performed mutliple times by each subject, there is
not one, but multiple observations of each measure for a given activity and
subject. Therefore, the data set was further reduced by computing the 
average of each variable, for each activity and subject. Since there are
6 types of activities and 30 subjects, this operation yielded a 
180-observation data set, with each "new" variable corresponding to the 
mean of each "old" variable across activity types and subjects.

Although those "new" variables are derived from the "old" ones by averaging
observations, the name of those variables was preserved, due to the high
degree of sophistication of the experiment: on the one hand, this choice
may be criticized, because it forces us to introduce a caveat in the tidy
data set, but on the other, introducing new names to reflect the fact that 
the original variables have been transormed would have resulted in 
even more cumbersome variable names.





