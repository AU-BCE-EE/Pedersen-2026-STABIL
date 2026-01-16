
library(ggplot2)
library(data.table)
library(emmeans)
library(multcomp)
library(multcompView)
library(lme4)
library(nlme)
library(gridExtra)
library(rmarkdown)
library(knitr)
library(scales)
library(patchwork)


sink('../logs/R-versions-meas.txt')
  print(sessionInfo())
sink()
