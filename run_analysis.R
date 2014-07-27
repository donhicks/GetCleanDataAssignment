run_analysis<-function(){
  
  ##setwd("C:/Data/Working Directory/Data")
  ##load the features.txt file which will become the column names of the Xfiles
  featureList<-read.table("./features.txt",sep=" ")
  features<-featureList[,2]
  
  
  ##load the test files
  testSubjectFile<-read.table("./test/subject_test.txt",col.names=c("Subject")) ##2947 rows 1 column
  testXFile<-read.table("./test/X_test.txt",col.names=features) ##2947 rows 561 columns
  testYFile<-read.table("./test/Y_test.txt",col.names=c("Activity")) ##2947 rows 1 column
  ##load the training files
  trainSubjectFile<-read.table("./train/subject_train.txt",col.names=c("Subject")) ## 7352 rows 1 column
  trainXFile<-read.table("./train/X_train.txt",col.names=features) ## 7352 rows 561 columns
  trainYFile<-read.table("./train/y_train.txt",col.names=c("Activity")) ## 7352 rows 1 column
  
  ##1.merge the test tables together (column bind-join)
  testTable<-cbind(testSubjectFile,testYFile)
  ##testTable<-cbind(testTable,Type="test")
  testTable<-cbind(testTable,testXFile)

  ##1.merge the train tables together (column bind-join)
  trainTable<-cbind(trainSubjectFile,trainYFile)
  ##trainTable<-cbind(trainTable,Type="train")
  trainTable<-cbind(trainTable,trainXFile)

  ##1.merge the test and train tables (union)
  mergeTable<-rbind(testTable,trainTable)
  selcols=c(1:2,grep("mean\\.\\.",names(mergeTable),ignore.case=FALSE),grep("Mean\\.",names(mergeTable),ignore.case=FALSE),grep("std",names(mergeTable),ignore.case=TRUE))
  data<-mergeTable[,selcols]
  ##3. Descriptive names for Activities
  data$Activity<-gsub(1,"WALKING",data$Activity)
  data$Activity<-gsub(2,"WALKING UPSTAIRS",data$Activity)
  data$Activity<-gsub(3,"WALKING DOWNSTAIRS",data$Activity)
  data$Activity<-gsub(4,"SITTING",data$Activity)
  data$Activity<-gsub(5,"STANDING",data$Activity)
  data$Activity<-gsub(6,"LAYING",data$Activity)
  
  ##4.clean up the column names
  names(data)<-gsub("tBody","Time.Body",names(data))
  names(data)<-gsub("tGravity","Time.Gravity",names(data))
  names(data)<-gsub("fBody","Freq.Body",names(data))
  names(data)<-gsub("BodyBody","Body",names(data))
  names(data)<-gsub("angle","Angle\\.",names(data))
  names(data)<-gsub("Acc","\\.Acc\\.",names(data))
  names(data)<-gsub("Gyro","\\.Gyro\\.",names(data))
  names(data)<-gsub("Jerk","\\.Jerk\\.",names(data))
  names(data)<-gsub("Mag","\\.Mag\\.",names(data))
  names(data)<-gsub("gravity\\.","Gravity",names(data))
  names(data)<-gsub("mean\\.\\.","Mean",names(data))
  names(data)<-gsub("std\\.\\.","std",names(data))
  names(data)<-gsub("gravityMean\\.","Gravity\\.Mean",names(data))
  names(data)<-gsub("\\.\\.","\\.",names(data))
  
  tidy_set<-average_data(data)
  
return (tidy_set)
}

average_data<-function(data_set){
  melted<-melt(data_set,id.vars=c("Subject","Activity"))
  result <- dcast(melted, Subject + Activity ~ variable, mean)
  
  return (result)
}
