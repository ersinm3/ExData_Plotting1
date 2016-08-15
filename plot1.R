## Get the data
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

## Plot 1 is a histogram for Global Active Power, a column in the data.
## Note that this column is read in as factor so we need to convert to numeric
## Set main title and x-axis label.
## Color the histogram bars red.
hist(e$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col = "red")

## Save it as a .png file with height/width of 480/480 pixels
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(e$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col = "red")
dev.off()
