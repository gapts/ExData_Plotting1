## Exploratory Data Analysis, Course Project #1

#upload and unzip data
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td = tempdir()
tf = tempfile(tmpdir=td, fileext=".zip")
download.file(fileUrl, tf)
flist = unzip(tf, list=TRUE)
fname = unzip(tf, list=TRUE)$Name[1]
unzip(tf, files=fname, exdir=td, overwrite=TRUE)
fpath = file.path(td, fname)
data<-read.csv(fpath,sep=";",stringsAsFactor=F,header=TRUE)
#file<-basename(fpath)  
#assign(paste(file[],sep=""),tmp)

#Data transformation & clean-up
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$dtime<-paste(data$Date,data$Time)
data$dtime<-as.POSIXct(data$dtime,format="%Y-%m-%d %H:%M:%S")
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
data$check<-ifelse(data$Date == ("2007-02-01") | data$Date == ("2007-02-02"),"Y","-")

#Subsetting needed data for the dates 2007-02-01 and 2007-02-02.
dta2<-data[which(data$check=="Y"),]

#plot2
plot(dta2$dtime,dta2$Global_active_power, type="n",xlab="",ylab="Global Active Power (kilowatts)") 
lines(dta2$dtime,dta2$Global_active_power,) 
dev.copy(png, file = "plot2.png")
dev.off()

