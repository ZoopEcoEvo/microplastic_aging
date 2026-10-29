TITLE HERE
================
2026-10-29

- [Mortality Data](#mortality-data)
- [Thermal Limit Data](#thermal-limit-data)

## Mortality Data

``` r

surv_data |> 
  mutate(prop_mortality = num_dead /total) |> 
  ggplot(aes(x = MP_treatment, y = prop_mortality, fill = diet)) + 
  geom_boxplot(position = position_dodge(width = 0.85),
               outliers = F) + 
  geom_point(alpha = 0.5, position = position_dodge(width = 0.85)) + 
  labs(x = "Treatment", 
       y = "Mortality (proportion)") + 
  theme_matt_facets() + 
  theme(legend.position = "right")
```

<img src="../Figures/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

``` r

# Example GLMM with binomial response and a random intercept for 'cluster_id'
model <- glmer(
  cbind(num_dead, total - num_dead) ~ MP_treatment * diet + (1 | exp_rep/treatment_rep),
  data = surv_data,
  family = binomial(link = "logit")
)
# View summary and fixed effect estimates (log-odds)
summary(model)
## Generalized linear mixed model fit by maximum likelihood (Laplace Approximation) ['glmerMod']
##  Family: binomial  ( logit )
## Formula: cbind(num_dead, total - num_dead) ~ MP_treatment * diet + (1 |      exp_rep/treatment_rep)
##    Data: surv_data
## 
##      AIC      BIC   logLik deviance df.resid 
##    178.6    193.6    -81.3    162.6       40 
## 
## Scaled residuals: 
##      Min       1Q   Median       3Q      Max 
## -1.69713 -0.52457  0.07433  0.36196  1.82047 
## 
## Random effects:
##  Groups                Name        Variance Std.Dev.
##  treatment_rep:exp_rep (Intercept) 0.1059   0.3254  
##  exp_rep               (Intercept) 0.5451   0.7383  
## Number of obs: 48, groups:  treatment_rep:exp_rep, 8; exp_rep, 4
## 
## Fixed effects:
##                                 Estimate Std. Error z value Pr(>|z|)    
## (Intercept)                      -1.6992     0.4999  -3.399 0.000676 ***
## MP_treatmentMP                    1.2557     0.4105   3.059 0.002223 ** 
## MP_treatmentAged MP               0.6524     0.4108   1.588 0.112270    
## dietStarved                       2.2713     0.4156   5.465 4.64e-08 ***
## MP_treatmentMP:dietStarved       -1.4714     0.5445  -2.702 0.006886 ** 
## MP_treatmentAged MP:dietStarved  -0.7351     0.5416  -1.357 0.174725    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##             (Intr) MP_tMP MP_tAMP dtStrv MP_MP:
## MP_trtmntMP -0.485                             
## MP_trtmnAMP -0.476  0.579                      
## dietStarved -0.492  0.594  0.576               
## MP_trtmMP:S  0.367 -0.756 -0.438  -0.749       
## MP_trtAMP:S  0.361 -0.441 -0.760  -0.739  0.563


# Perform omnibus test or pairwise comparisons across groups

car::Anova(model, type = "III") # Likelihood ratio or Wald tests
## Analysis of Deviance Table (Type III Wald chisquare tests)
## 
## Response: cbind(num_dead, total - num_dead)
##                     Chisq Df Pr(>Chisq)    
## (Intercept)       11.5547  1  0.0006758 ***
## MP_treatment       9.4066  2  0.0090652 ** 
## diet              29.8629  1  4.637e-08 ***
## MP_treatment:diet  7.3425  2  0.0254447 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Get estimated marginal means (proportions on the probability scale)
emmeans(model, ~ MP_treatment * diet, type = "response") |> plot()
```

<img src="../Figures/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

## Thermal Limit Data

``` r

ctmax_data |> 
  ggplot(aes(x = MP_treatment, y = ctmax_c, fill = diet)) + 
  geom_boxplot(position = position_dodge(width = 0.75)) + 
  geom_point(position = position_dodge(width = 0.75)) + 
  labs(x = "Treatment", 
       y = "CTmax (°C)") + 
  theme_matt() + 
  theme(legend.position = "right")
```

<img src="../Figures/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

``` r

ctmax_data |> 
  filter(group_id == "Control - Fed") |> 
  ggplot(aes(x = experiment_date, y = ctmax_c)) + 
  geom_point()
```

<img src="../Figures/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

``` r

ctmax.model = lmer(data = ctmax_data, 
                   ctmax_c ~ MP_treatment * diet + (1|experiment_date/file_source))

car::Anova(ctmax.model, type = "III")
## Analysis of Deviance Table (Type III Wald chisquare tests)
## 
## Response: ctmax_c
##                       Chisq Df Pr(>Chisq)    
## (Intercept)       4467.7781  1  < 2.2e-16 ***
## MP_treatment         0.3186  2     0.8527    
## diet                22.9024  1  1.704e-06 ***
## MP_treatment:diet    0.8838  2     0.6428    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
