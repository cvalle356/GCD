#1) a tidy data set as described below, 2) a link to a Github repository with your script for performing 
#the analysis, and 3) a code book that describes the variables, the data, and any transformations or work 
#that you performed to clean up the data called CodeBook.md. You should also include a README.md in the 
#repo with your scripts. This repo explains how all of the scripts work and how they are connected.

#You should create one R script called run_analysis.R that does the following.
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##reads all data
feat <- "~/data/features.txt"
feat561<- read.table(feat)
colnames(feat561)<- c("id","varnam")

act <- "~/data/activity_labels.txt"
activity<- read.table(act)
colnames(activity)<- c("labelid","activitylabel")

testf <- "~/data/test/X_test.txt"
testdata <- read.table(testf)
testfsub <- "~/data/test/subject_test.txt"
testsubjects<- read.table(testfsub)
testlab <- "~/data/test/y_test.txt"
testlabel<- read.table(testlab)

trainf <- "~/data/train/X_train.txt"
traindata <- read.table(trainf)
trainfsub <- "~/data/train/subject_train.txt"
trainsubjects<- read.table(trainfsub)
trainlab <- "~/data/train/y_train.txt"
trainlabel<- read.table(trainlab)


#loads package dplyer
library(dplyr)

feat561<-mutate(feat561, v3 = paste(id,varnam, sep=""))
x<-as.character(feat561[,3])

tbl_df(activity)
tbl_df(feat561)
tbl_df(testdata)
tbl_df(testlabel)
tbl_df(testsubjects)
tbl_df(traindata)
tbl_df(trainlabel)
tbl_df(trainsubjects)

#renames columns to avoid duplicates when merged
colnames(testlabel)<- "labelid"
colnames(testsubjects)<- "subject"

colnames(trainlabel)<- "labelid"
colnames(trainsubjects)<- "subject"


##adds label and subject colums to test data
testdata<- cbind(testlabel, testdata)
testdata<- cbind(testsubjects, testdata)

traindata<- cbind(trainlabel, traindata)
traindata<- cbind(trainsubjects, traindata)

#adds group variable to keep track of training and test groups
test<-"test"
testdata<- mutate(group = test, testdata)
train<-"train"
traindata<- mutate(group = train, traindata)


##gives names to column measures 561
colnames(testdata)[3:563] <- x
colnames(traindata)[3:563] <- x

##combines both data sets
alldata<- rbind(testdata, traindata)

rm(testdata)
rm(traindata)


##joins activity labels to full set
alldata<- left_join(alldata, activity, by = "labelid")

tbl_df(alldata)
a<- select(alldata,contains("mean()"),contains("std()"))
b<- select(alldata, one_of("subject"))
g<- select(alldata, one_of("group"))
c<- select(alldata, one_of("activitylabel"))

alldata1<-cbind(b, g, c, a)

rm(a)
rm(b)
rm(c)
rm(alldata)


##Clean Up Names
colnames(alldata1)<-gsub("\\d","",names(alldata1))
colnames(alldata1)<-gsub("[Mm]ean\\(\\)","mean",names(alldata1))
colnames(alldata1)<-gsub("[Ss]td\\(\\)","standarddeviation",names(alldata1))
colnames(alldata1)<-gsub("\\,","-",names(alldata1))
colnames(alldata1)<-gsub("-X","ofX-direction",names(alldata1))
colnames(alldata1)<-gsub("-Y","ofY-direction",names(alldata1))
colnames(alldata1)<-gsub("-Z","ofZ-direction",names(alldata1))
#time
colnames(alldata1)<-gsub("tBodyAcc","time-body-linear-acceleration-",names(alldata1))
colnames(alldata1)<-gsub("tBodyGyro","time-body-angular-velocity-",names(alldata1))
colnames(alldata1)<-gsub("Mag","Euclidean-norm",names(alldata1))
colnames(alldata1)<-gsub("tGravityAcc","time-gravity-acceleration-",names(alldata1))
#frequency
colnames(alldata1)<-gsub("fBodyAcc","frequency-body-linear-acceleration-",names(alldata1))
colnames(alldata1)<-gsub("fBodyGyro","frequency-body-angular-velocity-",names(alldata1))
colnames(alldata1)<-gsub("fGravityAcc","frequency-gravity-acceleration-",names(alldata1))
colnames(alldata1)<-gsub("--","-",names(alldata1))


#writes combined data
if(!file.exists("~/output")){dir.create("~/output")}
write.table(alldata1, file="~/output/combinedtidy.txt", row.name=FALSE)

#2nd tidy data set summary
sumdata<-alldata1
tbl_df(sumdata)

# DPLYR grouping is applied
sumdata <- group_by(sumdata ,subject, activitylabel)

sumdata1<-summarise_each(sumdata,funs(mean))
sumdata1<-select(sumdata1, -group)

#writes 2nd tidy data
if(!file.exists("~/output")){dir.create("~/output")}
write.table(sumdata1, file="~/output/tidy2.txt", row.name=FALSE)
