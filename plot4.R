#Load dplyr library - necessary for mutate
library(dplyr)

#Open output file - plot4.png
png(filename="plot2.png", width=480, height=480)

#Read in dataset of household power consumption. Note separator is ; symbol
electric <- read.csv("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";")

#Use dplyr mutate function to add DateTime column. POSIXlt is not supported by dplyr, only POSIXct.
electric <- mutate(electric, DateTime = as.POSIXct(strptime(paste(Date, " ", Time), format = "%d/%m/%Y %H:%M:%S")))
#Filter out dataset, leaving only 2 days in February 2007
electric <- filter(electric, DateTime >= '2007-02-01' & DateTime <= '2007-02-03')
#Use with function to draw the previous charts as well as one new one to the current active device
with(electric, {
  hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", xlim = c(0,6))
  plot(Global_active_power ~ DateTime, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
  lines(Global_active_power ~ DateTime, type="l")
  plot(Sub_metering_1 ~ DateTime, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(Sub_metering_1 ~ DateTime, type="l", col="black")
  lines(Sub_metering_2 ~ DateTime, type="l", col="red")
  lines(Sub_metering_3 ~ DateTime, type="l", col="blue")
  plot(Global_reactive_power ~ DateTime, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
  lines(Global_reactive_power ~ DateTime, type="l")
})
#Close output file to write file to disk
dev.off()
