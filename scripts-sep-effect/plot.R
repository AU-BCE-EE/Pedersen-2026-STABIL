
cols <- c(
  'Unseparated'  = 'darkgreen',
  'Scenario 1' = '#c6dbef',
  'Scenario 2' = '#9ecae1',
  'Scenario 3' = '#6baed6',
  'Scenario 4' = '#4292c6',
  'Scenario 5' = '#2171b5',
  'Scenario 6' = '#084594'
)

# ensuring correct order 
dfl$scenario<- factor(
  dfl$scenario,
  levels = c('Unseparated', paste0('Scenario ', 1:6))
)

ggplot(dfl, aes(x = interaction(new.ID, scenario, lex.order = TRUE), y = EF, fill = scenario)) +
  geom_col(width = 0.7) + 
  scale_fill_manual(values = cols) +
  labs(x = 'Trial', y = 'Ammonia emission (frac. TAN)') +
  theme_bw() +
  facet_wrap(~ new.ID, scales = 'free_x', ncol = 6) + 
  theme(legend.title = element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank(), 
        axis.title.x = element_blank())
ggsave2x('../plots/sep.scenarios', height = 4, width = 7)

