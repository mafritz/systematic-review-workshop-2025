library(tidyverse)
library(here)
library(knitr)
library(kableExtra)
library(papaja)
library(effectsize)
library(scales)
library(RColorBrewer)

## Graphics
theme_set(theme_apa(box = TRUE))

scale_colour_discrete <- function(...) scale_colour_brewer(palette = "Dark2")
scale_fill_discrete <- function(...) scale_fill_brewer(palette = "Dark2")

## Table
custom_table <- function(data = NULL, caption_text = NULL, col_names = NULL, digits = 3, ...) {
  if (!hasArg(col_names)) {
    col_names <- names(data)
  }

  data |>
    kable(
      format = "latex",
      booktabs = TRUE,
      longtable = TRUE,
      col.names = col_names,
      caption = caption_text,
      digits = digits,
      ...
    ) %>%
    kable_styling(latex_options = c("striped", "repeat_header", "HOLD_position"))
}

## Functions

collapse_m_sd <- function(m, sd) {
  m_print = printnum(m)
  sd_print = paste0("(", printnum(sd), ")")
  text_print = paste(m_print, sd_print)
  return(text_print)
}
