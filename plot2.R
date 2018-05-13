#Load dplyr library - necessary for mutate
library(dplyr)

#Open output file - plot2.png
png(filename="plot2.png", width=480, height=480)

#Read in dataset of household power consumption. Note separator is ; symbol
electric <- read.csv("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";")

#Use dplyr mutate function to add DateTime column. POSIXlt is not supported by dplyr, only POSIXct.
electric <- mutate(electric, DateTime = as.POSIXct(strptime(paste(Date, " ", Time), format = "%d/%m/%Y %H:%M:%S")))
#Filter out dataset, leaving only 2 days in February 2007
electric <- filter(electric, DateTime >= '2007-02-01' & DateTime <= '2007-02-03')
#Create plot axes and labels but do not draw data yet
plot(electric$Global_active_power ~ electric$DateTime, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
#Draw data as line chart
lines(electric$Global_active_power ~ electric$DateTime, type="l")
#Close output file to write file to disk
dev.off()
