rm(list = ls())

source('functions.R')
source('packages.R')
source('load.R')
source('clean.R')
source('summary.R')
source('plot.R')



ggplot(df.summ[df.summ$cover == 'covered', ], aes(elapsed.time, pH.mn, color = treat)) + 
  geom_point() + 
  geom_line() + 
  facet_wrap(~ new.ID, scales = 'free_x')