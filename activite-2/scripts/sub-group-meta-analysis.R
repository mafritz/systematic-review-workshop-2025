set.seed(2023)
library(tibble)
library(meta)


data_meta_analysis <- tibble::tribble(
  ~author,         ~n.e,    ~mean.e, ~sd.e,     ~n.c, ~mean.c, ~sd.c,  ~factor,
  "Expérience 1",    50,      115.0,  15.0,       50,   100.0,  15.0,  "A",
  "Expérience 2",    20,      125.5,  15.9,       20,   102.8,  13.8,  "B",
  "Expérience 3",    10,      105.0,  13.0,       10,   111.0,  16.4,  "A",
  "Expérience 4",    90,      111.4,  13.7,       90,   101.5,  11.9,  "B",
  "Expérience 5",    25,      101.5,  16.2,       25,   106.2,  12.8,  "A",
  "Expérience 6",    60,      117.5,  18.2,       60,   103.4,  15.6,  "B",
  "Expérience 7",    30,      112.1,  14.7,       30,   109.1,  16.3,  "A"
)


m.cont <- metacont(n.e = n.e,
                   mean.e = mean.e,
                   sd.e = sd.e,
                   n.c = n.c,
                   mean.c = mean.c,
                   sd.c = sd.c,
                   studlab = author,
                   data = data_meta_analysis,
                   sm = "SMD",
                   method.smd = "Hedges",
                   fixed = TRUE,
                   random = TRUE,
                   method.tau = "REM",
                   hakn = TRUE,
                   prediction = TRUE,
                   title = "Exemple de méta-analysis",
                   subgroup = factor
)

forest(
  m.cont, digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE
)


# Produce funnel plot
funnel(m.cont,
            xlim = c(-.8, 1.5),
            studlab = TRUE,
            common = FALSE,
            cex.studlab = 1.3
)

