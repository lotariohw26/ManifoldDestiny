#library(ManifoldDestiny)
sapply(list.files(paste0(rprojroot::find_rstudio_root_file(),'/R'),full.names=T), source)
library(ggplot2)
library(dplyr)
library(gridExtra)
# Report
ohio_vrr <- Voterrollreport()
ohio_vrr$htmlreport()
# Graphical
ohio_vrr <- Voterrollgraphs()
ohio_vrr$scorecard()
ohio_vrr$predictinput()
ohio_vrr$plot_predict()
ohio_vrr$lg_pred[[3]][[1]]

ohio_vr$plot_keyrat()
#ohio_vr$lg_keyr[[3]][[1]]
ohio_vr$plot_histio()
#ohio_vr$lg_hist
ohio_vr$gridarrange()

