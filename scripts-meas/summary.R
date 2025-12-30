# Summarizes measurements

# flux: 
fsumm <- idat[, .(j.rel.mn  = mean(j.rel), 
                  j.rel.sd = sd(j.rel))
              , by = list(new.ID, treat, cta)]

# cumulative emissions: 
isumm <- idat[, .(e.cum.final = max(e.cum), 
                     e.rel.final = max(e.rel),
                     e.cum.135 = approx(cta, e.cum, xout = 135)$y,
                     e.rel.135 = approx(cta, e.rel, xout = 135)$y
                     ), by = list(new.ID, treat, pmid)]

# temperature data 
wsumm <- idat[, .(dt = t.start.p[1],
                      air.temp.start = mean(air.temp[interval == 1]), 
                      air.temp.mean = mean(air.temp), 
                      air.temp.min = min(air.temp), 
                      air.temp.max = max(air.temp)) 
                      , by = list(new.ID)]

# Mean and sd of cumulative emission
esumm <- isumm[ , list(
                       pmid = paste(pmid, collapse = ', '),
                       e.rel.final = mean(e.rel.final), e.rel.final.sd = sd(e.rel.final), e.rel.final.n = length(e.rel.final),
                       e.cum.final = mean(e.cum.final), e.cum.final.sd = sd(e.cum.final), e.cum.final.n = length(e.cum.final),
                       e.rel.135 = mean(e.rel.135), e.rel.135.sd = sd(e.rel.135), e.rel.135.n = length(e.rel.135),
                       e.cum.135 = mean(e.cum.135), e.cum.135.sd = sd(e.cum.135), e.cum.135.n = length(e.cum.135)
                       ), by = list(new.ID, treat)]

isumm <- rounddf(as.data.frame(isumm), digits = 3, func = signif)
esumm <- rounddf(as.data.frame(esumm), 3, func = signif)
wsumm <- rounddf(as.data.frame(wsumm), 3, func = signif)
