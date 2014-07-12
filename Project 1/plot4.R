### sqldf library allows manipulate R data frames using SQL
### install.packages("sqldf")

### set EN as locale
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

library(sqldf)
### read data by SQL statement
df <- read.csv.sql("household_power_consumption.txt", sql="select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')", header=T, sep=";")

### rename first column
names(df)[1] <- "DateTime"

### merge Date and Time to DateTime and convert to Date/Time class
df$DateTime <- paste(df$DateTime, df$Time, sep=" ")
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

### remove Time column
df$Time <- NULL

### save data in (2007/2/1, 2007/2/2)
### write.csv(df,file="data.csv")

### --- plot4.png ---
png("plot4.png", width=480, height=480)

### set 2x2 row-flow
par(mfrow=c(2,2))

### plot (1,1)
plot(df$DateTime, df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

### plot (1,2)
plot(df$DateTime, df$Voltage, type="l", ylab="Votage", xlab="datetime")

### plot (2,1)
with(df, {
    plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    points(DateTime,Sub_metering_2,col="red", type="l")
    points(DateTime,Sub_metering_3,col="blue", type="l")
})
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=1, cex=0.9, bty="n")

### plot (2,2)
plot(df$DateTime, df$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()