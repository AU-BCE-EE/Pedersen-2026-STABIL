
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

#Extract for the biochar with liquid fractions trials
bsumm <- isumm[!trial %in% paste('Trial', 1:7), ]
bsumm[, slurry.type := substr(treat, 1, 2)]
bsumm[, dose := fcase(
  grepl('-LB1$', treat), '0.02',
  grepl('-LB2$', treat), '0.1',
  default = '0'
)]

# Set dose numeric (0, 2, 10%)
bsumm[, dose := as.numeric(dose)]

#Extract for the biochar with the soild fraction trial
bsumm.solid <- isumm[trial %in% paste('Trial', 7), ]
bsumm.solid[, dose := fcase(
  grepl('-FB$', treat), '0.1',
  default = '0'
)]
# Set dose factor (we only have Biochar (10%) and no Biochar)
bsumm.solid[, dose := as.factor(dose)]



