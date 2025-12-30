
# flux over time
# all:
ggplot(idat, aes(cta, j.NH3, group = pmid, color = treat)) +
  geom_point() +
  facet_wrap(~ new.ID, scales = 'free') +
  theme_bw() +
  labs(x = 'Time after application (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1'))) +
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots/NH3.flux01', height = 10, width = 10)


fsumm1 <- fsumm[fsumm$new.ID == c('1', '3', '5'), ]
fsumm2 <- fsumm[fsumm$new.ID == c('2', '4', '6'), ]
fsumm3 <- fsumm[fsumm$new.ID == c('7', '8', '9'), ]

f1 <- ggplot(fsumm1, aes(cta, j.rel.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3) +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) 

f11 <- ggplot(fsumm1, aes(cta, j.rel.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3) +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  xlim(NA, 50)

f2 <- ggplot(fsumm2, aes(cta, j.rel.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3) +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) 

f22 <- ggplot(fsumm2, aes(cta, j.rel.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3) +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  xlim(NA, 50)

f3 <- ggplot(fsumm3, aes(cta, j.rel.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3) +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) 

f33 <- ggplot(fsumm3, aes(cta, j.rel.mn, color = treat, fill = treat)) + 
  geom_point(shape = 1, size = 0.5) + 
  geom_line() + 
  facet_wrap(~ new.ID, ncol = 3) +
  theme_bw() + 
  geom_ribbon(aes (ymax = j.rel.mn + j.rel.sd, ymin = j.rel.mn - j.rel.sd, group = treat), alpha = 0.3, color = NA) + 
  ylab(expression(paste('Flux (frac. TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.position = 'bottom', legend.title = element_blank()) +
  guides(colour = guide_legend(nrow = 1, byrow = TRUE)) +
  xlim(NA, 50)

mat <- matrix(c(1, 1, 1,
                2, 2, 2,
                3, 3, 3),
              ncol = 1)

pff <- grid.arrange(f1, f2, f3, layout_matrix = mat)
ggsave2x('../plots/NH3.flux.comm.150', plot = pff, height = 10, width = 8)

mat <- matrix(c(1, 1, 1,
                2, 2, 2,
                3, 3, 3),
              ncol = 1)

pfff <- grid.arrange(f11, f22, f33, layout_matrix = mat)
ggsave2x('../plots/NH3.flux.comm.50', plot = pfff, height = 10, width = 8)


######### CUMULATIVE EMISSION

# cumulative emission 
ggplot(isumm, aes(treat, e.rel.135, color = treat)) + 
  geom_point() + 
  facet_wrap(~ new.ID, scales = 'free_x') + 
  theme_bw() + 
  labs(y = 'Loss (frac. of TAN)') + 
  theme(legend.title = element_blank()) + 
  geom_boxplot(data = esumm, aes(x = treat, y = e.rel.135, color = treat), show.legend = FALSE)
ggsave2x('../plots/cum.emis01', height = 10, width = 10)

# ############################################################################

# temperature # FIX SO THERE IS ONLY ONE LINE PR TRIAL
ggplot(idat[idat$rep == '1', ], 
       aes(cta, air.temp, group = pmid)) + 
  geom_line() + 
  facet_wrap(~ new.ID, scales = 'free_x') +
  theme_bw() + 
  labs(x = 'Time after application (h)', y = 'Air temperature (°C)') + 
  theme(legend.position = 'bottom', legend.title = element_blank()) 
ggsave2x('../plots/temp', height = 10, width = 10)
