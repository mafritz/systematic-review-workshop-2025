library(here)
library(meta)

print_forest <- function(analysis, com = FALSE, ran = TRUE, het = FALSE) {
  forest(
    analysis,
    digits = 2,
    digits.se = 2,
    digits.stat = 2,
    prediction = TRUE,
    common = com,
    random = ran,
    hetstat = het,
    fontsize = 6,
    spacing = 0.7
  )
}
