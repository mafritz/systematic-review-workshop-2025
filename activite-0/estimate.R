library(here)
library(meta)
library(tibble)
library(dplyr)
library(readr)

# =========================
# PARAMETERS
# =========================
# If TRUE: analyze errors (estimate - true_n), centered on 0
# If FALSE: analyze raw guesses (average guess)
center_on_truth <- FALSE

# Path to external file that contains the true value
# (e.g., create "true_value.txt" with just one line: 1000)
true_value_file <- here::here("activite-0/coffee_answer.txt")

# Confidence level for students' intervals (can be row-specific too)
default_conf_level <- 0.95

# =========================
# 1) RANDOM TEST DATA
# =========================
set.seed(123) # reproducibility
guesses <- tibble(
  id = paste("Estimation", 1:10),
  estimate = round(rnorm(10, mean = 950, sd = 120)), # random guesses
  range = sample(seq(100, 400, by = 50), 10, replace = TRUE), # � interval
  conf_level = default_conf_level
)

print(guesses)

# =========================
# 2) READ TRUE VALUE
# =========================
true_n <- suppressWarnings(as.numeric(read_lines(true_value_file, n_max = 1)))

if (center_on_truth && (is.na(true_n) || length(true_n) == 0)) {
  stop("center_on_truth = TRUE but could not read 'true_n' from file.")
}

# =========================
# 3) PREP (compute TE & SE)
# =========================
z_from_cl <- function(cl) qnorm(1 - (1 - cl) / 2)

prep <- guesses %>%
  mutate(
    conf_level = ifelse(is.na(conf_level), default_conf_level, conf_level),
    z = z_from_cl(conf_level),
    seTE = range / z,
    TE = if (center_on_truth) estimate - true_n else estimate
  )

# =========================
# 4) META-ANALYSIS
# =========================
m <- metagen(
  TE = prep$TE,
  seTE = prep$seTE,
  studlab = prep$id,
  sm = "MD",
  comb.fixed = FALSE,
  comb.random = TRUE,
  method.tau = "REML",
  hakn = TRUE
)

print(summary(m))

# =========================
# 5) FOREST PLOT
# =========================
xlab_txt <- if (center_on_truth) {
  "Erreur (estimation \u2212 vraie valuer)"
} else {
  "Estimation"
}
ref_line <- if (center_on_truth) 0 else true_n # vertical line: 0 (errors) or truth (raw)

forest(
  m,
  prediction = TRUE,
  leftcols = c("studlab"),
  leftlabs = c("Estimation"),
  rightlabs = c("Effet [IC]"),
  xlab = xlab_txt,
  lab.e = if (center_on_truth) "Au-dessus de la valeur" else "Plus grand",
  lab.c = if (center_on_truth) "En-dessous de la valeur" else "Plus petit",
  print.tau2 = FALSE,
  print.I2 = FALSE,
  print.pval.Q = FALSE,
  ref = ref_line,
  col.square = "black",
  col.diamond = "darkred",
  col.diamond.lines = "darkred",
  col.predict = "gray30",
  test.overall.random = FALSE,
  fontsize = 15
)
