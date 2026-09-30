# Lab ggplot2 themes --------------------------------------------------------
# Sourced by report.Rmd (and anything else that makes figures), so a change
# here updates every figure in the project.
#
# Requires: ggplot2, ggpubr, monochromeR

library(ggplot2)

# Shared text and background styling used by both themes
lab_theme_elements <- function(base_size, dark_text, mid_text) {
  theme(
    panel.background  = element_rect(fill = "transparent", colour = NA),
    plot.background   = element_rect(fill = "transparent", colour = NA),
    legend.background = element_rect(fill = "transparent", colour = NA),
    legend.key        = element_rect(fill = "transparent", colour = NA),
    text  = element_text(colour = mid_text, lineheight = 1.1),
    title = element_text(size = base_size * 1.5, colour = dark_text),
    axis.text    = element_text(size = base_size, colour = mid_text),
    axis.title.x = element_text(size = base_size * 1.2,
                                margin = margin(3, 0, 0, 0, "mm")),
    axis.title.y = element_text(size = base_size * 1.2,
                                margin = margin(0, 5, 0, 0, "mm"),
                                angle = 90),
    legend.text  = element_text(size = base_size * 0.9),
    legend.title = element_text(size = base_size * 0.9, face = "bold"),
    plot.margin  = margin(0.25, 0.25, 0.25, 0.25, "cm")
  )
}

# Lighter shade of the main text colour, used for axis labels and body text
lab_mid_text <- function(dark_text) {
  monochromeR::generate_palette(dark_text, "go_lighter", n_colours = 5)[2]
}

# Standard single-panel theme
theme_matt <- function(base_size = 18, dark_text = "grey20") {
  ggpubr::theme_pubr(base_family = "sans") %+replace%
    lab_theme_elements(base_size, dark_text, lab_mid_text(dark_text))
}

# Theme for faceted plots (adds strip text, removes grid lines)
theme_matt_facets <- function(base_size = 18, dark_text = "grey20") {
  theme_bw(base_family = "sans") %+replace%
    lab_theme_elements(base_size, dark_text, lab_mid_text(dark_text)) %+replace%
    theme(
      panel.grid   = element_blank(),
      strip.text.x = element_text(size = base_size),
      strip.text.y = element_text(size = base_size, angle = 270)
    )
}
