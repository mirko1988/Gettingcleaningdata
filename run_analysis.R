
library(dplyr)
setwd("F:/COURSERA/Getting and Cleaning Data/4° week")
###### Step 1 ######
## Merge datasets ##
####################

#Import data

x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

# Merging

x_data<-rbind(x_train,x_test)
y_data<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)

############################################ Step2 ########################################
## Extract only the measurements on the mean and standard deviation for each measurement ##
###########################################################################################

features<-read.table("UCI HAR Dataset/features.txt")
mean_feat<-grep("mean()",features$V2)
std_feat<-grep("std()",features$V2)
mean_std_feat<-sort(union(mean_feat,std_feat))

x_data<-x_data[,mean_std_feat]
names(x_data)<-features[mean_std_feat,2]

###################################### Step 3 #############################################
######## Uses descriptive activity names to name the activities in the data set ###########
###########################################################################################

activity<-read.table("UCI HAR Dataset/activity_labels.txt")

d_y<-dim(y_data)


for (i in 1:d_y[1]){
    for (j in 1:6){
        if (y_data[i,1]==activity[j,1]){
            y_data[i,2]<-activity[j,2]
            break
        }
    }
}

############################################ Step 4 ###############################################
################# Appropriately labels the data set with descriptive variable names ###############
###################################################################################################

all_data<-cbind(subject,y_data[,2],x_data)
all_data<-rename(all_data, subject=V1,activity=`y_data[, 2]`) 

############################################ Step 5 ###############################################
############ From the data set in step 4, creates a second, independent tidy data set ############# 
############ with the average of each variable for each activity and each subject #################
###################################################################################################

all_data_1<-group_by(all_data, subject, activity)
all_data_final<-summarize_all(all_data_1,mean) 

write.table(all_data_final,"average.txt",row.name=FALSE)


