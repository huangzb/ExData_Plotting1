library(sqldf)
library(datasets)
library(chron)
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
mytime <- chron(dates,times, format=c('d/m/y','H:M:S'))
plot(mytime, myData$Global_active_power, type = 'l', xaxt = "n", xlab = "",
     ylab = 'Global Active Power (kilowatts)' )
axis(1, as.Date(mytime), format(mytime, "%a"))
dev.copy(png, file = "plot2.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()