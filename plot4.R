url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zname <- "hpc.zip"
download.file(url, zname)
fname <- as.character(unzip(zname, list = TRUE)[1])
unzip(zname)
d <- read.csv(fname, sep = ";")

## First column (Date) is read in as factor. Change to date class.
d[, 1] <- as.Date(d[, 1], "%d/%m/%Y")

## Keep just data for the dates 1/2/2007 and 2/2/2007 (d/m/yyyy here)
e <- subset(d, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## Add a POSIXlt column for Date and Time concatenated (call it datetime)
t <- paste(as.character(e$Date), as.character(e$Time))
t <- strptime(t, format = "%Y-%m-%d %H:%M:%S")
e$datetime <- t

## Make columns numeric
e$Voltage <- as.numeric(as.character(e$Voltage))
e$Global_active_power <- as.numeric(as.character(e$Global_active_power))
e$Global_reactive_power <- as.numeric(as.character(e$Global_reactive_power))
e$Sub_metering_1 <- as.numeric(as.character(e$Sub_metering_1))
e$Sub_metering_2 <- as.numeric(as.character(e$Sub_metering_2))
e$Sub_metering_3 <- as.numeric(as.character(e$Sub_metering_3))

## First show it.
## Plot 4 is four plots consisting of plots 2 and 3 plus voltage vs. date and 
## Global Reactive Power vs date.

## Set up plots area.
par(mfcol=c(2, 2))

## First plot 2
with(e, {
    plot(datetime, Global_active_power/1000, type="n", ylab="Global Active Power", xlab = "")
    lines(datetime, Global_active_power/1000, type="l")
    
    ## then do plot 3
    plot(datetime, Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab = "")
    lines(datetime, Sub_metering_1, type="l")
    lines(datetime, Sub_metering_2, type="l", col="red")
    lines(datetime, Sub_metering_3, type="l", col="blue")
    legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
    
    ## next plt date vs. voltage
    plot(datetime, Voltage, type="n")
    lines(datetime, Voltage)
    
    ## lastly plot date vs. Global reactive power
    plot(datetime, Global_reactive_power, type="n")
    lines(datetime, Global_reactive_power)
})

## Then save it as a .png file with height/width of 480/480 pixels (default)
dev.copy(file="plot4.png")
dev.off()
