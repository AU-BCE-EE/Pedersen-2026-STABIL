

ggplot(df.summ[df.summ$cover == 'covered', ], aes(elapsed.time, pH.mn, color = treat)) + 
  geom_point() + 
  geom_line() + 
  facet_wrap(~ new.ID, scales = 'free_x')
