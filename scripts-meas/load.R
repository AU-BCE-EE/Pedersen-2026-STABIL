
idat <- fread('../data-emission/data/MAG_interval.csv')
pdat <- fread('../data-emission/data/MAG_plot.csv')

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

pdat[, trial := IDs[exper]]
