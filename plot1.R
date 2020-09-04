library(dplyr)
library(lubridate)

##Loads EPC Data
EPC <- fread("household_power_consumption.txt") %>%
       filter(Date == c("1/2/2007", "2/2/2007"))

##Converts Date colum to date object rather than character
EPC <- mutate(EPC, Date = as.Date(Date, format = "%d/%m/%Y"))

##Converts Global_active_power to numeric vector
EPC <- mutate(EPC, Global_active_power = as.numeric(EPC$Global_active_power))

##Creates png file 
png("plot1.png", width = 480, height = 480)

##Creates histogram per specifications in project instructions
hist(EPC$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()


