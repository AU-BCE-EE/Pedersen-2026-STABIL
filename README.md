# Pedersen-2026-STABIL
Repository contains data and scripts related to a manuscript presenting NH3 application and associated data from the STABIL project.

Manuscript: J. Pedersen, A. H. Støckler, F. D. Pierre, S. D. Hafner, A. Feilberg, J. N. Kamp. Effects of separation and biochar addition on ammonia emission from field-applied liquid animal manure. Manuscript in preparation, April 2026. 

# Maintainer
Johanna Pedersen. Contact information here: https://www.researchgate.net/profile/Johanna-Pedersen 

# Overview
This repo contains (nearly) all the data and data processing scripts for NH3 emission after application experiments conducted within the STABIL project. 
The scripts run in R (<https://www.r-project.org/>) and require several add-on packages.
These packages are listed in multiple `packages.R` in `script-*` directories.
Versions of R and packages can be found in `logs/R-versions-*.txt` files.

Scripts for calculation of emission data from raw dynamic flux chamber measurements are included, but data files are too large and are not included. 
However all resulting emission measurements can be found in `data-emission`.
These data in `data-emission` are from the ALFAM2 database, and were used for all plots and analyses.

# Repo overview for folders with R scripts
See `scripts` for R scripts. 
`main.R` calls the other to do the complete data loading, subsetting, calculations, plotting, saving of data (in `output` subdirectory) and plots (in `plots` subdirectory). 

# Directory structure

## `auxillary-data`
Slurry and soil properties and slurry surface pH after application. 

## `data-emission`
Measurement data in `data` subdirectory.
These are downloaded from a specific release (based on tag) from ALFAM2-data repo on GitHub (<github.com/sashahafner/ALFAM2-data/>).
(Version is given in `data-emission/scripts/load.R` and `data-emission/logs/data_version.txt`, which was downloaded from the ALFAM2-data repo.)
See `data-emission/scripts` for R scripts for downloading data.
`main.R` calls the others to do the complete dataload, subsetting, and save.

## `functions`
R functions used by various scripts. 

## `logs`
Logs of R package versions, parameter values, and more to try to ensure reproducibility.

## `output`
Output summaries and similar files.

## `plots`
Plots produced by scripts in `scripts-meas` of ammonia flux over time, cumulative emission, aggregated emission in separation scenarios, slurry surface pH after application of unseparated and liquid fractions, temperature during the trials. 

## `scripts-ALFAM2-submission`
R scripts for processing wind tunnel data to calculate measured ammonia emission. 
Data files are too large to include but scripts are still included here for partial reproducibility.
The script `main.R` calls all others. 

## `scripts-meas`
R scripts for working with emission measurements and producing plots.
The script `main.R` calls all others.
Plots can be found in `plots` and table with cumulative emission can be found in `output`. 

## `scripts-sep-effect`
R scripts for calculating aggregated emissions from liquid and solid fraction after accounting for separation efficiency. 

## `scripts-surface-pH`
R scripts for working and plotting slurry surface pH data. 
The script `main.R` calls all others. 
Plots can be found in `plots`.

## `scripts-tables`
R scripts for working with auxiliary data, ordering, summarizing, and producing tables for publications. 
The scripts `main.R` calls all others. 
The tables can be found in `output`.

# Links to technical note
This section give the sources of tables, figures, and some statistical results presented in the technical note (https://doi.org/10.1016/j.aeaoa.2025.100408).

| Paper component          |  Repo source                             |  Repo scripts             |
|-----------------         |-----------------                         |---------------            |
| Table 2  | `output/soil_prop_summary_table.xlsx` and `output/temp.csv` | `scripts-tables/Export.R` and `scripts-meas/export.R` |
|  Table 3 | `output/slurry_prop_summary_table.xlsx` | `scripts-tables/Export.R` |
|  Fig. 1 | `plots/NH3.flux.comm.135.pdf` | `scripts-meas/plot.R` |
|  Fig. 2 | `plots/emis_sep_int.pdf` | `scripts-meas/plot.R` |
|  Fig. 3 | `plots/surface.pH.pdf` | `scripts-suface-pH/plot.R` |
| Fig. 4  | `plots/sep.scenarios.pdf` | `scripts-sep-effect/plot.R` |
|  Fig. S1 | `plots/temp.pdf` | `scripts-meas/plot.R` |
|  Table S1 | `output/cum.emis.csv` | `scripts-meas/export.R` |
| Table S2  | `output/sep.scenarios.csv` | `scripts-sep-effect/export.R` |
