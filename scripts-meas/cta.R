
# a lot of times are slighly shiftet, uniforming across trials to be able to calculate average emissions 


idat[, cta := {
  ref <- cta[pid == min(pid)]
  rep(ref, length.out = .N)
}, by = new.ID]
