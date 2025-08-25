set.seed(46378)
library(dplyr)
library(meta)


# Output 1 ----------------------------------------------------------------

n_studies_1 <- 10
n_samples_1 <- c(10, 15, 25)

e_mean_1 = 115
e_sd_1 = 7

c_mean_1 = 100
c_sd_1 = 7

data_1 <- tibble(
    author = paste("Contribution", 1:n_studies_1),
    n.e = sample(n_samples_1, n_studies_1, replace = TRUE),
    mean.e = rnorm(n_studies_1, e_mean_1, e_sd_1/2),
    sd.e = rnorm(n_studies_1, e_sd_1, e_sd_1/2),
    n.c = n.e,
    mean.c = rnorm(n_studies_1, c_mean_1, c_sd_1/2),
    sd.c = rnorm(n_studies_1, c_sd_1, c_sd_1/2)
  )


analysis_1 <- metacont(
                    n.e = n.e,
                    mean.e = mean.e,
                    sd.e = sd.e,
                    n.c = n.c,
                    mean.c = mean.c,
                    sd.c = sd.c,
                    studlab = author,
                    sm = "SMD",
                    method.smd = "Hedges",
                    fixed = TRUE,
                    random = FALSE,
                    method.tau = "REM",
                    hakn = TRUE,
                    prediction = TRUE,
                    title = "Exemple de méta-analysis",
                    data = data_1,
)

forest(
  analysis_1,
  digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE,
  common = TRUE,
  random = FALSE,
  hetstat = FALSE
)


# Produce funnel plot
funnel(analysis_1,
            studlab = TRUE,
            common = TRUE,
            random = FALSE
)

