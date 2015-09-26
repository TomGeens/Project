#run_analysis.R
#check existence of training and test datasets and their features
if (file.exists("UCI HAR Dataset/train/X_train.txt")){ 
        Xtrain<-read.table("UCI HAR DATASET/train/X_train.txt")
}else{
        stop()}
if (file.exists("UCI HAR Dataset/train/Y_train.txt")){ 
        Ytrain<-read.table("UCI HAR DATASET/train/Y_train.txt")
}else{
        stop()}
if (file.exists("UCI HAR Dataset/train/subject_train.txt")){ 
        Strain<-read.table("UCI HAR DATASET/train/subject_train.txt")
}else{
        stop()}
if (file.exists("UCI HAR Dataset/test/X_test.txt")){ 
        Xtest<-read.table("UCI HAR DATASET/test/X_test.txt")
}else{
        stop()}
if (file.exists("UCI HAR Dataset/test/Y_test.txt")){ 
        Ytest<-read.table("UCI HAR DATASET/test/Y_test.txt")
}else{
        stop()}
if (file.exists("UCI HAR Dataset/test/subject_test.txt")){ 
        Stest<-read.table("UCI HAR DATASET/test/subject_test.txt")
}else{
        stop()}
if (file.exists("UCI HAR Dataset/features.txt")){ 
        features<-read.table("UCI HAR DATASET/features.txt")
}else{
        stop()}

#look at the structure of the datasets and the variables they contain
str(Xtrain)
str(Ytrain)
str(Strain)
str(Xtest)
str(Ytest)
str(Stest)
str(features)

#create one big X dataset and name the variables
X<-rbind(Xtrain,Xtest)
names(X)<-features$V2

#create one big Y dataset and name the factor levels
Y<-rbind(Ytrain,Ytest)
Yf<-as.factor(Y$V1)
levels(Yf)<-list(walking="1",walkingup="2",walkingdown="3",sitting="4",standing="5",laying="6")

#create one big S dataset and name the factor levels
S<-rbind(Strain,Stest)
Sf<-as.factor(S$V1)

#find substring mean and std in variables, return indices and reduce X dataset
meanstd<-c(grep("mean",names(X)),grep("std",names(X)))
Xmeanstd<-X[,meanstd]

#merge subjects Sf, activities Yf and reduced Xmeanstd
SYX<-cbind(Sf, Yf,Xmeanstd)
names(SYX)[1]<-"subject"
names(SYX)[2]<-"activity"
head(names(SYX))

#tidy table
library(dplyr)
dplyrSYX<-tbl_df(SYX)
dplyrSYX<-arrange(dplyrSYX,activity,subject)
bySY<-group_by(dplyrSYX,activity,subject)
tidy<-summarize_each(bySY,funs(mean))
write.table(tidy,file="tidy.txt",row.names=FALSE)
check<-read.table("tidy.txt",header=TRUE)
head(check[,1:4],180)
