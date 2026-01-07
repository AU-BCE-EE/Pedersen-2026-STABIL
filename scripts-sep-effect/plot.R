
# create a 'component' and 'scenario_base' column for plotting
dfl$component <- ifelse(dfl$scenario == "Unseparated", "Unseparated",
  ifelse(grepl("^S ", dfl$scenario), "S", "L"))

dfl$scenario_base <- ifelse(dfl$scenario == "Unseparated", "Unseparated",
  sub("^[SL] ", "", dfl$scenario))

dfl$component <- factor(dfl$component, levels = c("Unseparated", "L", "S"))

# crease fill_id
dfl$fill_id <- NA_character_
dfl$fill_id[dfl$scenario_base == "Unseparated"] <- "Unseparated"
dfl$fill_id[dfl$component == "L"] <- paste0("L ", dfl$scenario_base[dfl$component == "L"])
dfl$fill_id[dfl$component == "S"] <- paste0("S ", dfl$scenario_base[dfl$component == "S"])


dfl$fill_id <- factor(dfl$fill_id,
  levels = c("Unseparated", paste0("L Scenario ", 1:3), paste0("S Scenario ", 1:3)))

cols <- c(
  "Unseparated" = "darkgreen",
  "L Scenario 2" = "#6baed6",
  "L Scenario 1" = "#c6dbef",
  "L Scenario 3" = "#c6dbef",
  "S Scenario 2" = "#fec44f",
  "S Scenario 1" = "#fff7bc",
  "S Scenario 3" = "#fff7bc"
)


dfl$x_id <- factor(dfl$scenario_base, levels = c("Unseparated", 'Scenario 2', 'Scenario 1', 'Scenario 3'))

dfl$x_plot <- interaction(dfl$new.ID, dfl$x_id, lex.order = TRUE)

dfl$trial_num <- as.numeric(sub("Scenario ", "", dfl$scenario_base))

# Extract trial number from scenario_base
dfl$trial_num <- as.numeric(sub("Scenario ", "", dfl$scenario_base))


ggplot(dfl, aes(x = x_plot, y = EF, fill = fill_id)) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = cols) +
  labs(y = "Ammonia emission (frac. TAN)") +
  theme_bw() +
  facet_grid( ~ new.ID, scales = "free_x") +
  theme(legend.title = element_blank(), legend.position = 'bottom', 
    axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) + 
  scale_x_discrete(labels = c('', 'Average', 'High', 'Low')) + 
  scale_fill_manual(values = cols, breaks = c("Unseparated", "L Scenario 2", "S Scenario 2"), labels = c("Unseparated", "Liquid fraction", "Solid fraction")) + 
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)))
ggsave2x('../plots/sep.scenarios', height = 3.5, width = 6)
