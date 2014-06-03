library(sqldf)
library(datasets)
library(chron)
if (!file.exists("./household_power_consumption.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile ="./household_power_consumption.zip")
        unzip("./household_power_consumption.zip")        
}
file <- "./household_power_consumption.txt"
myData <- read.csv.sql(file, sep = ";", sql = 'select * from file where Date == "1/2/2007" OR Date == "2/2/2007"')
dates <- myData$Date
times <- myData$Time
mytime <- chron(dates,times, format=c('d/m/y','H:M:S'))
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(myData, {
        plot(mytime, myData$Global_active_power, type = 'l', xaxt = "n", xlab = "", col ="black",
             ylab = 'Global Active Power' )
        axis(1, as.Date(mytime), format(mytime, "%a"))
        plot(mytime, myData$Voltage, type = 'l', xaxt = "n", xlab = "", col ="black",
             ylab = 'Voltage' )
        axis(1, as.Date(mytime), format(mytime, "%a"))
        plot(mytime, myData$Sub_metering_1, type = 'l', xaxt = "n", xlab = "", col ="black",
             ylab = 'Enegy sub metering' )
        lines(mytime, myData$Sub_metering_2, col ="red")
        lines(mytime, myData$Sub_metering_3, col ="blue")
        axis(1, as.Date(mytime), format(mytime, "%a"))
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty =c (1, 1, 1), col = c("black", "red", "blue"), pt.cex=1, cex=0.7)
        plot(mytime, myData$Global_reactive_power, type = 'l', xaxt = "n", xlab = "", col ="black",
             ylab = 'Global_reactive_power' )
        axis(1, as.Date(mytime), format(mytime, "%a"))
        
})

dev.copy(png, file = "plot4.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()