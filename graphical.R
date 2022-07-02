library(dplyr)
library(ggplot2)
library(tidyr)
library(purrr)
setwd(rprojroot::find_rstudio_root_file())
source('R/misc.R')
source('R/class.R')
# Inititating
agebracketmax <- c(18,100,1000)
regf <- 0.8
numprec <- 200
vrdf <- Voterdatabase(agebracketmax,numprec,regf,namebase='default',newdraw=T)
###### Realization of DGP
probwset <- c(0.50,0.05)
probvset <- list(c(0.70,0.30,0.00),c(0.30,0.70,0.00))
Znr <- c(0,1)
vrdf$realizedgp(probv=probvset,Ztech=Znr)
votr <- vrdf$voterrollrealized
vrdf <- Voterdatabase(agebracketmax,numprec,regf,namebase='default',newdraw=T)
vrdf$realizedgp(probv=probvset,Ztech=Znr)
gcou <- Countinggraphs(votr)
gcou$sortpre()
combi <- combinat::combn(5, 3)
v <- seq(1,dim(combi)[2])
sdfc <- gcou$sdfc %>% dplyr::select(x,y,alpha,lambda,zeta,lambda)
v%>% purrr::map(function(x,comb=combi,df=sdfc){
		gdf <- df %>% dplyr::select(combi[,x])
		mrdfc <- as.matrix(gdf)
		x <- mrdfc[,1]
		y <- mrdfc[,2]
		z <- mrdfc[,3]
		plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers") %>%
	        plotly::layout(scene = list(xaxis = list(title = names(gdf)[1]),
                     yaxis = list(title = names(gdf)[2]),
                     zaxis = list(title = names(gdf)[3])))
}) -> og
og[1]
library(htmltools)
htmltools::browsable(div(
  style = "display: flex; flex-wrap: wrap; justify-content: center",
  div(og[1], style = "width: 40%; border: solid;"),
  div(og[2], style = "width: 40%; border: solid;"),
  div(og[3], style = "width: 40%; border: solid;"),
  div(og[4], style = "width: 40%; border: solid;"),
  div(og[5], style = "width: 40%; border: solid;"),
  div(og[6], style = "width: 40%; border: solid;"),
  div(og[7], style = "width: 40%; border: solid;"),
  div(og[8], style = "width: 40%; border: solid;"),
  div(og[9], style = "width: 40%; border: solid;"),
  div(og[10], style = "width: 40%; border: solid;")
))

abc <- function(){
h <- div(class="row", style = "display: flex; flex-wrap: wrap; justify-content: center",
	 div(og[1:5], class="column"),
	 div(og[6:10],class="column")
htmltools::browsable(h)
}

