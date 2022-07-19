library(ManifoldDestiny)
library(ggplot2)
sapply(list.files(paste0(rprojroot::find_rstudio_root_file(),'/R'),full.names=T), source)
library(dplyr)
library(gridExtra)
# Graphical
ohio_vrg <- Voterrollgraphs()
ohio_vrg$scorecard()
ohio_vrg$predictinput()
ohio_vrg$plot_predict()
##ohio_vrg$lg_pred[[3]][[3]]
ohio_vrg$plot_keyrat()
##ohio_vrg$lg_keyr[[3]][[2]]
ohio_vrg$plot_histio()
#ohio_vrg$lg_hist[[1]][[2]]
ohio_vrg$gridarrange()
# Report
ohio_vrr <- Voterrollreport()
ohio_vrr$scorecard()
ohio_vrr$predictinput()
ohio_vrr$htmlreport()


library(ggplot2)
library(gridExtra)
library(ggedit)
df <- data.frame(type=c("A", "A", "A", "B", "B"), group=rep("group1", 5))
gg1 <- ggplot2::ggplot(df, aes(x=type)) + geom_bar(drop=T) + scale_x_discrete(drop=F)
gg2 <- ggplot2::ggplot(df, aes(x=type)) + geom_bar() + scale_x_discrete(drop=T)


gridExtra::grid.arrange(gg1,gg2)
