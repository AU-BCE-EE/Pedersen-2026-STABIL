
write.csv(dw, '../output/sep.scenarioes1.csv', row.names = FALSE)
write.csv(dw_total, '../output/sep.scenarioes2.csv', row.names = FALSE)

# combining files: 
dww <- cbind(dw_total[, c('new.ID', 'Unseparated', 'Scenario 1')], dw[, c('L Scenario 1', 'S Scenario 1')], 
             dw_total[, c('Scenario 2')], dw[, c('L Scenario 2', 'S Scenario 2')], 
             dw_total[, c('Scenario 3')], dw[, c('L Scenario 3', 'S Scenario 3')])

write.csv(dww, '../output/sep.scenarios.csv', row.names = FALSE)
