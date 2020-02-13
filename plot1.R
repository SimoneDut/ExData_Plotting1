fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.zip"

# Downloading and unzipping the raw data file, if necessary
if (!file.exists(fileName)) {
  print("Downloading the zip file...")
  download.file(fileUrl, destfile = fileName, method = "curl")
  unzip(fileName)
}
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
           colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
           nrows = 2075259, skip = 0, comment.char = "")

# Select only the dates 2007-02-01 and 2007-02-02
hpc <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"),]

# Create a datetime column
hpc$Datetime <- as.POSIXct(strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S"))

# Plot 1
png("plot1.png")
par(mfrow = c(1, 1))
with(hpc, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()