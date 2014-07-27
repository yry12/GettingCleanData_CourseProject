# Create a folder to save plot files
if (!file.exists("./temp_finalp")) {
  dir.create("temp_finalp")
}
setwd("./temp_finalp")


## HAR - Human Activity Recognition Using Smartphones
har.url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
har.zip <- "har.zip"
if (!file.exists(har.zip))
  download.file(har.url, destfile = har.zip, method = "auto")

#Extract data
unzip(har.zip)
har.dir <- "UCI HAR Dataset"
setwd(har.dir)


#Create train and test data from csv. Note that we are using the setwd folder above + / subfolder
train = read.csv("train/X_train.txt", sep="", header=FALSE)
train[,562] = read.csv("train/Y_train.txt", sep="", header=FALSE)
train[,563] = read.csv("train/subject_train.txt", sep="", header=FALSE)

test = read.csv("test/X_test.txt", sep="", header=FALSE)
test[,562] = read.csv("test/Y_test.txt", sep="", header=FALSE)
test[,563] = read.csv("test/subject_test.txt", sep="", header=FALSE)


# Features (to add as column names)
features = read.csv("features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge training and test sets together
md <- rbind(train, test)

# Get mean/std
colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2])
# Features, reduced table
features <- features[colsWeWant,]
# Add subject and activity
colsWeWant <- c(colsWeWant, 562, 563)
# And remove the unwanted columns from md
md <- md[,colsWeWant]
# Use features as name (from above), Activity here is just a numeric variables
colnames(md) <- c(features$V2, "activitynum", "subject")
colnames(md) <- tolower(colnames(md))

#Activities (to add as rows)
activities = read.csv("activity_labels.txt", sep="", header=FALSE)
activities
colnames(activities) <- c("activitynum", "activity")

md <- merge(activities, md, all=TRUE)
#Now activity is a factor
md$subject <- as.factor(md$subject)
md[,1] = NULL


tidy = aggregate(md, by=list(activity = md$activity, subject=md$subject), mean)
# Remove the subject (last column) and activity (3 column), since a mean of those has no use
tidy[,90] = NULL
tidy[,3] = NULL
write.table(tidy, "tidy.txt", sep="\t")
