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

SM1 <- as.vector(mydataset3[,7])# as vector only works one by one
SM2 <- as.vector(mydataset3[,8])
SM3 <- as.vector(mydataset3[,9])
SM1 <- as.numeric(SM1)
SM2 <- as.numeric(SM2)
SM3 <- as.numeric(SM3)

png("plot3.png", width=480, height=480)
par(mar = c(5,5,2,1))
plot(totalTime, SM1, type="l", ylim = range(0:38, 10), xlab = "", 
      ylab = "Energy sub metering")
      lines(totalTime, SM2, col= "red")
      lines(totalTime, SM3, col= "blue")
      legend( "topright",  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
      lty=c(1,1,1), lwd=c(1.5,1.5,1.5), col= c("black","blue","red"),
      cex = 0.75)
dev.off()
#cex for size of box, 
# adj for moving the text in the legend
# y.intersp for interspace in y direction in the legend
# , xjust = 0, cex = 0.8, adj = c(0, 0.0), y.intersp = 0.75
