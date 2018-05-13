#Load dplyr library - necessary for mutate
library(dplyr)

#Open output file - plot3.png
png(filename="plot2.png", width=480, height=480)

#Read in dataset of household power consumption. Note separator is ; symbol
electric <- read.csv("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";")

#Use dplyr mutate function to add DateTime column. POSIXlt is not supported by dplyr, only POSIXct.
electric <- mutate(electric, DateTime = as.POSIXct(strptime(paste(Date, " ", Time), format = "%d/%m/%Y %H:%M:%S")))
#Filter out dataset, leaving only 2 days in February 2007
electric <- filter(electric, DateTime >= '2007-02-01' & DateTime <= '2007-02-03')
#Create plot axes and labels but do not draw data yet
plot(electric$Sub_metering_1 ~ electric$DateTime, type = "n", xlab = "", ylab = "Energy sub metering")
#Draw data as line chart
lines(electric$Sub_metering_1 ~ electric$DateTime, type="l", col="black")
lines(electric$Sub_metering_2 ~ electric$DateTime, type="l", col="red")
lines(electric$Sub_metering_3 ~ electric$DateTime, type="l", col="blue")
#Close output file to write file to disk
dev.off()
