

# selecting relevant rows and trials
df <- df[, c('new.ID', 'treat', 'e.rel.130')]
df <- df[!(new.ID == 'Trial 7' | new.ID == 'Trial 8' | new.ID == 'Trial 9')]


df[, form := fcase(
  treat == 'AD'   | treat == 'PS',   'Unseparated',
  treat == 'AD-L' | treat == 'PS-L', 'liquid',
  treat == 'AD-F' | treat == 'PS-F', 'solid'
)]


dw <- dcast(
  df,
  new.ID ~ form,
  value.var = c('e.rel.130')
)
