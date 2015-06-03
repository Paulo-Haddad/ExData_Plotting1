# Load necessary libraries
library("lubridate", lib.loc="~/R/win-library/3.1")

# Import data from working directory, including variables names. Date and Time imported as character. Other variables imported as numeric.
# The script only imports the days used in the Project (2007-2-1 and 2007-2-2)
classes <- c(rep("character",2), rep("numeric",7))
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classes, skip = 66636, nrows = 2880)

headings <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", nrows = 1)
colnames(data) <- headings

# Merge and convert Date and Time to POSIXct class (converted variable stored in a new variable called "Dia")
data$Dia <- paste(data$Date,data$Time)
data$Dia <- dmy_hms(data$Dia)

# Save Plot 4 as PNG
png("plot4.png", width = 480, height = 480, units = "px", res = 85)

par(mfrow = c(2,2))
par(mar = c(4,4,2,2))
plot(data[,10],data[,3], type="l", xlab = "", ylab = "Global Active Power")

plot(data[,10],data[,5], type="l", xlab = "datetime", ylab = "Voltage")

plot(data[,10],data[,7], type="n", xlab = "", ylab = "Energy sub metering")
lines(data[,10],data[,7])
lines(data[,10],data[,8], col = "red")
lines(data[,10],data[,9], col = "blue")
legend("topright", lwd = 1, cex = 0.8, col = c("black", "red", "blue"), legend = colnames(data[,7:9]), bty = "n")

plot(data[,10],data[,4], type="l", xlab = "datetime", ylab = colnames(data[4]))
dev.off()