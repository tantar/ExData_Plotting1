library(dplyr)
library(lubridate)

##Loads EPC Data
EPC <- fread("household_power_consumption.txt") %>%
  filter(Date == c("1/2/2007", "2/2/2007"))

##Converts Date colum to date object rather than character
EPC <- mutate(EPC, Date.Time = paste(Date, Time), Date = NULL, Time = NULL, 
              .before = "Global_active_power") %>%
  mutate(EPC, Date.Time = parse_date_time(Date.Time,"d/m/y H:M:S"))

##Converts Sub_metering to numeric vector
EPC <- mutate(EPC, Sub_metering_1 = as.numeric(EPC$Sub_metering_1)) %>%
       mutate(Sub_metering_2 = as.numeric(EPC$Sub_metering_2)) %>%
       mutate(Sub_metering_3 = as.numeric(EPC$Sub_metering_3)) 

##Creates png file 
png("plot3.png", width = 480, height = 480)

#Creates plot 3
plot(EPC$Sub_metering_1, type = "l", col = "Black", xlab = "", 
     ylab = "Energy sub metering")
points(EPC$Date.Time, EPC$Sub_metering_2, type = "l", col = "Red")
points(EPC$Date.Time, EPC$Sub_metering_3, type = "l", col = "Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), col = c("Black", "Red", "Blue")
       , lwd = 1)

dev.off()
