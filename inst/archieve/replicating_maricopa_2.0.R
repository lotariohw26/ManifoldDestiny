###############################################################################
# Version 2.0
# Replication of Ed Solomon's results from Maricopa County, Arizona
# https://docs.google.com/document/d/1-9qbBtTqiGlAurJjEbtVt6lBUi9MKTqPR-xb3FpHx-A/edit#
# https://coderwall.com/p/elfkaq/editing-google-docs-with-vim
# https://docs.google.com/spreadsheets/d/1R78hoPiP_sleD3L7QtvuE5R-3kf2Xob20bMXQeChke8/edit#gid=173566074
# https://docs.google.com/document/d/1u8XTDJsyYVFOyuOly1Xs6XjOAAdKFW88C7q624lpAz4
###############################################################################
###############################################################################
library(tidyr)
library(ggpmisc)
library(dplyr)
library(plotly)
library(readxl)
#source('../../../R/algofunctions.R')
###############################################################################
### Readling all data
# [1] 0
maricopa_all <- readxl::read_excel("../inst/Maricopa Plane Equation_F.xlsx", sheet = "Real Time Formula With Phantom")

maricopa_sel <- maricopa_all[,c(3:14)]
names(maricopa_sel) <- c("pre","name","pha","reg","t1","psiEDV","a","b","c","c_pre","d","d_pr")
###############################################################################
### Section IIa, Maricopa County, 2020 General Election ###
###############################################################################
## Parameters
k <- 0.10
h <- -0.0282354516396
c1 <- -0.01697492739
c2 <- -0.0004257444945
c3 <- 0.01748748055
n1 <- 0.1085578029
n2 <- -0.08071453717
n3 <- -0.0007176302672
d0 <- -5.74941
d1 <- 0.89712
d2 <- 26.48059
k3 <- -0.00171219
k2 <- 0.04849797
k1 <- -1.07999
p1 <- -0.00215582
r1 <- 0.00027605
c0 <- -0.25819300

## Functions
y <- function(alpha,x,k,h) eval(parse(text='(alpha-k*x-h)/(1-k*x)'),c(list(alpha=alpha,x=x),list(k=k,h=h)))
alhpa_f <- function(x,y,k,h) eval(parse(text='y-k*x*y+k*x+h'),c(list(x=x,y=y),list(k=k,h=h)))
yh <- function(alpha,x,k,h,c1,c2,c3,d1,d2,d3) eval(parse(text='(alpha-k*x-h)/(1-k*x)-(c1*alpha^2+c2*alpha^1+c3*alpha^0)+
                                                         -(n1*x^2+n2*x^1+n3*x^0)'),
                                                   c(list(alpha=alpha,x=x),list(k=k,h=h,c1=c1,c2=c2,c3=c3,n1=n1,n2=n2,n3=n3)))
epsh <- function(Psi,zeta_mh,pha,reg,R,d0,d1,d2,k3,k2,k1,p1,r1,c0){ eval(parse(text='d0*Psi^0 + d1*Psi^1 + d2*(1/Psi^2)+
                                          k3*zeta_mh^3+k2*zeta_mh^2+k1*zeta_mh^1+
                                          p1*pha+r1*reg+c0'),c(list(Psi=Psi,zeta_mh),list(d0=d0, d1=d1, d2=d2, k3=k3, k2=k2, k1=k1, p1=p1, r1=r1, c0=c0)))}

# (alpha-k*x-h)/(1-k*x)
# (alpha)/(1-k*x)-(-k*x-h)/(1-k*x)
# alpha - (x-alpha)/z
# zalpha/z - (x-alpha)/z
# z*alpha+alpha/z - (x)/z
# (alpha)/(1-k*x) - (-k*x-h)/(1-k*x)
# (alpha)/(1-k*x) - (-k*x-h)/(1-k*x)
# z*alpha+alpha/z - (x)/z

df_mcp <- maricopa_sel %>%
  dplyr::mutate(t1=a+b,t2=c+d,x=a/(a+b),y=c/(c+d), zeta=t2/t1, alpha=(x+y*zeta)/(zeta+1), Psi=reg/(a+b)) %>%
  # Baseline
  dplyr::mutate(y_m=y(alpha,x,k,h)) %>%
  dplyr::mutate(res_ym=y-y_m) %>%
  dplyr::mutate(zeta_m=(x-alpha)/(alpha-y_m)) %>%
  # Two parameters
  dplyr::mutate(y_mh=yh(alpha,x,k,h,c1,c2,c3,d1,d2,d2)) %>%
  dplyr::mutate(res_ymh=y-y_mh) %>%
  dplyr::mutate(zeta_mh=(x-alpha)/(alpha-y_mh)) %>%
  # Four parameters, alternativ I
  dplyr::mutate(epsh=epsh(Psi,zeta_mh,pha,reg,R,d0,d1,d2,k3,k2,k1,p1,r1,c0)) %>%
  dplyr::mutate(zeta_mo=zeta_mh+epsh) %>%
  dplyr::mutate(y_mo=alpha-(x-alpha)/zeta_mo)   %>%
  dplyr::mutate(res_ymo=y-y_mo) %>%
  dplyr::mutate(eps=zeta-zeta_mh) %>%
  dplyr::mutate(res_eps=eps-epsh) %>%
  # Four parameters, alternativ II (add later)
  # Other
  dplyr::mutate(co=t1*y_mo*zeta_mo) %>%
  dplyr::mutate(do=t1*(1-y_mo)*zeta_mo) %>%
  dplyr::mutate(t2m=zeta_mh*t1) %>%
  dplyr::mutate(diff_m=c+d-t2m) %>%
  dplyr::mutate(mivreg=co+do) %>%
  dplyr::mutate(diff_r=mivreg-t2m) %>%
  # Cumsums
  ## 1 Two
  dplyr::arrange(desc(diff_m)) %>%
  dplyr::mutate(qt_1=dplyr::row_number(desc(diff_m))/max(pre)) %>%
  dplyr::mutate(cum_diff_m=cumsum(diff_m))  %>%
  ## A2 Four
  dplyr::arrange(desc(diff_r)) %>%
  dplyr::mutate(qt_2=dplyr::row_number(desc(diff_r))/max(pre)) %>%
  dplyr::mutate(cum_diff_r=cumsum(diff_r)) %>%
  # Testing
  dplyr::mutate(zh_test=ifelse(zeta_mh<0,1,0)) %>%
  dplyr::mutate(zo_test=ifelse(zeta_mo<0,1,0)) %>%
  dplyr::select(pre,qt_1,qt_2,
                a,b,c,d,co,do,alpha,y,x,t1,t2,
                y_m,y_mh,y_mo,
                eps,
                res_ym,res_ymh,res_ymo,res_eps,
                zeta, zeta_mh, zeta_mo,
                cum_diff_r, cum_diff_m,
                zh_test,zo_test)
###############################################################################################################################################
## Plots
View(df_mcp)
#  [1] "pre"        "a"          "b"
#  [4] "c"          "d"          "co"
#  [7] "do"         "alpha"      "y"
# [10] "x"          "t1"         "t2"
# [13] "y_m"        "res_ym"     "y_mh"
# [16] "y_mo"       "res_ymh"    "zeta"
# [19] "zeta_mh"    "zeta_mo"    "zh_test"
# [22] "zo_test"    "eps"        "res_eps"
# [25] "t2_pred"    "res_t2"     "manmiv"
# [28] "diffact"    "mivreg"     "diffreg"
# [31] "cumdiffreg" "quantile"
## Plots
###############################################################################################################################################
plotr2 <- function(df=NULL,xn=NULL,yn=NULL){
  ggplot2::ggplot(data=df,aes_string(xn,yn)) + ggplot2::geom_point() +
    ggplot2::geom_smooth(method='lm',formula=y ~ x) +
    ggpmisc::stat_poly_eq(formula = y~x,
                        ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),rr.digits=10,
                        parse = TRUE)
}
resplots <- function(df=NULL,xn=NULL){
	ggplot2::ggplot(data=df,aes_string(x=xn)) + ggplot2::geom_histogram()
	#ggplot2::ggplot(df_mcp,aes(x=y,y=y_m)) + ggplot2::geom_line()
	#ggplot2::ggplot(df_mcp,aes(x=y,y=y_m)) + ggplot2::geom_qq()
}
###############################################################################################################################################
##c,d,y,e
## First
gc <- plotr2(df=df_mcp,xn='c',yn='co')
gd <- plotr2(df=df_mcp,xn='d',yn='do')
gym <- plotr2(df=df_mcp,xn='y',yn='y_m')
gymr <- resplots(df=df_mcp,x='res_ym')
gymh <- plotr2(df=df_mcp,xn='y',yn='y_mh')
gymhr <- resplots(df=df_mcp,x='res_ymh')
gymo <- plotr2(df=df_mcp,xn='y',yn='y_mo')

resplots(df=df_mcp,xn='eps')
resplots(df=df_mcp,xn='eps')
plotr2(df=df_mcp,xn='pre',yn='eps')


plotr2(df=df_mcp,xn='qt_1',yn='cum_diff_m')
plotr2(df=df_mcp,xn='qt_2',yn='cum_diff_r')
gridExtra::grid.arrange(gym,gymh,gymo)

#names(df_mcp)
#  [1] "pre"        "a"          "b"
#  [4] "c"          "d"          "co"
#  [7] "do"         "alpha"      "y"
# [10] "x"          "t1"         "t2"
# [13] "y_m"        "res_ym"     "y_mh"
# [16] "y_mo"       "res_ymh"    "zeta"
# [19] "zeta_mh"    "zeta_mo"    "eps"
# [22] "res_eps"    "t2_pred"    "res_t2"
# [25] "manmiv"     "diffact"    "mivreg"
# [28] "diffreg"    "cumdiffreg" "quantile"
# [31] "zh_test"    "zo_test"
yn <- sample(50:75, 20, replace = TRUE)/100
xn <- sample(40:50, 20, replace = TRUE)/100
zetan <- sample(20:22, 20, replace = TRUE)
alphan <-(xn-zetan*yn)/(zetan+1)
plotly::plot_ly(x=xn,y=yn,z=zetan,type="scatter3d", mode="markers")
#(xn-zetan*yn)/(zetan+1)
#broom::tidy(lm(yn ~ xn))
