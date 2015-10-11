library(data.table)
library(dplyr)
library(lubridate)

mypath <- "C:/Users/Rivaldo/Documents/exploratory_data_analysis/data_for_project_one/"
filedata <- "household_power_consumption.txt"
pathComplete <- file.path(mypath, filedata)
data <- read.table(pathComplete, sep = ";")
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

par(mar = c(5,5,2,1))
#partition <- c(0:14)/2 -0.05

GAP = as.vector(mydataset3$Global_active_power)# as vector to transform  
GAP = as.numeric(GAP)
hist(GAP, col = "red", main = "Global Active Power",
     xlab= "Global Active power (Kilowatts)",
     ylab= "Frequency", ylim = range(0:1200, 200))
## xlim = range(0:6, 2)
##================================================
mytime <- paste(mydataset3$Date, mydataset3$Time)
totalTime <- strptime(mytime, format = "%Y-%m-%d %H:%M:%S")
#myDay <-  wday(totalTime, label = TRUE, abbr = FALSE) esto no es necesario

par(mar = c(5,5.5,2,1))
 plot(totalTime, GAP, type="l", ylab =  "Global Active power (Kilowatts)", xlab = "")
##=================================================

SM1 <- as.vector(mydataset3[,7])# as vector solo funciona haciendo columna por columna
SM2 <- as.vector(mydataset3[,8])
SM3 <- as.vector(mydataset3[,9])
SM1 <- as.numeric(SM1)
SM2 <- as.numeric(SM2)
SM3 <- as.numeric(SM3)


lines(totalTime, SM2, col= "red")
lines(totalTime, SM3, col= "blue")
legend( "topright",  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        lty=c(1,1,1), lwd=c(1.5,1.5,1.5), col= c("black","blue","red"),
        cex = 0.75)
plot(totalTime, SM1, type="l", ylim = range(0:38, 10), xlab = "", 
      ylab = "Energy sub metering")
      lines(totalTime, SM2, col= "red")
      lines(totalTime, SM3, col= "blue")
      legend( "topright",  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
      lty=c(1,1,1), lwd=c(1.5,1.5,1.5), col= c("black","blue","red"),
      cex = 0.75)

#cex for size of box, 
# adj for moving the text in the legend
# y.intersp for interspace in y direction in the legend
# , xjust = 0, cex = 0.8, adj = c(0, 0.0), y.intersp = 0.75

##====================================================
myvoltage <- as.vector(mydataset3$Voltage)
myvoltage <- as.numeric(myvoltage)

myGRP <- as.vector(mydataset3$Global_reactive_power)
myGRP <- as.numeric(myGRP)

par(mfcol=c(2,2))
par(mar = c(5,5,2,1))
plot(totalTime, GAP, type="l", ylab =  "Global Active power (Kilowatts)", xlab = "")
plot(totalTime, SM1, type="l", ylim = range(0:38, 10), xlab = "", 
     ylab = "Energy sub metering")
lines(totalTime, SM2, col= "red")
lines(totalTime, SM3, col= "blue")
legend( totalTime[800], 40,  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        lty=c(1,1,1), lwd=c(1.5,1.5,1.5), col= c("black","blue","red"),
        cex = 0.7, bty = "n", y.intersp = 0.3 )
plot(totalTime, myvoltage, type = "l", ylab = "Voltage", xlab = "datetime", ylim = range(233,247))
plot(totalTime, myGRP, type = "l", ylab = "Global_reactive_power", xlab = "datetime", ylim = range(0,0.5))



