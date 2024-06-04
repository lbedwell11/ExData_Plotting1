###Exploratory Data Analysis - Week 1, Project 1
# dataset - electric power consumption: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

### PLOT 1
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
  mutate(across(c(Global_active_power,Global_reactive_power, Voltage, Global_intensity, Sub_metering_1,Sub_metering_2),as.numeric))

#create plot, annotate, and save copy
hist(epc_dt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, filename = 'ExData_Plotting1/plot1.png', height=480, width=480)
dev.off()
