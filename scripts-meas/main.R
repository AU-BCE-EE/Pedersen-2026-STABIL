rm(list = ls())

source('functions.R')
source('packages.R')
source('load.R')
source('merge.R')
source('cta.R')
source('summary.R')
source('clean.R')
source('export.R')
source('plot.R')
render('stats.Rmd')
knit('stats.Rmd')

