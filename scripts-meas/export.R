
write.csv(pdat, '../output/pdat.csv', row.names = FALSE)
write.csv(idat, '../output/idat.csv', row.names = FALSE)
write.csv(wsumm, '../output/temp.csv', row.names = FALSE)


esumm$cum.emis.mn <- paste(esumm$e.rel.130, ' ± ', esumm$e.rel.130.sd)

# Select some cols from esumm to export
esummA <- esumm[ , c('new.ID', 'treat', 'cum.emis.mn', 'e.rel.130.n')] 

# tables with cumulative emission 
write.csv(esummA, '../output/cum.emis.csv', row.names = FALSE)
