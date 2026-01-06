

df.summ1 <- df.summ[! df.summ$treat == 'Solid fraction', ]
df.summ1 <- df.summ[! df.summ$treat == 'Solid fraction with biochar (high)', ]

ggplot(df.summ[df.summ$cover == 'covered', ], aes(elapsed.time, pH.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = pH.mn + pH.sd, ymin = pH.mn - pH.sd, group = treat), alpha = 0.1, color = NA)
