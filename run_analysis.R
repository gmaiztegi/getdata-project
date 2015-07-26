loadData <- function (directory = "UCI HAR Dataset") {
    subjectsTrain <- read.table(paste(directory, "/train/subject_train.txt", sep = ""))
    subjectsTest <- read.table(paste(directory, "/test/subject_test.txt", sep = ""))
    featuresTrain <- read.table(paste(directory, "/train/X_train.txt", sep = ""))
    featuresTest <- read.table(paste(directory, "/test/X_test.txt", sep = ""))
    labelsTrain <- read.table(paste(directory, "/train/Y_train.txt", sep = ""))
    labelsTest <- read.table(paste(directory, "/test/Y_test.txt", sep = ""))
    
    cols <- c("V1", "V2", "V3", "V4", "V5", "V6",
              "V41", "V42", "V43", "V44", "V45", "V46",
              "V121", "V122", "V123", "V124", "V125", "V126")
    
    subjects <- rbind(subjectsTrain, subjectsTest)
    features <- rbind(featuresTrain[,cols], featuresTest[,cols])
    labels <- rbind(labelsTrain, labelsTest)
    
    labelMap <- read.table(paste(directory, "/activity_labels.txt", sep = ""))
    textLabels <- sapply(labels$V1, function(label) {
        #labelMap[labelMap$V1==label,"V2"]
        label
    })
    
    data.frame(
        subject = subjects$V1,
        activity = textLabels,
        tBodyAcc.mean.X = features$V1,
        tBodyAcc.mean.Y = features$V2,
        tBodyAcc.mean.Z = features$V3,
        tBodyAcc.std.X = features$V4,
        tBodyAcc.std.Y = features$V5,
        tBodyAcc.std.Z = features$V6,
        tGravityAcc.mean.X = features$V41,
        tGravityAcc.mean.Y = features$V42,
        tGravityAcc.mean.Z = features$V43,
        tGravityAcc.std.X = features$V44,
        tGravityAcc.std.Y = features$V45,
        tGravityAcc.std.Z = features$V46,
        tBodyGyro.mean.X = features$V121,
        tBodyGyro.mean.Y = features$V122,
        tBodyGyro.mean.Z = features$V123,
        tBodyGyro.std.X = features$V124,
        tBodyGyro.std.Y = features$V125,
        tBodyGyro.std.Z = features$V126
        )
}

createAverages <- function(data, directory = "UCI HAR Dataset") {
    averages <- ddply(data, .(subject, activity), colMeans)
    labelMap <- read.table(paste(directory, "/activity_labels.txt", sep = ""))
    averages$activity <- sapply(averages$activity, function(label) {
        labelMap[labelMap$V1==label,"V2"]
    })
    averages
}

writeAverages <- function(directory = "UCI HAR Dataset", outfile = "data.txt") {
    loadeddata <- loadData(directory)
    averages <- createAverages(loadeddata)
    write.table(averages, file = outfile, row.names = FALSE)
}