# Summarizes measurements

# flux: 
fsumm <- idat[, .(j.rel.mn  = mean(j.rel), 
                  j.rel.sd = sd(j.rel))
              , by = list(new.ID, treat, cta)]

# cumulative emissions: 
idat1 <- idat[! new.ID == 'Trial 5', ]
idat2 <- idat[new.ID == 'Trial 5', ]

isumm1 <- idat1[, .(e.cum.final = max(e.cum), 
                     e.rel.final = max(e.rel),
                     e.cum.130 = approx(cta, e.cum, xout = 135)$y,
                     e.rel.130 = approx(cta, e.rel, xout = 135)$y
                     ), by = list(new.ID, treat, pmid)]

isumm2 <- idat2[, .(e.cum.final = max(e.cum), 
                    e.rel.final = max(e.rel),
                    e.cum.130 = approx(cta, e.cum, xout = 125)$y,
                    e.rel.130 = approx(cta, e.rel, xout = 125)$y
), by = list(new.ID, treat, pmid)]

isumm <- rbind(isumm1, isumm2)

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
                       e.rel.130 = mean(e.rel.130), e.rel.130.sd = sd(e.rel.130), e.rel.130.n = length(e.rel.130),
                       e.cum.130 = mean(e.cum.130), e.cum.130.sd = sd(e.cum.130), e.cum.130.n = length(e.cum.130)
                       ), by = list(new.ID, treat)]

isumm <- rounddf(as.data.frame(isumm), digits = 3, func = signif)
esumm <- rounddf(as.data.frame(esumm), 3, func = signif)
wsumm <- rounddf(as.data.frame(wsumm), 3, func = signif)

