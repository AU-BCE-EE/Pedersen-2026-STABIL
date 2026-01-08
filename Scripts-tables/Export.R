# Save to Excel
write_xlsx(summary_table_slurry, "../output/slurry_prop_summary_table.xlsx")
write_xlsx(summary_table_soil, "../output/soil_prop_summary_table.xlsx")
getwd()
View(summary_table_slurry)
