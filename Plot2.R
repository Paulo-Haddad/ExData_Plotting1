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

# Save Plot 2 as PNG
png("plot2.png", width = 480, height = 480, units = "px")
plot(data[,10],data[,3], type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()