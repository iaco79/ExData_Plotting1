##GET DATA

data = read.csv("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";")

##SUBSET DATA 01/02/2007 - 02/02/2007

subdata <- data[data$Date %in% c("1/2/2007","2/2/2007"),] 

## Convert time columns 

hourTime <- do.call(paste0, subdata[c(1, 2)])
subdata$DateTime <- strptime(hourTime,"%d/%m/%Y%H:%M") 

## Convert Numeric columns

subdata$Sub_metering_1 <- as.numeric(subdata[ ,c("Sub_metering_1")])
subdata$Sub_metering_2 <- as.numeric(subdata[ ,c("Sub_metering_2")])
subdata$Sub_metering_3 <- as.numeric(subdata[ ,c("Sub_metering_3")])


## plot histogram
xrange <- range(subdata$DateTime)
yrange <- c(0,max(max(subdata$Sub_metering_1),max(subdata$Sub_metering_2),max(subdata$Sub_metering_3)))
plot(xrange, yrange, type="n", xlab="date time", ylab="Energy sub metering" , yaxp=c(0,30,3)) 
lines(subdata$DateTime, subdata$Sub_metering_1, col="black" , xlab="Sub_metering_1")
lines(subdata$DateTime, subdata$Sub_metering_2, col="red" )
lines(subdata$DateTime, subdata$Sub_metering_3, col="blue" )
legend("topright",  col=c("black","red","blue") , legend=c("Sub_met_1       ","Sub_met_2      ","Sub_met_3      ") ,lwd=c(1.5))

dev.copy(png, file = "plot3.png")
dev.off() 