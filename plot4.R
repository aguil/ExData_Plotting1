# Load the data. Combine the Date and Time columns into a single timestamp
# column.
pwr_all <- read.csv2("household_power_consumption.txt")
pwr_all <- within(
    pwr_all, 
    { timestamp=as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")) })

# Subset on the required timestamp values... and exclude those rows with NA 
# timestamp values.
pwr <- pwr_all[pwr_all$timestamp >= strptime("2007-02-01", "%Y-%m-%d"),]
pwr <- pwr[pwr$timestamp < strptime("2007-02-03", "%Y-%m-%d"),]
pwr <- pwr[!is.na(pwr$timestamp),]

# Columns to to plot are factors. Convert them to numeric for plotting.
pwr$Global_active_power <- as.numeric(as.character(pwr$Global_active_power))
pwr$Global_reactive_power <- as.numeric(as.character(pwr$Global_reactive_power))
pwr$Voltage <- as.numeric(as.character(pwr$Voltage))
pwr$Sub_metering_1 <- as.numeric(as.character(pwr$Sub_metering_1))
pwr$Sub_metering_2 <- as.numeric(as.character(pwr$Sub_metering_2))
pwr$Sub_metering_3 <- as.numeric(as.character(pwr$Sub_metering_3))

# 2x2 plots
par(mfrow=c(2, 2))

# In the top row, the Global Active Power and Voltage plots.
plot(pwr$timestamp, pwr$Global_active_power, xlab="", ylab="Global Active Power", type="l")
plot(pwr$timestamp, pwr$Voltage, xlab="datetime", ylab="Voltage", type="l")

# Bottom left, the sub metering plots.
plot(c(min(pwr$timestamp), max(pwr$timestamp)), 
     c(0, max(c(pwr$Sub_metering_1, pwr$Sub_metering_2, pwr$Sub_metering_3))), 
     type = "n", ylab="Energy sub metering", xlab="")
with(pwr, lines(timestamp, Sub_metering_1))
with(pwr, lines(timestamp, Sub_metering_2, col="red"))
with(pwr, lines(timestamp, Sub_metering_3, col="blue"))
legend("topright", bty="n", cex=.75, pch="_", col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Bottom right, the Global reactive power plot.
plot(pwr$timestamp, pwr$Global_reactive_power, 
     xlab="datetime", ylab="Global_reactive_power", type="l")

# Copy the plot to file.
dev.copy(png, file="plot4.png")
dev.off()
