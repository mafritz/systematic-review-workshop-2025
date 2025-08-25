set.seed(2023)
library(tibble)
library(meta)


data_intro <- tibble::tribble(
  ~author,         ~n.e,    ~mean.e, ~sd.e,     ~n.c, ~mean.c, ~sd.c,
  "Contribution 1",    10,      115.7,  25.1,       10,   101.1,  25.6,
  "Contribution 2",    50,      116.5,  14.9,       50,    99.8,  15.8,
  "Contribution 3",    100,     114.3,  10.1,       100,  100.2,  11.4
)


analysis_intro <- metacont(n.e = n.e,
                       mean.e = mean.e,
                       sd.e = sd.e,
                       n.c = n.c,
                       mean.c = mean.c,
                       sd.c = sd.c,
                       studlab = author,
                       data = data_intro,
                       sm = "SMD",
                       method.smd = "Hedges",
                       fixed = TRUE,
                       random = TRUE,
                       method.tau = "REM",
                       hakn = TRUE,
                       prediction = TRUE,
                       title = "Exemple de méta-analysis"
)

forest(
  analysis_intro, digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE,
  common = TRUE,
  random = TRUE
)


# Produce funnel plot
funnel(analysis_intro,
            studlab = TRUE,
            common = FALSE,
            cex.studlab = 1.3
)

