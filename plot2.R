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

# Plot Global active power over time.
plot(pwr$timestamp, pwr$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

# Copy the plot to file.
dev.copy(png, file="plot2.png")
dev.off()