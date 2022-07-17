#library(ManifoldDestiny)
sapply(list.files(paste0(rprojroot::find_rstudio_root_file(),'/R'),full.names=T), source)
library(ggplot2)
library(dplyr)
library(gridExtra)
# Report
ohio_vrr <- Voterrollreport()
ohio_vrr$htmlreport()
# Graphical




ohio_vr$scorecard()
ohio_vr$predictinput()
ohio_vr$plot_predict()
#ohio_vr$lg_pred[[3]][[1]]
ohio_vr$plot_keyrat()
#ohio_vr$lg_keyr[[3]][[1]]
ohio_vr$plot_histio()
#ohio_vr$lg_hist
ohio_vr$gridarrange()

