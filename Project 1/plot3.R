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


### --- plot3.png ---
png("plot3.png", width=480, height=480)

with(df, {
    plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    points(DateTime,Sub_metering_2,col="red", type="l")
    points(DateTime,Sub_metering_3,col="blue", type="l")
})
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()