set.seed(2023)
library(tibble)
library(meta)


data_2 <- tibble::tribble(
  ~author,         ~n.e,    ~mean.e, ~sd.e,     ~n.c, ~mean.c, ~sd.c,
  "Contribution 1",    40,      105.7,  10.1,       40,   101.1,  10.6,
  "Contribution 2",    30,      105.5,  10.9,       30,    99.8,  13.8,
  "Contribution 3",    50,      107.3,  13.0,       50,    97.2,  9.4,
  "Contribution 4",    30,      103.4,  13.7,       30,   101.5,  11.9,
  "Contribution 5",    25,      102.5,  11.2,       25,    99.2,  12.8,
  "Contribution 6",    20,      106.1,   9.2,       20,   102.4,   9.6,
  "Contribution 7",    30,      107.1,  14.7,       30,   102.9,  12.3,
)


analysis_2 <- metacont(n.e = n.e,
                   mean.e = mean.e,
                   sd.e = sd.e,
                   n.c = n.c,
                   mean.c = mean.c,
                   sd.c = sd.c,
                   studlab = author,
                   data = data_2,
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
  analysis_2, digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE,
  common = FALSE,
  random = TRUE
)


# Produce funnel plot
funnel(analysis_2,
            studlab = TRUE,
            common = FALSE,
            cex.studlab = 1.3
)

