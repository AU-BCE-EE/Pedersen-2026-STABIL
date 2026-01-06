
df <- read.xlsx('../auxiliary-data/surface-pH.xlsx')
setDT(df)

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

df[, new.ID := IDs[trial]]
