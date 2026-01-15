
# Read Excel file, skip first row

data_slurry <- read_excel("../auxiliary-data/slurry properties.xlsx", 
                   skip = 1)
data_soil <- read_excel("../auxiliary-data/Soil properties.xlsx", 
                   skip = 1)

setDT(data_slurry)
setDT(data_soil)

# New IDs for publication purpose
IDs <- c(`1` =  'Trial 1',
         `2` =  'Trial 3',
         `3` =  'Trial 5',
         `4` =  'Trial 2',
         `5` =  'Trial 4',
         `6` =  'Trial 6',
         `7` =  'Trial 7',
         `8` =  'Trial 8',
         `9` =  'Trial 9')

data_slurry[, new.ID := IDs[experiment]]
data_soil[, new.ID := IDs[experiment]]
