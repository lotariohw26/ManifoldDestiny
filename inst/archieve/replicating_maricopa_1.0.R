###############################################################################
# Version 1.0
# Replication of Ed Solomon's results from Maricopa County, Arizona
# https://docs.google.com/document/d/1-9qbBtTqiGlAurJjEbtVt6lBUi9MKTqPR-xb3FpHx-A/edit#
###############################################################################
###############################################################################
library(ManifoldDestiny)
library(tidyr)
library(ggpmisc)
library(dplyr)
library(plotly)
df_mcp <- openxlsx::read.xlsx('../inst/Maricopa Plane Equation.xlsx') %>% dplyr::select(2:10)
names(df_mcp) <- c("pre","prename","BidEDV","TrpEDV","BidMiV","TrpMiV",
		   "Biden.EDVp","Biden.Mailp","Biden.Aggp")
###############################################################################
View(df_mcp)
# Phase I
# Defining
## Biden's election day vote
alpha <- as.numeric(df_mcp$Biden.Aggp)
xn <- as.numeric(df_mcp$Biden.EDVp)
yn <- as.numeric(df_mcp$Biden.Mailp)
## Parameters (see Ed's documentation)
k <- 0.10
h <- -0.0282354516396
#VGAM::zeta(x, deriv = 2, shift = 1, T) # the h-parameter can also be derived
#from such type of function

## Equations (y: mail-in vote percentage, plaina, aggregate percentage)
y <- function(alpha,x,k,h) eval(parse(text='(alpha-k*x-h)/(1-k*x)'),c(list(alpha=alpha,x=x),list(k=k,h=h)))

plaina <- function(x,y,k,h) eval(parse(text='y-k*x*y+k*x+h'),c(list(x=x,y=y),list(k=k,h=h)))

names(df_mcp)
## Forming the data.frame
df_mcp_man <- df_mcp %>% dplyr::mutate(k=k,h=h) %>%
	dplyr::mutate(plaina=plaina(alpha,yn,k,h)) %>%
	dplyr::mutate(y_man=y(alpha,xn,k,h)) %>%
	dplyr::mutate(resA=plaina-Biden.Aggp) %>%
	dplyr::mutate(resM=y_man-Biden.Mailp) %>%
	dplyr::mutate(zeta=(xn-alpha)/(alpha-yn)) %>%
 	tidyr::pivot_longer(c(plaina,y_man))

regagg <- dplyr::filter(df_mcp_man,name%in%c('plaina'))
regmail <- dplyr::filter(df_mcp_man,name%in%c('y_man'))
foragg <- 'y ~ x'
formail <- 'y ~ x'
#View(regagg)
pagg  <- ggplot2::ggplot(regagg,ggplot2::aes(x=Biden.Aggp,y=value)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method='lm',formula=foragg) +
  ggpmisc::stat_poly_eq(formula = foragg,
               ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),		   rr.digits=10,
               parse = TRUE) +
  ggplot2::labs(y='Biden.Aggp regression')

pmail <- ggplot2::ggplot(regmail,ggplot2::aes(x=Biden.Mailp,y=value)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method='lm',formula=formail) +
  ggpmisc::stat_poly_eq(formula = formail,
                        ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),rr.digits=10,
                        parse = TRUE) + ggplot2::labs(y='Biden.Aggp regression') +
ggplot2::labs(y='Biden.Mailp regression')
### Output (saveed to Excel)
sheets <- list("phase1" =df_mcp_man)
writexl::write_xlsx(sheets, paste0('maricopareplicationplane.xlsx'))
###############################################################################
# Phase II: Finding the aggregates
pol_order <- 7
l()
df_mcp_pol <- df_mcp_man %>%   tidyr::pivot_wider() %>%
  dplyr::arrange(Biden.Aggp) %>%
  dplyr::mutate(quantile=dplyr::row_number(Biden.Aggp)/max(row_number())) %>%
  dplyr::select(quantile,dplyr::everything())

polr <- polynom::polynomial(unname(coef(lm(df_mcp_pol$Biden.Aggp ~ poly(df_mcp_pol$quantile,pol_order, raw = T)))))
polr[1] <- 0.1 # Can be adjusted to change Biden's percentage (note: so far this
#not update the plot)
bidpre <- round(polynom::integral(polr,c(0,1)),digits=4)
forpol <- y ~ poly(x,pol_order, raw = T)

p7poly <- ggplot2::ggplot(df_mcp_pol,ggplot2::aes(x=quantile,y=Biden.Aggp)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method = "lm", formula=forpol) +
  ggpmisc::stat_poly_eq(formula = forpol,ggplot2::aes(label = paste(..eq.label.., ..rr.label..,sep = "~~~")),rr.digits=6,parse = TRUE) +
  ggplot2::labs(caption = paste0("Biden's aggregate: ",bidpre))
###############################################################################
# Plotting the results
## ggplot
g <- gridExtra::grid.arrange(pagg,pmail,p7poly)
### Saves plot as combined png file
ggplot2::ggsave(file='maricopa_all.png',g,width = 4, height = 3)
###############################################################################
## Plotly
subplot(pagg,pmail,p7poly)
#View(df_mcp_pol)
names(df_mcp_pol)
xn <- df_mcp_pol$Biden.EDVp
yn <- df_mcp_pol$Biden.Mailp
zn <- df_mcp_pol$Biden.Aggp
plotly::plot_ly(x=xn,y=yn,z=zn,type="scatter3d", mode="markers")
###############################################################################
