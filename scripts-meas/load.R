
idat <- fread('../data-emission/data/MAG_interval.csv')
pdat <- fread('../data-emission/data/MAG_plot.csv')

# New IDs for publication purpose
IDs <- c(`1` =  '1',
         `2` =  '3',
         `3` =  '5',
         `4` =  '2',
         `5` =  '4',
         `6` =  '6',
         `7` =  '7',
         `8` =  '8',
         `9` =  '9')

pdat[, new.ID := IDs[exper]]