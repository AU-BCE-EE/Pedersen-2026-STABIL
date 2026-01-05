
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
  levels = c("Unseparated", paste0("L Scenario ", 1:6), paste0("S Scenario ", 1:6)))

cols <- c(
  "Unseparated" = "darkgreen",
  "L Scenario 1" = "#c6dbef",
  "L Scenario 2" = "#9ecae1",
  "L Scenario 3" = "#6baed6",
  "L Scenario 4" = "#4292c6",
  "L Scenario 5" = "#2171b5",
  "L Scenario 6" = "#084594",
  "S Scenario 1" = "#fff7bc",
  "S Scenario 2" = "#fee391",
  "S Scenario 3" = "#fec44f",
  "S Scenario 4" = "#fe9929",
  "S Scenario 5" = "#ec7014",
  "S Scenario 6" = "#cc4c02"
)


dfl$x_id <- factor(dfl$scenario_base, levels = c("Unseparated", paste0("Scenario ", 1:6)))

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
    axis.ticks.x = element_blank(), axis.title.x = element_blank()) + 
  scale_x_discrete(labels = function(x) {ifelse(grepl("Unseparated$", x), "", sub(".*Scenario ", "", x))}) + 
  scale_fill_manual(values = cols, breaks = c("Unseparated", "L Scenario 3", "S Scenario 3"), labels = c("Unseparated", "Liquid fraction", "Solid fraction")) + 
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)))
ggsave2x('../plots/sep.scenarios', height = 5, width = 8)
