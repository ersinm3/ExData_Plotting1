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

## Add a POSIXlt column for Date and Time concatenated (call it DT)
t <- paste(as.character(e$Date), as.character(e$Time))
t <- strptime(t, format = "%Y-%m-%d %H:%M:%S")
e$DT <- t

## Make columns numeric
e$Global_reactive_power <- as.numeric(as.character(e$Global_reactive_power))
e$Sub_metering_1 <- as.numeric(as.character(e$Sub_metering_1))
e$Sub_metering_2 <- as.numeric(as.character(e$Sub_metering_2))
e$Sub_metering_3 <- as.numeric(as.character(e$Sub_metering_3))

## First show it.
## Plot 3 is a line plot for date vs. Energy Sub Metering.
## Set y-axis label. Plot with type="n" first, then draw the lines.
## Draw three lines for the three sub metering columns in three colors.
## Place legend in topright.
with(e, {
    plot(datetime, Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab = "")
    lines(datetime, Sub_metering_1, type="l")
    lines(datetime, Sub_metering_2, type="l", col="red")
    lines(datetime, Sub_metering_3, type="l", col="blue")
    legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
})

## Then save it as a .png file with height/width of 480/480 pixels
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(e$DT, as.numeric(e$Sub_metering_1), type="n", ylab="Energy Sub Metering", xlab = "")
lines(e$DT, as.numeric(e$Sub_metering_1), type="l")
lines(e$DT, as.numeric(e$Sub_metering_2), type="l", col="red")
lines(e$DT, as.numeric(e$Sub_metering_3), type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
dev.off()
