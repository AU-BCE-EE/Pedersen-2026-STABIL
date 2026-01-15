# Fix cumulative time
# A lot of times are slighly shifted
# Here we align across trials to be able to calculate average emissions 

setorder(idat, trial, pid, cta)

idat[, t_index := seq_len(.N), by = .(trial, pid)]
idat[, cta := mean(cta), by = .(trial, t_index)]
idat[, cta := round(cta, 2)]
