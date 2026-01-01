
# a lot of times are slighly shiftet, uniforming across trials to be able to calculate average emissions 

# 
# idat[, cta := {
#   ref <- cta[pid == min(pid)]
#   rep(ref, length.out = .N)
# }, by = new.ID]
# 
# 
# unique(idat$cta)



##

setorder(idat, new.ID, pid, cta)

idat[, t_index := seq_len(.N), by = .(new.ID, pid)]
idat[, cta := mean(cta), by = .(new.ID, t_index)]
idat[, cta := round(cta, 2)]
