###Exploratory Data Analysis - Week 1, Project 1
# dataset - electric power consumption: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

### PLOT 4
library(tidyverse)
#unzip the file and save in wd
zipped_files <- list.files("data/EDA-Project1", pattern = ".zip$", full.names = TRUE)
walk(zipped_files, unzip, exdir= "data/EDA1unzipped")
file.names <- list.files("data/EDA1unzipped", full.names = TRUE)
#read in the data
epc <- read.table(file.names, sep = ";", header = TRUE, na.strings = "?") 

#subset and filter
epc_dt <- epc %>% 
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
  mutate(across(c(Global_active_power,Global_reactive_power, Voltage, Global_intensity, Sub_metering_1,Sub_metering_2),as.numeric)) %>% 
  mutate(DateTime = strptime(x = paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
         Day = as.character(wday(DateTime, label = TRUE)))

#create plot, annotate, and save copy
par(mfcol = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0)) #sets params for visual
with(epc_dt,{
  plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power") #creates plot in topleft corner
  plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" ) #creates plot in bottomleft corner
  lines(DateTime,Sub_metering_2, col = "red") #adds line to 2nd plot
  lines(DateTime,Sub_metering_3, col = "blue") #adds line to 2nd plot
  legend("topright", col = c("black","red","blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))#creates legend to 2nd plot
  plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage") #creates plot in topright corner
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global reactive power") #creates plot in bottomright corner
  
})
dev.copy(png, filename = 'ExData_Plotting1/plot4.png', height=480, width=480)
dev.off()
