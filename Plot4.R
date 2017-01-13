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
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
#create parameter for four plots
par(mfrow=c(2,2))
#create plot1, without drawing the lines
with(energy, plot(Time,Global_active_power, 
                  type="n", 
                  ylab="Global Active Power (kilowatts)",
                  xlab=""))
#draw lines plot1
with(energy, lines(Time,Global_active_power))

#create plot2, without drawing the lines
with(energy, plot(Time,Voltage,type="n", xlab="datetime"))
#draw lines plot2
with(energy, lines(Time,Voltage))

#create plot3, without drawing the lines
with(energy, plot(Time,Sub_metering_1, 
                  type="n", 
                  ylab="Energy sub metering",
                  xlab=""))
#draw lines plot3
with(energy, lines(Time,Sub_metering_1))
with(energy, lines(Time,Sub_metering_2, col="red"))
with(energy, lines(Time,Sub_metering_3, col="blue"))

#create legend plot 3
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1),
       col = c("black", "red", "blue"), bty="n")

#create plot4, without drawing the lines
with(energy, plot(Time,Global_reactive_power, 
                  type="n",
                  xlab="datetime"))
#draw lines plot4 
with(energy, lines(Time,Global_reactive_power))
#close device
dev.off()