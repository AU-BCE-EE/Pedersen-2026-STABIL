
# calculating the emission from solid and liquid fractoin taking the separation efficiencies into account 

# Separation efficiencies (% TAN in the liquid and solid fraction as relative to raw (unseparated))
# Scenario	Liquid frac. TAN%  Solid frac. TAN
# 1	        99	               1
# 2	        95	               5
# 3	        90	               10
# 4	        85	               15
# 5	        80	               20
# 6	        75	               25


w <- c(0.01, 0.05, 0.10, 0.15, 0.20, 0.25)

weighted_matrix <- sapply(w, function(wi) {
  dw$liquid * (1 - wi) + dw$solid * wi})

# Assign column names
colnames(weighted_matrix) <- paste0('Scenario ', seq_along(w))

# Combine with dw
dw <- cbind(dw, weighted_matrix)

# long format for plotting: 
dfl <- melt(
  dw,
  id.vars = 'new.ID',
  measure.vars = c('Unseparated', paste0('Scenario ', 1:6)),
  variable.name = 'scenario',
  value.name = 'EF'
)
