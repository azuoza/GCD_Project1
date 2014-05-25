
# input: none
# output: 
#        1. formated data frame with all subjects
#        2. averaged data frame for all subjects and all activities

# author: A.Zuoza
# email: azuoza(at)gmail(dot)com

# Part 1
# description: script reads Human Activity Recognition Using Smartphones Dataset
# and returns formated data frame. 


# reading data
x.train <- read.table("./Data/train/X_train.txt")
y.train <- read.table("./Data/train/y_train.txt")
sub.train <- read.table("./Data/train/subject_train.txt")
x.test <- read.table("./Data/test/X_test.txt")
y.test <- read.table("./Data/test/y_test.txt")
sub.test <- read.table("./Data/test/subject_test.txt")
kColNames <- read.table("./Data/features.txt")
act.labes <- read.table("./Data/activity_labels.txt")

# adding column names
kColNames <- as.character(kColNames[,-1])
kColNames <- sapply(kColNames, 
                    FUN=function(x){
                        x <- gsub("-", ".", x)    # replacing - with .
                        x <- gsub("\\(\\)", ".", x)    # replacing () with .
                        x <- gsub("\\(", ".", x)    # replacing ( with .
                        x <- gsub("\\)", ".", x)    # replacing ) with .
                        x <- gsub("\\,", ".", x)    # replacing , with .
                        x <- gsub("\\.\\.", ".", x)    # replacing .. with .
                        x <- gsub("(\\.)$", "", x)    # removing . at the end
                        }
                    )
kColNames <- as.character(kColNames)

colnames(x.train) <- kColNames
colnames(x.test) <- kColNames

rm(kColNames)    # removving kColNames from memmory

# adding activity labels to y
# converting act.labes from data frame to char vector
act.labes <- as.character(act.labes$V2)
act.labes <- tolower(act.labes)
act.labes <- sapply(act.labes, 
                    FUN=function(x){
                        x <- gsub("_",".",x)    # replacing _ with .
                    })
act.labes <- as.character(act.labes)

# converting y from data frame to factor vectors
y.train <- factor(
        x=as.integer(y.train$V1),
        labels=act.labes
        )
y.test <- factor(
        x=as.integer(y.test$V1),
        labels=act.labes
        )

# adding x and y together

test <- x.test
test$activity <- y.test
test$subject <- sub.test$V1

train <- x.train
train$activity <- y.train
train$subject <- sub.train$V1

ds <- rbind (train, test)

rm(x.test, x.train, y.test, y.train, test, train, sub.test, sub.train)
gc()             # gabage colection

# finding columns with mean and standart deviation

col.index <- grepl(pattern="(.*[mM]ean.*)|(.[sS][tT][dD]*)|(activity)|(subject)",
                   names(ds))
ds <- ds[, col.index]

rm(col.index)

# saving data set to the file 

write.table(x=ds, file="final_ds.cvs", dec=".", sep=";")

# Part 2
# Data set, with the average of each variable for each activity and each subject.

#making subjects vector 
sub.vec <- unique(ds$subject)
aver.ds <- data.frame(matrix(ncol=dim(ds)[2]))
colnames(aver.ds) <- names(ds)
row.numbers <- 1  #row number index

for(i in 1:length(sub.vec)){
    # subseting only ones subjects data
    subs.subject <- subset(ds, ds$subject==i)
    # subseting activity and calculating average
    for(j in 1:length(act.labes)){
        
        print(paste("eilutes nr ", row.numbers, "activity ", j, "subject ", i))
        
        # making activity subset
        subs.activity <- subset(subs.subject, subs.subject$activity==act.labes[j])
        rownames(subs.activity) <- NULL
        if(dim(subs.activity)[1] != 0){
            
            #browser()
            
            #calcucating mean
            aver.val <- sapply(subs.activity[, 1:86], mean)
            #adding activity
            aver.val <- as.numeric(aver.val)
            aver.val[87] <- NA
            #adding subject
            aver.val[88] <- sub.vec[i]
            # copy to aver.ds data set
            aver.ds[row.numbers, ] <- aver.val
            # follow row.numbers
            # adding activity label
            aver.ds$activity <- as.character(aver.ds$activity)
            aver.ds$activity[row.numbers] <- act.labes[j]
            row.numbers <- row.numbers + 1
        }
    }
}
# convert activity to factor
aver.ds$activity <- as.factor(aver.ds$activity)
# write data set to file 
write.table(x=aver.ds, file="aver_ds.csv", dec=".", sep=";")

rm(act.labes)    # removing act.labes from memmory
