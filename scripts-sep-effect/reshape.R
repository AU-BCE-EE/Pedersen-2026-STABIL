

# selecting relevant rows and trials
df <- df[, c('trial', 'treat', 'e.rel.130')]
df <- df[!(trial == 'Trial 7' | trial == 'Trial 8' | trial == 'Trial 9')]


df[, form := fcase(
  treat == 'AD'   | treat == 'PS',   'Unseparated',
  treat == 'AD-L' | treat == 'PS-L', 'liquid',
  treat == 'AD-F' | treat == 'PS-F', 'solid'
)]


dw <- dcast(
  df,
  trial~ form,
  value.var = c('e.rel.130')
)
