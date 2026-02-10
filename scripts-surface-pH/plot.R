
df.summx <- df.summ[df.summ$cover == 'covered', ]

df.summx <- df.summx[
  treat != "Solid fraction" &
    (new.ID == "Trial 1" |
       new.ID == "Trial 2" |
       new.ID == "Trial 3" |
       new.ID == "Trial 4" |
       new.ID == "Trial 5" |
       new.ID == "Trial 6")]


# Adding additional grouping variable after 'material'
df.summx$material <- ifelse(df.summx$new.ID %in% c('Trial 1', 'Trial 3', 'Trial 5'), "Digestate", "Pig slurry")

df.summ1 <- df.summx[is.element(df.summx$new.ID, c('Trial 1', 'Trial 3', 'Trial 5')), ]
df.summ2 <- df.summx[is.element(df.summx$new.ID, c('Trial 2', 'Trial 4', 'Trial 6')), ]

df.summ1[df.summ1$treat == 'Liquid fraction', ]$treat <- 'Digestate liquid fraction'
df.summ1[df.summ1$treat == 'Unseparated', ]$treat <- 'Unseparated digestate'
df.summ2[df.summ2$treat == 'Liquid fraction', ]$treat <- 'Pig slurry liquid fraction'
df.summ2[df.summ2$treat == 'Unseparated', ]$treat <- 'Unseparated pig slurry'

cols1 <- c(
  'Unseparated digestate' = 'darkgreen',
  'Digestate liquid fraction' = '#6baed6')

cols2 <- c(
  'Unseparated pig slurry' = 'darkgreen',
  'Pig slurry liquid fraction' = '#6baed6')


f11 <- ggplot(df.summ1, aes(elapsed.time, pH.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_nested(~ material + new.ID) +
  theme_bw() + 
  geom_ribbon(aes (ymax = pH.mn + pH.sd, ymin = pH.mn - pH.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab('pH') + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols1) +
  scale_fill_manual(values = cols1)

f22 <- ggplot(df.summ2, aes(elapsed.time, pH.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_nested(~ material + new.ID) +
  theme_bw() + 
  geom_ribbon(aes (ymax = pH.mn + pH.sd, ymin = pH.mn - pH.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab('pH') + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols2) +
  scale_fill_manual(values = cols2)


mat <- matrix(c(1, 
                2),
              ncol = 1)

pff <- grid.arrange(f11, f22, layout_matrix = mat)
ggsave2x('../plots/surface.pH', plot = pff, height = 6, width = 8)
