##GET DATA
data = read.csv("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";")

##SUBSET DATA 01/02/2007 - 02/02/2007
subdata <- data[data$Date %in% c("1/2/2007","2/2/2007"),] 

## Convert time columns 
hourTime <- do.call(paste0, subdata[c(1, 2)])
subdata$DateTime <- strptime(hourTime,"%d/%m/%Y%H:%M") 

## Convert Numeric columns
subdata$Global_active_power <- as.numeric(subdata[ ,c("Global_active_power")])


## plot Active-Power line chart
xrange <- range(subdata$DateTime)
yrange <- range(subdata$Global_active_power/1000)
plot(xrange, yrange, type="n", xlab="date time", ylab="Global Active Power(kiloWatts)" ) 
lines(subdata$DateTime, subdata$Global_active_power/1000 )

dev.copy(png, file = "plot2.png")
dev.off() 