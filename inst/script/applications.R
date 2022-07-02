library(dplyr)
library(ggplot2)
library(ManifoldDestiny) 
library(tidyr)
library(purrr)
library(randNames)
library(openxlsx)
library(patchwork)
library(writexl)
library(plotly)
library(ViewPipeSteps)
library(ggpubr)
source('../../R/misc.R')
source('../../R/class.R')
#library(ManifoldDestiny)
#### I: Initial voterdatabase ###
#load("~/research/ManifoldDestiny/data/washoe_sel.rda")
#votr  <- maricopa_sel
#votr  <- clark_sel # 
#votr  <- nevada_sel #
#votr  <- dallas_sel
#################################################################################################
#################################################################################################
# Clark
### Tab1
#ge <- parse(text='k1*alpha+k2*h+k3')
#load("~/research/ManifoldDestiny/data/clark_sel.rda")
#str(clark_sel)
#est_clark  <- Estimation(clark_sel)j
#est_clark$rotation()
#est_clark$estimation()
#est_clark$plotxy()
### Tabuuu###############################################################################
#load("~/Research/ManifoldDestiny/data/nevada_sel.rda")
##################################################################################################
# Maricopa
#load("~/research/ManifoldDestiny/data/maricopa_sel.rda")
#str(maricopa_sel)
#est_maricopa  <- Estimation(maricopa_sel)
#est_maricopa$plotly3d(selvar=c('x','y','alpha'))
#est_maricopa$plotly3d(selvar=c('g','h','alpha'))
#sdfinp; l()
#gcou$sortpre(6,'alpha')
#################################################################################################33
# Texas
load("~/research/ManifoldDestiny/data/dallas_sel.rda")
str(dallas_sel)
#est_dallas  <- Estimation(dallas_sel)
#
#
#
#est_dallas$rotation()
##View(est_dallas$sdfc)
#est_dallas$sortpre(poly=6)
#est_dallas$plot2d(selvp=c("x","y","alpha"),selvl="alpha_pred")
#est_dallas$plotly3d()
#cor(est_dallas$quintile$alpha_pred,est_dallas$quintile$alpha)^2
#################################################################################################33
vrdf <- Estimation(dallas_sel)
#### Step 1: Inspect visually

#### Step 2: Rotation matrix
## a)

## B)

#### Step 3: Regression

#### Step 4: Prediction














### A) Fair ###
#### Tab0
gcou$plotxy(c("x","y"))
#### Tab1
gquil <- gcou$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
gzeta <- gcou$plot2d(selvp=c("zeta"),selvl='zeta_m')
ggarrange(gquil,gzeta,ncol = 1, nrow = 2, align = "v")
#### Tab2
gcou$plot2d()
#### Tab2 
gcou$resplot(resvar=c('zeta_r','alpha_res'))
#### Tab3 
gcou$resplot(resvar=c('zeta_r','y_res'))
#### Tab4 
gcou$resplot(resvar=c('zeta_r','y_res'))
#### Tab5 
gcou$trplot(selvar=c('x','y','alpha'))
gcou$trplot(selvar=c('g','h','alpha'))
gcou$trplot(selvar=c('m','n','alpha'))
###############################################################################
### B) Rigged ###
### Tab1
gcou$plotxy(c("pri","lambda"))
kc <- c(1.57874563,-0.5819051755,0.001519026359)
#gp <- function(df=NULL,kc=NULL){kc[1]*df$alpha+kc[2]*df$h+k[3]}
gp <- function(alpha,h,kc){
	alpha*kc[1]+h*kc[2]+kc[3]
}
pip <- gcou$sdfc %>% dplyr::mutate(gpred=gp(alpha,h,kc)) %>% dplyr::select(pri,gpred,g)
plot(pip$gpred,pip$g)
cor(pip$gpred,pip$g)
###############################################################################
###############################################################################
library(tidyr)
library(ggpmisc)
library(dplyr)
library(plotly)
df_mcp <- openxlsx::read.xlsx('../../data-raw/xlsx/maricopareplicationplane.xlsx') %>% dplyr::select(2:10)
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
               ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),rr.digits=10,parse = TRUE) +
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

polr <- polynom::polynomial(unname(coef(lm(df_mcp_pol$biden.aggp ~ poly(df_mcp_pol$quantile,pol_order, raw = t)))))
polr[1] <- 0.1 # can be adjusted to change biden's percentage (note: so far this
#not update the plot)
bidpre <- round(polynom::integral(polr,c(0,1)),digits=4)
forpol <- y ~ poly(x,pol_order, raw = t)

p7poly <- ggplot2::ggplot(df_mcp_pol,ggplot2::aes(x=quantile,y=biden.aggp)) + ggplot2::geom_point() +
  ggplot2::geom_smooth(method = "lm", formula=forpol) +
  ggpmisc::stat_poly_eq(formula = forpol,ggplot2::aes(label = paste(..eq.label.., ..rr.label..,sep = "~~~")),rr.digits=6,parse = true) +
  ggplot2::labs(caption = paste0("biden's aggregate: ",bidpre))
###############################################################################
# plotting the results
## ggplot
g <- gridextra::grid.arrange(pagg,pmail,p7poly)
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
