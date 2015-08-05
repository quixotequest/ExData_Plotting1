## Read in data from local wd downloaded file
## With a general length limit of row data that includes desired time period
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, sep=";", 
                   colClasses=c("character","character","double","double","double","double","double","double","numeric"),
                   na.strings="?",
                   stringsAsFactors=FALSE, comment.char="", nrows=69520)
data$DateTime = paste(data$Date, data$Time) ## Create a new DateTime column
data$DateTime = as.POSIXlt(data$DateTime,format="%d/%m/%Y %H:%M:%S") ## set the col class & order
## delete the prev date and time cols
data$Date <- NULL
data$Time <- NULL
## select a subset from the dataset to use for the graphs
dataSel <- subset(data, DateTime$year==107 & DateTime$mon==1 & (DateTime$mday==1 | DateTime$mday==2))

## Plot the fourth set of graphs using 'dataSel' to a PNG
png(filename="plot4.png", width=480, height=480, units="px", bg="white")
  ##Plot 1
par(mfrow=c(2,2))
plot(x=dataSel$DateTime, y=dataSel$Global_active_power,
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
  ##Plot2
plot(x=dataSel$DateTime, y=dataSel$Voltage, 
     type="l", xlab="datetime", ylab="Voltage")
  ##Plot3
plot(x=dataSel$DateTime, y=dataSel$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x=dataSel$DateTime, y=dataSel$Sub_metering_2, col="red")
lines(x=dataSel$DateTime, y=dataSel$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), cex=.8, lwd=4)
  ##Plot4
plot(dataSel$DateTime, dataSel$Global_reactive_power, type = "l", 
      main = "", xlab = "datetime", ylab ="Global_reactive_power", col="black")
dev.off()

  
  