
write.csv(pdat, '../output/pdat.csv', row.names = FALSE)
write.csv(idat, '../output/idat.csv', row.names = FALSE)
write.csv(wsumm, '../output/temp.csv', row.names = FALSE)


esumm$cum.emis.mn <- paste(esumm$e.rel.135, ' ± ', esumm$e.rel.135.sd)

# Select some cols from esumm to export
esumm <- esumm[ , c('new.ID', 'treat', 'cum.emis.mn', 'e.rel.135.n')] 

# tables with cumulative emission 
write.csv(esumm, '../output/cum.emis.csv', row.names = FALSE)
