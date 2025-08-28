library(here)
library(readxl)
library(writexl)
library(dplyr)

library(dplyr)

compute_effect_sizes <- function(data) {
  data %>%
    rowwise() %>%
    mutate(
      # pooled SD
      sp = sqrt(((treat_n - 1) * treat_sd^2 + (ctrl_n - 1) * ctrl_sd^2) /
        (treat_n + ctrl_n - 2)),

      # --- Cohen's d ---
      cohen_d = (treat_m - ctrl_m) / sp,
      cohen_var = (treat_n + ctrl_n) / (treat_n * ctrl_n) + (cohen_d^2) / (2 * (treat_n + ctrl_n)),
      cohen_se = sqrt(cohen_var),

      # --- Hedges' g ---
      J = 1 - (3 / (4 * (treat_n + ctrl_n) - 9)), # correction factor
      hedges_g = J * cohen_d,
      hedges_var = J^2 * cohen_var,
      hedges_se = sqrt(hedges_var)
    ) %>%
    ungroup() %>%
    select(study, contains("cohen_"), contains("hedges_"))
}


m_sd_n_2groupes <- read_excel("activite-3/data/descriptive_groups_zhang_2025.xlsx")

es <- compute_effect_sizes(m_sd_n_2groupes)
write_xlsx(es, here("activite-3", "data", "effect_sizes_zhang_2025.xlsx"))
