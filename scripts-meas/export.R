
write.csv(pdat, '../output/pdat.csv', row.names = FALSE)
write.csv(idat, '../output/idat.csv', row.names = FALSE)
write.csv(wsumm, '../output/temp.csv', row.names = FALSE)
write.csv(esumm, '../output/esumm.csv', row.names = FALSE)

esumm$cum.emis.mn <- paste(esumm$e.rel.130, ' ± ', esumm$e.rel.130.sd)

# Select some cols from esumm to export
esummA <- esumm[ , c('trial', 'treat', 'cum.emis.mn', 'e.rel.130.n')] 

# tables with cumulative emission 
write.csv(esummA, '../output/cum.emis.csv', row.names = FALSE)


# table with cumulative emissions for each plot (for stats)

write.csv(isumm[, c('trial', 'treat', 'e.rel.130')], '../output/cum.emis.stats.csv', row.names = FALSE)
