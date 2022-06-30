###############################################################################
# version 1.0
# replication of ed solomon's results from maricopa county, arizona
# https://docs.google.com/document/d/1-9qbbttqiglaurjjebtvt6lbui9mktqpr-xb3fphx-a/edit#
###############################################################################
rm(list=ls())
###############################################################################
library(tidyr)
library(ggpmisc)
library(dplyr)
library(plotly)
df_mcp <- openxlsx::read.xlsx('../data-raw/xlsx/Maricopa Plane Equation.xlsx') %>% dplyr::select(2:10)
names(df_mcp) <- c("pre","prename","bidedv","trpedv","bidmiv","trpmiv",
		   "biden.edvp","biden.mailp","biden.aggp")
###############################################################################
# phase i
# defining
## biden's election day vote
alpha <- as.numeric(df_mcp$biden.aggp)
xn <- as.numeric(df_mcp$biden.edvp)
yn <- as.numeric(df_mcp$biden.mailp)
## parameters (see ed's documentation)
k <- 0.10
h <- -0.0282354516396
#vgam::zeta(x, deriv = 2, shift = 1, t) # the h-parameter can also be derived
#from such type of function

## equations (y: mail-in vote percentage, plaina, aggregate percentage)
y <- function(alpha,x,k,h) eval(parse(text='(alpha-k*x-h)/(1-k*x)'),c(list(alpha=alpha,x=x),list(k=k,h=h)))

plaina <- function(x,y,k,h) eval(parse(text='y-k*x*y+k*x+h'),c(list(x=x,y=y),list(k=k,h=h)))

names(df_mcp)
## forming the data.frame
df_mcp_man <- df_mcp %>% dplyr::mutate(k=k,h=h) %>%
	dplyr::mutate(plaina=plaina(alpha,yn,k,h)) %>%
	dplyr::mutate(y_man=y(alpha,xn,k,h)) %>%
	dplyr::mutate(resa=plaina-biden.aggp) %>%
	dplyr::mutate(resm=y_man-biden.mailp) %>%
	dplyr::mutate(zeta=(xn-alpha)/(alpha-yn)) %>%
 	tidyr::pivot_longer(c(plaina,y_man))

regagg <- dplyr::filter(df_mcp_man,name%in%c('plaina'))
regmail <- dplyr::filter(df_mcp_man,name%in%c('y_man'))
foragg <- 'y ~ x'
formail <- 'y ~ x'
#view(regagg)
pagg  <- ggplot2::ggplot(regagg,ggplot2::aes(x=biden.aggp,y=value)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method='lm',formula=foragg) +
  ggpmisc::stat_poly_eq(formula = foragg,
               ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),rr.digits=10,
               parse = T) +
  ggplot2::labs(y='biden.aggp regression')

pmail <- ggplot2::ggplot(regmail,ggplot2::aes(x=biden.mailp,y=value)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method='lm',formula=formail) +
  ggpmisc::stat_poly_eq(formula = formail,
                        ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),rr.digits=10,
                        parse = T) + ggplot2::labs(y='biden.aggp regression') +
ggplot2::labs(y='biden.mailp regression')
### output (saveed to excel)
sheets <- list("phase1" =df_mcp_man)
writexl::write_xlsx(sheets, paste0('maricopareplicationplane.xlsx'))
###############################################################################
# phase ii: finding the aggregates
pol_order <- 7

df_mcp_pol <- df_mcp_man %>%   tidyr::pivot_wider() %>%
  dplyr::arrange(biden.aggp) %>%
  dplyr::mutate(quantile=dplyr::row_number(biden.aggp)/max(row_number())) %>%
  dplyr::select(quantile,dplyr::everything())

polr <- polynom::polynomial(unname(coef(lm(df_mcp_pol$biden.aggp ~ poly(df_mcp_pol$quantile,pol_order, raw = T)))))
polr[1] <- 0.1 # can be adjusted to change biden's percentage (note: so far this
#not update the plot)
bidpre <- round(polynom::integral(polr,c(0,1)),digits=4)
forpol <- y ~ poly(x,pol_order, raw = t)

p7poly <- ggplot2::ggplot(df_mcp_pol,ggplot2::aes(x=quantile,y=biden.aggp)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method = "lm", formula=forpol) +
  ggpmisc::stat_poly_eq(formula = forpol,ggplot2::aes(label = paste(..eq.label.., ..rr.label..,sep = "~~~")),rr.digits=6,parse = T) +
  ggplot2::labs(caption = paste0("biden's aggregate: ",bidpre))
###############################################################################
# plotting the results
## ggplot
g <- gridExtra::grid.arrange(pagg,pmail,p7poly)
### saves plot as combined png file
ggplot2::ggsave(file='maricopa_all.png',g,width = 4, height = 3)
###############################################################################
## plotly
subplot(pagg,pmail,p7poly)
#view(df_mcp_pol)
names(df_mcp_pol)
xn <- df_mcp_pol$biden.edvp
yn <- df_mcp_pol$biden.mailp
zn <- df_mcp_pol$biden.aggp
plotly::plot_ly(x=xn,y=yn,z=zn,type="scatter3d", mode="markers")
###############################################################################
