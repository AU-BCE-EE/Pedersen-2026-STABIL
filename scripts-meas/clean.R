
# Extract slurry type and treatment
statsumm <- isumm[!trial %in% paste('Trial', 7:9), ]
statsumm[, slurry.type := substr(treat, 1, 2)]
statsumm[, separation := fcase(
  grepl('-F$', treat), 'Solid',
  grepl('-L$', treat), 'Liquid',
  default = 'Unsep'
)]

# Set reference level
statsumm[, separation := factor(separation)]
statsumm[, separation := relevel(separation, ref = 'Unsep')]

