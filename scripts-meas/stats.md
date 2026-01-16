---
title: 'Separation stats'
author: Sasha and Flavia
---

Plot data


``` r
ggplot(isumm, aes(as.integer(factor(treat)), e.rel.130, color = trial)) + 
  geom_point() + 
  geom_line() + 
  facet_wrap(~ slurry.type, scales = 'free_x') + 
  theme_bw() + 
  labs(y = 'Loss (frac. of TAN)') + 
  theme(legend.title = element_blank())
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

Linear models


``` r
mod1 <- lmer(e.rel.130 ~ separation * slurry.type + (1|trial), data = isumm)
summary(mod1)
```

```
## Linear mixed model fit by REML ['lmerMod']
## Formula: e.rel.130 ~ separation * slurry.type + (1 | trial)
##    Data: isumm
## 
## REML criterion at convergence: -83.5
## 
## Scaled residuals: 
##      Min       1Q   Median       3Q      Max 
## -1.93651 -0.57471 -0.07722  0.60241  2.28738 
## 
## Random effects:
##  Groups   Name        Variance  Std.Dev.
##  trial    (Intercept) 9.571e-05 0.009783
##  Residual             7.430e-03 0.086200
## Number of obs: 53, groups:  trial, 6
## 
## Fixed effects:
##                                Estimate Std. Error t value
## (Intercept)                     0.42408    0.03101  13.676
## separationLiquid               -0.24610    0.04190  -5.874
## separationSolid                -0.36218    0.04190  -8.645
## slurry.typePS                  -0.19182    0.04265  -4.498
## separationLiquid:slurry.typePS  0.06782    0.05837   1.162
## separationSolid:slurry.typePS   0.49770    0.05837   8.527
## 
## Correlation of Fixed Effects:
##             (Intr) sprtnL sprtnS slr.PS sL:.PS
## separatnLqd -0.716                            
## separatnSld -0.716  0.530                     
## slrry.typPS -0.727  0.520  0.520              
## sprtnLq:.PS  0.514 -0.718 -0.380 -0.705       
## sprtnSl:.PS  0.514 -0.380 -0.718 -0.705  0.515
```

``` r
anova(mod1)
```

```
## Analysis of Variance Table
##                        npar  Sum Sq Mean Sq F value
## separation                2 0.37273 0.18637 25.0812
## slurry.type               1 0.00000 0.00000  0.0004
## separation:slurry.type    2 0.64598 0.32299 43.4682
```


``` r
plot(mod1)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)

``` r
qqnorm(resid(mod1))
qqline(resid(mod1))
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-2.png)


``` r
mod2 <- lmer(e.rel.130 ~ separation * slurry.type + (1 + separation | trial), data = isumm)
summary(mod2)
```

```
## Linear mixed model fit by REML ['lmerMod']
## Formula: e.rel.130 ~ separation * slurry.type + (1 + separation | trial)
##    Data: isumm
## 
## REML criterion at convergence: -125.9
## 
## Scaled residuals: 
##      Min       1Q   Median       3Q      Max 
## -1.61629 -0.55448  0.00996  0.44629  2.27976 
## 
## Random effects:
##  Groups   Name             Variance Std.Dev. Corr       
##  trial    (Intercept)      0.005592 0.07478             
##           separationLiquid 0.013018 0.11410  -0.87      
##           separationSolid  0.021531 0.14674  -0.63  0.23
##  Residual                  0.001753 0.04186             
## Number of obs: 53, groups:  trial, 6
## 
## Fixed effects:
##                                Estimate Std. Error t value
## (Intercept)                     0.42117    0.04571   9.214
## separationLiquid               -0.24320    0.06899  -3.525
## separationSolid                -0.35927    0.08716  -4.122
## slurry.typePS                  -0.18892    0.06441  -2.933
## separationLiquid:slurry.typePS  0.06492    0.09741   0.666
## separationSolid:slurry.typePS   0.49480    0.12314   4.018
## 
## Correlation of Fixed Effects:
##             (Intr) sprtnL sprtnS slr.PS sL:.PS
## separatnLqd -0.857                            
## separatnSld -0.636  0.249                     
## slrry.typPS -0.710  0.608  0.451              
## sprtnLq:.PS  0.607 -0.708 -0.176 -0.857       
## sprtnSl:.PS  0.450 -0.176 -0.708 -0.635  0.247
```

``` r
anova(mod2)
```

```
## Analysis of Variance Table
##                        npar   Sum Sq   Mean Sq F value
## separation                2 0.033513 0.0167565  9.5610
## slurry.type               1 0.009082 0.0090823  5.1822
## separation:slurry.type    2 0.028495 0.0142474  8.1294
```


``` r
mns <- emmeans(mod1, ~ separation | slurry.type)
```

```
## Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed
```

``` r
cld(mns) 
```

```
## slurry.type = AD:
##  separation emmean     SE   df lower.CL upper.CL .group
##  Solid      0.0619 0.0293 23.9  0.00144    0.122  1    
##  Liquid     0.1780 0.0293 23.9  0.11752    0.238   2   
##  Unsep      0.4241 0.0310 26.6  0.36041    0.488    3  
## 
## slurry.type = PS:
##  separation emmean     SE   df lower.CL upper.CL .group
##  Liquid     0.0540 0.0293 23.9 -0.00648    0.114  1    
##  Unsep      0.2323 0.0293 23.9  0.17180    0.293   2   
##  Solid      0.3678 0.0293 23.9  0.30732    0.428    3  
## 
## Degrees-of-freedom method: satterthwaite 
## Confidence level used: 0.95 
## P value adjustment: tukey method for comparing a family of 3 estimates 
## significance level used: alpha = 0.05 
## NOTE: If two or more means share the same grouping symbol,
##       then we cannot show them to be different.
##       But we also did not show them to be the same.
```


``` r
mns <- emmeans(mod2, ~ separation | slurry.type)
```

```
## Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed
```

``` r
cld(mns) 
```

```
## slurry.type = AD:
##  separation emmean     SE   df lower.CL upper.CL .group
##  Solid      0.0619 0.0680 4.00  -0.1268    0.251  1    
##  Liquid     0.1780 0.0380 4.00   0.0725    0.283  12   
##  Unsep      0.4212 0.0457 4.11   0.2956    0.547   2   
## 
## slurry.type = PS:
##  separation emmean     SE   df lower.CL upper.CL .group
##  Liquid     0.0540 0.0380 4.00  -0.0515    0.159  1    
##  Unsep      0.2323 0.0454 3.99   0.1062    0.358  1    
##  Solid      0.3678 0.0680 4.00   0.1791    0.556  1    
## 
## Degrees-of-freedom method: satterthwaite 
## Confidence level used: 0.95 
## P value adjustment: tukey method for comparing a family of 3 estimates 
## significance level used: alpha = 0.05 
## NOTE: If two or more means share the same grouping symbol,
##       then we cannot show them to be different.
##       But we also did not show them to be the same.
```

# Conclusion:
* Separation affects emission
* The reduction for the solid fraction differs between slurry types
* The liquid fraction has lower emission than whole slurry for both, and the reduction is not clearly different between slurry types
* For digestate, both liquid and solid fractions have lower emission than whole slurry, but are not clearly different from each other, if we consider that the separation effect varies among trials (and it clearly does, from mod2)
* For pig slurry, whole slurry and the solid fraction are not clearly different, but liquid is clearly different (lower) than both
