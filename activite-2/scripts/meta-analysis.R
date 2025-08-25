# Le script utilise tibble et meta qui peuvent être installés avec install.packages("meta", "tibble")

set.seed(2023)
library(tibble)
library(meta)

# Vous pouvez modifier les données dans ce data.frame

data_meta_analysis <- tibble::tribble(
  ~author,         ~n.e,    ~mean.e, ~sd.e,     ~n.c, ~mean.c, ~sd.c,
  "Expérience 1",    50,      115.0,  15.0,       50,   100.0,  15.0,
  "Expérience 2",    20,      125.5,  15.9,       20,   102.8,  13.8,
  "Expérience 3",    10,      105.0,  13.0,       10,   111.0,  16.4,
  "Expérience 4",    90,      111.4,  13.7,       90,   101.5,  11.9,
  "Expérience 5",    25,      101.5,  16.2,       25,   106.2,  12.8,
  "Expérience 6",    60,      117.5,  18.2,       60,   103.4,  15.6,
  "Expérience 7",    30,      112.1,  14.7,       30,   109.1,  16.3,
)

# Ensuite vous exécuter la fonction pour produire la méta-analyse

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
                   title = "Exemple de méta-analysis"
)

# Enfin vous produisez le forest plot qui s'affiche dans le panel "Plots" si vous utilisez RStudio
# Vous pouvez modifier les paramètres common et random pour décider le type d'effet à calculer

forest(
  m.cont, digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE,
  common = FALSE,
  random = TRUE,
  fontsize = 8
)

