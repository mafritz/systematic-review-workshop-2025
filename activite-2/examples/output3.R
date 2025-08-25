set.seed(2023)
library(tibble)
library(meta)


data_3 <- tibble::tribble(
  ~author,         ~n.e,    ~mean.e, ~sd.e,     ~n.c, ~mean.c, ~sd.c,
  "Contribution 1",    30,      114.7,  15.1,       30,   101.1,  15.6,
  "Contribution 2",    20,      101.5,  15.9,       20,   112.8,  13.8,
  "Contribution 3",    10,      117.3,  13.0,       10,   103.2,  16.4,
  "Contribution 4",    30,       95.4,  13.7,       30,   117.5,  11.9,
  "Contribution 5",    25,      121.5,  16.2,       25,    99.2,  12.8,
  "Contribution 6",    20,       97.5,  18.2,       20,   113.4,  15.6,
  "Contribution 7",    30,      112.1,  14.7,       30,   101.9,  16.3,
)


analysis_3 <- metacont(n.e = n.e,
                   mean.e = mean.e,
                   sd.e = sd.e,
                   n.c = n.c,
                   mean.c = mean.c,
                   sd.c = sd.c,
                   studlab = author,
                   data = data_3,
                   sm = "SMD",
                   method.smd = "Hedges",
                   fixed = FALSE,
                   random = TRUE,
                   method.tau = "REM",
                   hakn = TRUE,
                   prediction = TRUE,
                   title = "Exemple de méta-analysis"
)

forest(
  analysis_3, digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE,
  common = FALSE,
  random = TRUE
)


# Produce funnel plot
funnel(analysis_3,
            studlab = TRUE,
            common = FALSE,
            cex.studlab = 1.3
)

