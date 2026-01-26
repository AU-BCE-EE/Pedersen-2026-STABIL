
# calculating the emission from solid and liquid fractoin taking the separation efficiencies into account 

# Separation efficiencies (% TAN in the liquid and solid fraction as relative to raw (unseparated))
# Scenario	Liquid frac. TAN%  Solid frac. TAN
# 1	        99	               1
# 2	        95	               5
# 3	        90	               10
# 4	        85	               15
# 5	        80	               20
# 6	        75	               25


w <- c(0.01, 0.10, 0.25)

# caculate total emission (liquid + solid) and for liquid and solid separately:
weighted_matrix <- sapply(w, function(wi) {dw$liquid * (1 - wi) + dw$solid * wi})
weighted_matrix_L <- sapply(w, function(wi) {dw$liquid * (1 - wi)})
weighted_matrix_S <- sapply(w, function(wi) {dw$solid * wi})

# Assign column names
colnames(weighted_matrix) <- paste0('Scenario ', seq_along(w))
colnames(weighted_matrix_L) <- paste0('L Scenario ', seq_along(w))
colnames(weighted_matrix_S) <- paste0('S Scenario ', seq_along(w))

# Combine with dw
dw_total <- cbind(dw, weighted_matrix)
dw <- cbind(dw, weighted_matrix_L, weighted_matrix_S)

# long format for plotting: 
dfl <- melt(
  dw,
  id.vars = 'trial',
  measure.vars = c('Unseparated', paste0('S Scenario ', 1:3), paste0('L Scenario ', 1:3)),
  variable.name = 'scenario',
  value.name = 'EF'
)
