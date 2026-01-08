
data_soil$experiment<-as.character(data_soil$experiment)
# Create summary table grouped by experiment
summary_table_soil <- data_soil %>%
  group_by(experiment) %>%
  summarise(
    pH = paste0(round(mean(pH, na.rm = TRUE), 2), 
                " ± ", 
                round(sd(pH, na.rm = TRUE), 2)),
    Water = paste0(round(mean(W, na.rm = TRUE), 2), 
                " ± ", 
                round(sd(W, na.rm = TRUE), 2)),
    "Bulk density"= paste0(round(mean(bulk.dens, na.rm = TRUE), 2), 
               " ± ", 
               round(sd(bulk.dens, na.rm = TRUE), 2)),
    
    .groups = 'drop'
  ) %>%add_row(experiment = "", pH = "", Water = "g/g", "Bulk density"="g/cm3" ,.before = 1)