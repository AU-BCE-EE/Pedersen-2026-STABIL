# sort out variables etc. for stats

# Extract slurry type and treatment
isumm <- isumm[!trial %in% paste('Trial', 7:9), ]
isumm[, slurry.type := substr(treat, 1, 2)]
isumm[, separation := fcase(
  grepl('-F$', treat), 'Solid',
  grepl('-L$', treat), 'Liquid',
  default = 'Unsep'
)]

# Set reference level
isumm[, separation := factor(separation)]
isumm[, separation := relevel(separation, ref = 'Unsep')]
