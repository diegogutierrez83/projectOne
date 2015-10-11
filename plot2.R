library(data.table)
library(dplyr)
library(lubridate)

mypath <- "C:/Users/Rivaldo/Documents/exploratory_data_analysis/data_for_project_one/"
filedata <- "household_power_consumption.txt"
pathComplete <- file.path(mypath, filedata)
data <- read.table(pathComplete, sep = ";")
setwd(mypath)
mydataset1 <- data
dim(mydataset1)
mydataset1[1:3,1:4]
oldNames <- names(mydataset1) 
newNames <- t(mydataset1[1,1:9]) # names has to be vertical vectors.
setnames(mydataset1, oldNames, newNames)
mydataset2 <- mydataset1[-1,]
mydataset2[1:3,1:4]
row.names(mydataset2) <- 1:length(mydataset2$Date)
mydataset2[1:3,1:4]
myBeging <- ymd("2007-02-01")
myEnd <- ymd("2007-02-02")
mydataset2$Date <- dmy(mydataset2$Date) 
mydataset3 <- subset(mydataset2, Date >= myBeging  & Date <= myEnd )
mydataset3[1:3,1:4]
unique(mydataset3$Date) # to verify is my subset is ok.
##=================================

mytime <- paste(mydataset3$Date, mydataset3$Time)
totalTime <- strptime(mytime, format = "%Y-%m-%d %H:%M:%S")


GAP = as.vector(mydataset3$Global_active_power)# as vector to transform  
GAP = as.numeric(GAP)

#myDay <-  wday(totalTime, label = TRUE, abbr = FALSE) esto no es necesario
png("plot2.png", width=480, height=480)
par(mar = c(5,5.5,2,1))
plot(totalTime, GAP, type="l", ylab =  "Global Active power (Kilowatts)", xlab = "")
dev.off()
