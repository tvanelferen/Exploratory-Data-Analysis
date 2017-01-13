##loading data
energydata<-read.csv2("household_power_consumption.txt",sep=";", header = TRUE, stringsAsFactors = FALSE)
##convert dates-characters to class "Date"
energydata$Date<-as.Date(energydata$Date, "%d/%m/%Y")

##subset usable data
energy<-energydata[(energydata$Date=="2007-02-01") | (energydata$Date=="2007-02-02"),]

##convert Time-characters to class "POSIXlt"
energytime<-paste(energy$Date,energy$Time)
energy$Time<-strptime(energytime, format = "%Y-%m-%d %H:%M:%S")

##convert dates-characters to class "POSIXlt"
energy$Date<-strptime(energy$Date, "%Y-%m-%d")

##convert characters that are numeric to class "numeric"
energy[,(3:9)]<-as.numeric(unlist(energy[,(3:9)]))

##Create png
png(filename = "Plot2.png", width = 480, height = 480, units = "px")
#create plot, without drawing the lines
with(energy, plot(Time,Global_active_power, 
                  type="n", 
                  ylab="Global Active Power (kilowatts)",
                  xlab=""))
#draw lines
with(energy, lines(Time,Global_active_power))
#close device
dev.off()