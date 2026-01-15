# Summarizes measurements

# flux: 
fsumm <- idat[, .(j.rel.mn  = mean(j.rel), 
                  j.rel.sd = sd(j.rel))
              , by = list(trial, treat, cta)]

# cumulative emissions: 
idat[, endt := fifelse(trial == 'Trial 5', 125, 135)]
isumm <- idat[, .(e.cum.final = max(e.cum), 
                     e.rel.final = max(e.rel),
                     e.cum.130 = approx(cta, e.cum, xout = endt[1])$y,
                     e.rel.130 = approx(cta, e.rel, xout = endt[1])$y
                     ), by = .(trial, treat, pmid)]

# temperature data 
wsumm <- idat[, .(dt = t.start.p[1],
                      air.temp.start = mean(air.temp[interval == 1]), 
                      air.temp.mean = mean(air.temp), 
                      air.temp.min = min(air.temp), 
                      air.temp.max = max(air.temp)) 
                      , by = list(trial)]

# Mean and sd of cumulative emission
esumm <- isumm[ , list(
                       pmid = paste(pmid, collapse = ', '),
                       e.rel.final = mean(e.rel.final), e.rel.final.sd = sd(e.rel.final), e.rel.final.n = length(e.rel.final),
                       e.cum.final = mean(e.cum.final), e.cum.final.sd = sd(e.cum.final), e.cum.final.n = length(e.cum.final),
                       e.rel.130 = mean(e.rel.130), e.rel.130.sd = sd(e.rel.130), e.rel.130.n = length(e.rel.130),
                       e.cum.130 = mean(e.cum.130), e.cum.130.sd = sd(e.cum.130), e.cum.130.n = length(e.cum.130)
                       ), by = list(trial, treat)]

isumm <- rounddf(isumm, digits = 3, func = signif)
esumm <- rounddf(esumm, 3, func = signif)
wsumm <- rounddf(wsumm, 3, func = signif)

