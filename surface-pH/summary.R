
# Summarizes measurements
df.summ <- df[, .(pH.mn  = mean(pH), 
                  pH.sd = sd(pH))
              , by = list(new.ID, treat, date.time, cover)]

# elapsed.time
df.summ[, elapsed.time := difftime(date.time, min(date.time), units = "hours"), by = .(new.ID, treat)]
