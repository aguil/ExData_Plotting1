pwr_all <- read.csv2("household_power_consumption.txt")
pwr_all <- within(pwr_all, { timestamp=as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")) })
pwr <- pwr_all[pwr_all$timestamp >= strptime("2007-02-01", "%Y-%m-%d"),]
pwr <- pwr[pwr$timestamp < strptime("2007-02-03", "%Y-%m-%d"),]
plot(pwr$timestamp, pwr$Global_active_power/1000*2, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()