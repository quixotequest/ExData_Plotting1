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

## Plot the first graph using 'dataSel' to a PNG
  png(filename="plot1.png", width=480, height=480, units="px", bg="white")
  hist(dataSel$Global_active_power, main="Global Active Power",
       xlab="Global Active Power (kilowatts)", 
       ylab="Frequency",
       col='red')
  
  
  