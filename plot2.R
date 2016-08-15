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
e$Global_reactive_power <- as.numeric(as.character(e$Global_reactive_power))

## First show it.
## Plot 2 is a line plot for date vs. Global Active Power in kilowatts.
## Set y-axis label. Plot with type="n" first, then draw the lines.
with(e, {
plot(datetime, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab = "")
lines(datetime, Global_active_power, type="l")
})

## Then save it as a .png file with height/width of 480/480 pixels
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(e, {
    plot(datetime, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab = "")
    lines(datetime, Global_active_power, type="l")
})
dev.off()
