# create a 'component' and 'scenario_base' column for plotting
dfl$component <- ifelse(dfl$scenario == "Unseparated", "Unseparated",
  ifelse(grepl("^S ", dfl$scenario), "S", "L"))

dfl$component[dfl$component == "S"] <- "Solid fraction"
dfl$component[dfl$component == "L"] <- "Liquid fraction"


dfl$scenario_base <- as.factor(ifelse(dfl$scenario == "Unseparated", "Unseparated",
  sub("^[SL] ", "", dfl$scenario)))

dfl$component <- factor(dfl$component,
  levels = c("Unseparated", "Solid fraction", "Liquid fraction"))

cols <- c(
  "Unseparated" = "darkgreen",
  "Liquid fraction" = "#6baed6",
  "Solid fraction" = "#fec44f"
)


dfl$x_id <- factor(dfl$scenario_base, levels = c("Unseparated", 'Scenario 2', 'Scenario 1', 'Scenario 3'))

dfl$x_plot <- interaction(dfl$trial, dfl$x_id, lex.order = TRUE)


# dataframe for errorbars
df_err <- dw_total
names(df_err)[names(df_err) == "Scenario 1"] <- "Scenario_1"
names(df_err)[names(df_err) == "Scenario 3"] <- "Scenario_3"
df_err$x_plot <- paste0(df_err$trial, ".Scenario 2")

# changing order of facets
dfl$trial   <- factor(dfl$trial, levels = c('Trial 1', 'Trial 3', 'Trial 5', 'Trial 2', 'Trial 4', 'Trial 6'))
df_err$trial <- factor(df_err$trial, levels = c('Trial 1', 'Trial 3', 'Trial 5', 'Trial 2', 'Trial 4', 'Trial 6'))

# Adding additional grouping variable after 'material'
dfl$material <- ifelse(dfl$trial %in% c('Trial 1', 'Trial 3', 'Trial 5'), "Pig slurry", "Digestate")

df_err$material <- ifelse(df_err$trial %in% c('Trial 1', 'Trial 3', 'Trial 5'), "Pig slurry", "Digestate")

dfl$material    <- factor(dfl$material, levels = c("Pig slurry", "Digestate"))
df_err$material <- factor(df_err$material, levels = c("Pig slurry", "Digestate"))

ggplot(dfl[dfl$scenario_base == 'Unseparated' | dfl$scenario_base == 'Scenario 2', ], aes(x = x_plot, y = EF, fill = component)) +
  geom_col(width = 0.7) +
  geom_errorbar(data = df_err, aes(x = x_plot, ymin = Scenario_1, ymax = Scenario_3), width = 0.25, inherit.aes = FALSE) +
  scale_fill_manual(values = cols) +
  labs(y = "Ammonia emission (frac. TAN)") +
  theme_bw() +
  facet_nested(~ material + trial, scales = "free_x", space = 'free_x') +
  theme(legend.title = element_blank(), legend.position = 'bottom',
  axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.text.x = element_blank()) +
  scale_fill_manual(values = cols) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)))
ggsave2x('../plots/sep.scenarios', height = 3.5, width = 6)




