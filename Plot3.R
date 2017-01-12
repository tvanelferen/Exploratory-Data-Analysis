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
png(filename = "Plot3.png", width = 540, height = 540, units = "px")
#create plot, without drawing the lines
with(energy, plot(Time,Sub_metering_1, 
                  type="n", 
                  ylab="Energy sub metering",
                  xlab=""))
#draw lines
with(energy, lines(Time,Sub_metering_1))
with(energy, lines(Time,Sub_metering_2, col="red"))
with(energy, lines(Time,Sub_metering_3, col="blue"))

#create legenda
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1),
       col = c("black", "red", "blue"))
#close device
dev.off()