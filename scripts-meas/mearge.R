
# Merge in plot level variables
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

setDT(idat)

