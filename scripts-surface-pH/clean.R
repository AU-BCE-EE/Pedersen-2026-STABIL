
# dates
df$date <- as.POSIXct(as.character(df$date), format = "%y%m%d", tz = "UTC")

# times
df$time <- gsub("\\.", ":", df$time)

df[, time := {
  x <- trimws(time)
  x <- sub("^([0-9]{1,2}):([0-9]{2}).*$", "\\1:\\2", x)
  x <- ifelse(grepl("^\\d{2}$", x),
              paste0(x, ":00:00"), x)
  
  x <- ifelse(grepl("^\\d{2}:\\d{1}$", x),
              sub("^(\\d{2}):(\\d)$", "\\1:0\\2:00", x), x)
  
  x <- ifelse(grepl("^\\d{1}:\\d{2}$", x),
              sub("^(\\d):(\\d{2})$", "0\\1:\\2:00", x), x)
  
  x <- ifelse(grepl("^\\d{2}:\\d{2}$", x),
              paste0(x, ":00"), x)
  
  x
}]

# date.time
df$date.time <- as.POSIXct(paste(df$date, df$time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

# 

map <- c(
  "unseparated" = "Unseparated",
  "raw" = "Unseparated",
  "PM" = "Unseparated",
  "Digested" = "Unseparated",
  "Digested " = "Unseparated",
  "separated" = "Liquid fraction",
  "Separated" = "Liquid fraction",
  "PM_LiqFrac" = "Liquid fraction",
  "afgassetvæ" = "Liquid fraction",
  "separated " = "Liquid fraction",
  "Digested liquid" = "Liquid fraction",
  "Bclow" = "Liquid fraction with biochar (low)",
  "BClow" = "Liquid fraction with biochar (low)",
  "Bchigh" = "Liquid fraction with biochar (high)",
  "BChigh" = "Liquid fraction with biochar (high)",
  "fiber" = "Solid fraction",
  "Fiber" = "Solid fraction",
  "fiber " = "Solid fraction",
  "Fiber " = "Solid fraction",
  "Fiber_pig" = "Solid fraction",
  "Fiber med kul" = "Solid fraction with biochar (high)",
  "Jord" = "Soil"
)

df[treat %chin% names(map), treat := map[treat]]
