#Load dplyr library - necessary for mutate
library(dplyr)

#Open output file - plot1.png
png(filename="plot2.png", width=480, height=480)

#Read in dataset of household power consumption. Note separator is ; symbol
electric <- read.csv("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";")

#Use dplyr mutate function to add DateTime column. POSIXlt is not supported by dplyr, only POSIXct.
electric <- mutate(electric, DateTime = as.POSIXct(strptime(paste(Date, " ", Time), format = "%d/%m/%Y %H:%M:%S")))
#Filter out dataset, leaving only 2 days in February 2007
electric <- filter(electric, DateTime >= '2007-02-01' & DateTime <= '2007-02-03')
#Draw histogram of Global active power
h <- hist(electric$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", xlim = c(0,6))
#Close output file to write file to disk
dev.off()
