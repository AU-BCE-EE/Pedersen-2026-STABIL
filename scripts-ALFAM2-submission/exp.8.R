


#read in the data, here we need to specify that files were renamed
data <- readCRDS('Blank')

data <- rbind(data)

#merge date and time
data$date.time <- paste(data$DATE, data$TIME)
data$date.time<-ymd_hms(data$date.time)
data$date.time <- data$date.time
# Filter data and synchronize Picarro and real time
data <- data[data$date.time >= as.POSIXct("2022-09-21 10:00:52", tz="UTC"), ]
data$date.time <- data$date.time + hours(1) + minutes(47)
#assign id for each MPVP position
data$id <- data$MPVPosition
# select the last point of each measurent from each valve 
data <- filter(data, !(data$id == lead(data$id)))

# Selecting points with entire numbers only (in the Picarro, when the position is switching from a valve to another there is no entire number)
data <- data[data$id == '1' | data$id == '2' | data$id == '3' | data$id == '4' | data$id == '5' | data$id == '6' | data$id == '7' | 
               data$id == '8' | data$id == '9'| data$id == '10'| data$id == '11'| data$id == '12' ,]
#calculate elapsed time from the beginning of experiment, with 1st elapsed time being 0 for each id
data <- data %>%
  group_by(id) %>%
  mutate(elapsed.time = as.numeric(difftime(date.time, min(date.time), units = 'hours'))) %>%
  ungroup()
data$elapsed.time<-round(data$elapsed.time)   

# add a column with treatment names
data$treat <- data$id
#assign correct names to each treatment
data$treat <- mapvalues(data$treat, from = c('1', '6', '12'), to = c(rep('AD-LB1', 3)))
data$treat <- mapvalues(data$treat, from = c('4', '5', '9'), to = c(rep('AD-LB2', 3)))
data$treat <- mapvalues(data$treat, from = c('2', '8', '10'), to = c(rep('AD-L', 3)))
data$treat <- mapvalues(data$treat, from = c('3'), to = c('bg 1')) 
data$treat <- mapvalues(data$treat, from = c('7'), to = c('bg 2'))
data$treat <- mapvalues(data$treat, from = c('11'), to = c('bg 3'))
#assign replicate num
data$replicate <- data$id
data$replicate <- mapvalues(data$replicate, from = c('1', '2', '4' ), to = rep('1', 3))
data$replicate <- mapvalues(data$replicate, from = c('6', '8', '5' ), to = rep('2', 3))
data$replicate <- mapvalues(data$replicate, from = c('12', '9', '10' ), to = rep('3', 3))



# background data
data.bg <- data[data$treat == 'bg 1' | data$treat == 'bg 2'| data$treat == 'bg 3', ]

#tunnels data 
data <- data[data$treat == 'AD-LB1' | data$treat == 'AD-LB2'| data$treat == 'AD-L', ]

# calculating the average and sd of the 3 backgrounds
data.bg.summ <- ddply(data.bg, c('elapsed.time'), summarise, NH3.bg.mn = mean(NH3_30s), NH3.bg.sd = sd(NH3_30s))

# joining the datasets
data <- full_join(data.bg.summ, data, by = 'elapsed.time')
# Subtract the background values from the 30 second average values 
data$NH3.corr <- data$NH3_30s - data$NH3.bg.mn
data[!complete.cases(data),]
data <- na.omit(data) # remove NA points

#load the weather data from the weather station
weather <- read_csv('Blank')


# Convert d/m/y character strings to Date
weather$date <- dmy(weather$date)

# Check result
str(weather$date)

# Create datetime column combining date and time
weather$date.time.weather <- as.POSIXct(
  paste(weather$date, sprintf("%02d:00:00", weather$time)),
  format = "%Y-%m-%d %H:%M:%S",
  tz = "UTC"
)

# check if there is any Na value in the weather data

sum(is.na(weather$date.time.weather))

# round date.time in data to fit with weather
data$date.time.weather <- round_date(data$date.time, '1 hour')

# Join datasets
data <- left_join(data, weather, by = 'date.time.weather')

# Convert temperature from Celsius to Kelvin
data$temp.K <- data$air_temp_hour_mean_celsius + 273.15
#add the constants to calculate the flux
# constants:
p.con <- 1 # atm
R.con <- 0.082057338 # [L * atm * K^-1 * mol^-1]
A.frame <- 0.2 #m^2
M.N <- 14.0067 # g * mol^-1
air.flow <- 20.2 * 60 # L min^-1
# calculation of a concentration from ppb to mol * L^-1
data$n <- p.con / (R.con * data$temp.K) * data$NH3.corr * 10^-9  # mol * L^-1        
# calculation of flux, from mol * L^-1 to g.N * min^-1 * m^-2
data$flux <- (data$n * M.N * air.flow) / A.frame
# rearranging data by tunnel 
data <- arrange(data, by = id)

# Average ammonia flux in measurement interval
data$flux.tr <- rollapplyr(data$flux, 2, mean, fill = NA)
data$flux.tr[data$elapsed.time == 0] <- 0

data <- data[! data$flux.tr == 0, ]
data$elapsed.time<-as.numeric(data$elapsed.time)
data<-filter(data, elapsed.time<=140)

############# ALFAM2 TEMPLATE Emissions

data$project <- 'STABIL26'             
data$exp <- '8'                
data$field <- 'Foulumgård'       
data$plot.number <- paste(data$id, data$treat)
data$treatment <- data$treat
data$replicate.nu <- data$replicate

# rearanging data by tunnel 
data <- arrange(data, by = id)

data$id <- as.character(data$id)
data <- mutate(group_by(data, id), numbering = row_number())

data$start.date <- data$date.time
data$end.date <- data$date.time
data$end.date <- c(data$end.date[-1], data$end.date[nrow(data)]) 

# Convert character dates to POSIXct 
data$start.date <- as.POSIXct(data$start.date, format = "%Y-%m-%d %H:%M", tz = "UTC")
data$end.date <- as.POSIXct(data$end.date, format = "%Y-%m-%d %H:%M", tz = "UTC")

#  calculate shift time by tunnel
data <- data %>%
  group_by(id) %>%
  mutate(
    shift.length = as.numeric(difftime(end.date, start.date, units = "hours")),
    count = n()
  ) %>%
  ungroup()

data <- ddply(data, c('id'), filter, row_number() <= n()-1)



data$measuring.tech <- 'Wind tunnel'
data$details <- ''

data$detection.limit <- ''
data$bg.value <- data$NH3.bg.mn / 1000
data$bg.unit <- 'ppm'
data$Type <- 'Emission rate'
data$NH3.value <- data$flux.tr *10^-3 * 60 * 10^4 # from gN * min^-1 * m^-2 to kgN * h^-1 * ha^-1
data$NH3.unit <- 'kg N/ha-hr'
data$man.pH <- '' 
data$temp <- data$air_temp_hour_mean_celsius
data$air.height <- '2'
data$soil.tempA <- data$soil_temp_10cm_hour_mean_celsius
data$soil.depth <- '0.1'
data$soil.surface <- ''
data$soil.globa.rad <- data$global_radiation
data$WS <- ''
data$WS.height <- '2'
data$MO.lenght <- ''
data$Fric.vel <- ''
data$rough <- ''
data$airP.val <- data$air_pressure_hPa
data$airP.uni <- 'hPa'
data$air.rain <- "0"
data$rel.hum <- data$mean_relative_humidity
data$WS.loc <- ''
data$far.loc <- ''

#### write ##########################################

#cols_to_keep_emissions <- c("project", "exp", "field", "plot.number", "treatment", 
#"replicate.nu", "numbering", "start.date", "end.date",
#"shift.length", "measuring.tech", "details", "detection.limit",
#"bg.value", "bg.unit", "Type", "NH3.value", "NH3.unit",
#"man.pH", "temp", "air.height", "soil.tempA", "soil.depth",
#"soil.surface", "soil.globa.rad", "WS", "WS.height",
# "MO.lenght", "Fric.vel", "rough", "airP.val", "airP.uni",
#"air.rain", "rel.hum", "WS.loc", "far.loc")

#write_xlsx(data[, cols_to_keep_emissions], "../ALFAM2/emission_8.xlsx")





