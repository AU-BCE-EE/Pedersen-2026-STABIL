# 
# # flux over time
# # all:
# ggplot(idat, aes(cta, j.NH3, group = pmid, color = treat)) +
#   geom_point() +
#   facet_wrap(~ trial, scales = 'free') +
#   theme_bw() +
#   labs(x = 'Time after application (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1'))) +
#   theme(legend.position = 'bottom', legend.title = element_blank())
# ggsave2x('../plots/NH3.flux01', height = 10, width = 10)


# Treatment names for publication purpose
treat1 <- c(
  `AD` =  'Unseparated digestate',
  `AD-F` =  'Digestate solid fraction',
  `AD-L` =  'Digestate liquid fraction',
  `PS` =  'Unseparated pig slurry',
  `PS-F` =  'Pig slurry solid fraction',
  `PS-L` =  'Pig slurry liquid fraction',
  `AD-FB` =  'Digestate solid with biochar (high)',
  `AD-LB1` =  'Digestate liquid with biochar (low)',
  `AD-LB2` =  'Digestate liquid with biochar (high)',
  `PS-LB1` =  'Pig slurry liquid with biochar (low)',
  `PS-LB2` =  'Pig slurry liquid with biochar (high)'
)

fsumm[, treat1 := treat1[treat]]

fsumm$material <- ifelse(fsumm$trial %in% c('Trial 1', 'Trial 3', 'Trial 5'), "Digestate",
                  ifelse(fsumm$trial %in% c('Trial 2', 'Trial 4', 'Trial 6'), "Pig slurry",
                  ifelse(fsumm$trial %in% c('Trial 7', 'Trial 8', 'Trial 9'), "Biochar trials", NA)))

fsumm1 <- fsumm[is.element(fsumm$trial, c('Trial 1', 'Trial 3', 'Trial 5')), ]
fsumm2 <- fsumm[is.element(fsumm$trial, c('Trial 2', 'Trial 4', 'Trial 6')), ]
fsumm3 <- fsumm[is.element(fsumm$trial, c('Trial 7', 'Trial 8', 'Trial 9')), ]

cols1 <- c(
  'Unseparated digestate' = 'darkgreen',
  'Digestate liquid fraction' = '#6baed6',
  'Digestate solid fraction' = '#fec44f'
)

cols2 <- c(
  'Unseparated pig slurry' = 'darkgreen',
  'Pig slurry liquid fraction' = '#6baed6',
  'Pig slurry solid fraction' = '#fec44f'
)

cols3 <- c(
  'Digestate solid fraction' = '#fec44f',
  'Digestate liquid fraction' = '#6baed6',
  'Pig slurry liquid fraction' = '#6baed6',
  'Digestate solid with biochar (high)' = '#990000',
  'Digestate liquid with biochar (low)' = '#ff6666',
  'Digestate liquid with biochar (high)' = '#990000',
  'Pig slurry liquid with biochar (low)' = '#ff6666',
  'Pig slurry liquid with biochar (high)' = '#990000'
)

f11 <- ggplot(fsumm1, aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols1) +
  scale_fill_manual(values = cols1) +
  xlim(NA, 50)

f22 <- ggplot(fsumm2, aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols2) +
  scale_fill_manual(values = cols2) +
  xlim(NA, 50)

f331 <- ggplot(fsumm3[fsumm3$trial == 'Trial 7', ], aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols3) +
  scale_fill_manual(values = cols3) +
  xlim(NA, 50)

f332 <- ggplot(fsumm3[fsumm3$trial == 'Trial 8', ], aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols3) +
  scale_fill_manual(values = cols3) +
  xlim(NA, 50)

f333 <- ggplot(fsumm3[fsumm3$trial == 'Trial 9', ], aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols3) +
  scale_fill_manual(values = cols3) +
  xlim(NA, 50)

bottom <- (f331 | f332 | f333) +
  plot_layout(guides = "collect") &
  theme(
    legend.position = "bottom",
    legend.key.size = unit(0.4, "lines"),      # shrink legend keys
    legend.spacing.y = unit(0.1, "lines")
  ) &
  guides(colour = guide_legend(nrow = 3, byrow = TRUE))

main_plots <- (f11 / f22 / bottom) +
  plot_layout(
    heights = c(1, 1, 1),    # All three rows get equal panel height
    guides = "collect"       # Ensure only one legend
  )


yaxis_label <- ggplot() + 
  theme_void() +
  ylab(expression(paste("Flux (frac. TAN  ", h^-1, ")"))) +
  theme(
    axis.title.y = element_text(angle = 90, margin = margin (r = 2))
  )

pff <- yaxis_label + (f11 / f22 / bottom) + plot_layout(widths = c(0.01, 0.95))
ggsave2x('../plots/NH3.flux.comm.50', plot = pff, height = 10, width = 8)




f1 <- ggplot(fsumm1, aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols1) +
  scale_fill_manual(values = cols1) 

f2 <- ggplot(fsumm2, aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols2) +
  scale_fill_manual(values = cols2) 

f31 <- ggplot(fsumm3[fsumm3$trial == 'Trial 7', ], aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols3) +
  scale_fill_manual(values = cols3) 

f32 <- ggplot(fsumm3[fsumm3$trial == 'Trial 8', ], aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_color_manual(values = cols3) +
  scale_fill_manual(values = cols3) 

f33 <- ggplot(fsumm3[fsumm3$trial == 'Trial 9', ], aes(cta, j.rel.mn, color = treat1, fill = treat1)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ trial, ncol = 3, scales = 'free_y') +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat1), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  theme(axis.title.y = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) + 
  scale_color_manual(values = cols3) +
  scale_fill_manual(values = cols3) 

bottom <- (f31 | f32 | f33) +
  plot_layout(guides = "collect") &
  theme(
    legend.position = "bottom",
    legend.key.size = unit(0.4, "lines"),      # shrink legend keys
    legend.spacing.y = unit(0.1, "lines")
  ) &
  guides(colour = guide_legend(nrow = 3, byrow = TRUE))

main_plots <- (f1 / f2 / bottom) +
  plot_layout(
    heights = c(1, 1, 1),    # All three rows get equal panel height
    guides = "collect"       # Ensure only one legend
  )

yaxis_label <- ggplot() + 
  theme_void() +
  ylab(expression(paste("Flux (frac. TAN  ", h^-1, ")"))) +
  theme(
    axis.title.y = element_text(angle = 90, margin = margin (r = 2))
  )

pff <- yaxis_label + (f1 / f2 / bottom) + plot_layout(widths = c(0.01, 0.95))
ggsave2x('../plots/NH3.flux.comm.135', plot = pff, height = 10, width = 8)


######### CUMULATIVE EMISSION

# cumulative emission 
ggplot(isumm, aes(treat, e.rel.130, color = treat)) + 
  geom_point() + 
  facet_wrap(~ trial, scales = 'free_x') + 
  theme_bw() + 
  labs(y = 'Loss (frac. of TAN)') + 
  theme(legend.title = element_blank()) + 
  geom_boxplot(data = esumm, aes(x = treat, y = e.rel.130, color = treat), show.legend = FALSE)
ggsave2x('../plots/cum.emis01', height = 10, width = 10)

######### temperature

idat_sub <- idat[idat$rep == '1', ]
idat_first <- do.call(rbind, lapply(split(idat_sub, idat_sub$trial), function(df) {
  df[df$pmid == df$pmid[1], ] 
}))

ggplot(idat_first, 
       aes(cta, air.temp, group = pmid)) + 
  geom_line() + 
  facet_wrap(~ trial, scales = 'free_x') +
  theme_bw() + 
  labs(x = 'Time after application (h)', y = 'Air temperature (°C)') + 
  theme(legend.position = 'bottom', legend.title = element_blank()) 
ggsave2x('../plots/temp', height = 10, width = 10)
