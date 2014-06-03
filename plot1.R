library(sqldf)
library(datasets)
if (!file.exists("./household_power_consumption.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile ="./household_power_consumption.zip")
        unzip("./household_power_consumption.zip")        
}

file <- "./household_power_consumption.txt"
#setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y;%H:%M:%S"))
#colClasses = c('myDate', rep('numeric',7))
myData <- read.csv.sql(file, sep = ";", sql = 'select * from file where Date == "1/2/2007" OR Date == "2/2/2007"')
dates <- myData$Date
times <- myData$Time
x <- paste(dates, times)
mytime <- strptime(x, "%d/%m/%y %H:%M:%S")
hist(myData$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()