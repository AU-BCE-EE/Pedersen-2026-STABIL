
# subsetting data from the MAG project
pdat <- subset(pdat, proj == 'STABIL26')

# Drop non-relevant obs from emis interval data
idat <- subset(idat, pmid %in% unique(pdat$pmid))

