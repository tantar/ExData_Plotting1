library(dplyr)
library(lubridate)

##Loads EPC Data
EPC <- fread("household_power_consumption.txt") %>%
  filter(Date == c("1/2/2007", "2/2/2007"))

##Converts Date colum to date object rather than character
EPC <- mutate(EPC, Date.Time = paste(Date, Time), Date = NULL, Time = NULL, 
             .before = "Global_active_power") %>%
       mutate(EPC, Date.Time = parse_date_time(Date.Time,"d/m/y H:M:S"))
        
##Converts Global_active_power to numeric vector
EPC <- mutate(EPC, Global_active_power = as.numeric(EPC$Global_active_power))

##Creates png file 
png("plot2.png", width = 480, height = 480)

#Creates plot 
plot(EPC$Date.Time, EPC$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
