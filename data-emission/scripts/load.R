
# Data not yet released, reading from the following commit: 

idat <- fread('https://raw.githubusercontent.com/AU-BCE-EE/ALFAM2-data/ffc0aae283f775e278924e37338324d34d29c7f2/data-output/03/ALFAM2_interval.csv.gz')

pdat <- fread('https://raw.githubusercontent.com/AU-BCE-EE/ALFAM2-data/8073f961ce3bd716981430d37251de0d4349a5dc/data-output/03/ALFAM2_plot.csv.gz')

pdat.new <- fread('https://raw.githubusercontent.com/AU-BCE-EE/ALFAM2-data/ffc0aae283f775e278924e37338324d34d29c7f2/data-output/03/ALFAM2_plot.csv.gz')

# checking if pdat.new (latest ALFAM2 database commit) has STABIL data
test <- subset(pdat.new, proj == 'STABIL26')


