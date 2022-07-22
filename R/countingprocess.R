#' @export pareq
pareq <- function(ste='(x + y*zeta)/(zeta + 1)',lv=list(x=0.75,y=0.25,zeta=1))eval(parse(text=ste),lv)

#' @export pareq2
pareq2 <- function(ste=NULL,lv=NULL)eval(parse(text=ste),lv)
############################################################################################################################################################
############################################################################################################################################################
#' @export Countingprocess
#' @export class Countingprocess
Countingprocess <- setRefClass("Countingprocess", 
			       fields=list(sdfc='data.frame',
					   rdfc='data.frame',
					   quintile='data.frame',
					   sumreg='list', 
					   polyc='list',
					   parameters='list', 
					   preend='list', 
					   parampre='data.frame', 
					   se='list',
					   lx='list',
					   pl_2dsort='list',
					   pl_corrxy='list',
					   pl_rescro='list',
					   pl_3dmani='list'))
Countingprocess$methods(initialize=function(sdfinp=NULL,
					   selvar=c('R','a','b','c','d'), 
					   polyn=6,
					   sortby=alpha
					   ){

  # Loading 
  rotp <- rprojroot::find_rstudio_root_file()
  load(paste0(rotp,'/data/eqpar.rda'))
  load(paste0(rotp,'/data/stickers.rda'))

  # Assigning parameters 
  parameters <<- stickers[['parameters']]
  # Assigning model equations
  se <<- eqpar$meqs
  lx <<- eqpar$meql

  ils <- c('a','b','c','d')
  sdfc <<- sdfinp %>% 
    dplyr::select(P,all_of(selvar)) %>% 
    dplyr::arrange(P) %>% 
    #!
    #dplyr::group_by(P) %>%
    #dplyr::mutate(a=sum(a),b=sum(b),c=sum(c),d=sum(d)) 
    #dplyr::mutate(R=sum(R)) %>% 
    #dplyr::distinct() %>%
    #dplyr::ungroup() %>% 
    ##dplyr::filter(a>0) %>%
    #dplyr::filter(b>0) %>%
    #dplyr::filter(c>0) %>%
    #dplyr::filter(d>0) %>% 
    dplyr::mutate(V=a+b+c+d) %>%
    dplyr::mutate(C=R-V) %>%
    dplyr::mutate(x=pareq(se[['x_s']][1],lv=as.list(.[,ils]))) %>%
    dplyr::mutate(y=pareq(se[['y_s']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(g=pareq(se[['g_h']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(h=pareq(se[['h_h']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(m=pareq(se[['m_o']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(n=pareq(se[['n_o']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(alpha=pareq(se[['alpha_s']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(zeta=pareq(se[['zeta_s']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(lambda=pareq(se[['lambda_s']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(Omega=pareq(se[['Omega_h']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(Gamma=pareq(se[['Gamma_h']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    dplyr::mutate(xi=pareq(se[['xi_o']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
    na.omit()  

    rdfc <<- sdfc %>% dplyr::arrange(alpha) %>% dplyr::mutate(pri=row_number()/length(P)) %>%
      dplyr::relocate(pri,.before=P) %>%
      dplyr::relocate(V,.after=C)
  
  # Init values standard form
  polyc[['alpha']] <<- lm(rdfc$alpha ~ poly(rdfc$pri, polyn, raw=TRUE))
  # Init values hybrid form
  #polyc[[2]] <<- unname(coef(lm(sdfc$alpha ~ poly(sdfc$pri, polyn, raw=TRUE))))
  ### Init values opposition form
  #polyc[[3]] <<- unname(coef(lm(sdfc$alpha ~ poly(sdfc$pri, polyn, raw=TRUE))))
  ### Init poly
})
Countingprocess$methods(sortpre=function(poly=6,
					 sortby='alpha',
					 selvar=c('x','y','alpha')){

  srdfc <- rdfc %>%
    dplyr::select(P,zeta,all_of(selvar)) %>%
    dplyr::arrange(sortby) %>%
    dplyr::mutate(pri=row_number()/length(P)) %>%
    dplyr::mutate(zeta_m=mean(zeta)) %>%
    dplyr::mutate(zeta_mr=zeta-zeta_m)
    selvar %>% purrr::map(function(x,df=srdfc,p=poly){
	pred <- c(predict(lm(df[[x]] ~ poly(df$pri,p, raw=T))))
	res <- pred - df[[x]]
	data.frame(pred,res) %>% `colnames<-` (c(paste0(x,'_pred'),paste0(x,'_res')))
    }) %>% as.data.frame(.) -> predictor
  quintile <<- dplyr::bind_cols(srdfc, predictor)

  rcte <- polynom::polynomial(unname(coef(polyc[['alpha']])))
  rcr2 <- round(cor(quintile$alpha_pred,quintile$alpha)^2,4)
  sumreg['alpha'] <<- paste0(rcte,' with R² ',rcr2)
})
Countingprocess$methods(manfolimp=function(
				pres1=quintile$x, 
				pres2=quintile$alpha,  
				pres3="(alpha*zeta + alpha - x)/zeta"
					   ){
  # 1
  ##
  end1 <- pres1
  # 2
  #coef(polyc[['alpha']])
  #coef <- coefficients(polyc[[1]])
  #round(polynom::integral(coef,c(0,1)),digits=4)
  #polr <- polynom::polynomial(polyc[[1]])
  ## 
  predict(polyc[[1]])
  end2 <- pres2 
  # 3
  ## 
  #browser()
  riggreal <- pareq(pres3,as.list(rdfc[,c("x","alpha","zeta")]))
  #end1-end2
  end3 <- riggreal

  preend <<- list(end1,end2,end3)
})
Countingprocess$methods(riggsta=function(
  param=list(form=1,pre=c('x','alpha','y'), end=c('zeta','lambda')),
  predet=preend)
{
  forms <- list('_s','o_h','h_o')[param$form[[1]]]
  ends1 <- se[[paste0(param$end[1],forms)]][2]
  ends2 <- se[[paste0(param$end[2],forms)]][2]

   parset <- quintile[,c('P','pri')] %>%
   # Presetting the first three parameters
   dplyr::mutate(!!param$pre[1]:=predet[[1]]) %>%
   dplyr::mutate(!!param$pre[2]:=predet[[2]]) %>%
   dplyr::mutate(!!param$pre[3]:=predet[[3]]) %>%
   # Backsolving for the two remaining parameters
   dplyr::mutate(!!param$end[1]:=pareq(ends1,lv=as.list(.[,param$pre[1:3]]))) %>%
   dplyr::mutate(!!param$end[2]:=pareq(ends2,lv=as.list(.[,c(param$end[1],param$pre[1:3])])))
  
   rdfc[,c(param$pre,param$end)] <<- parset[,c(-1,-2)]
})
#' @export Countinggraphs
Countinggraphs <- setRefClass("Countinggraphs", contains = c('Countingprocess'))
Countinggraphs$methods(plot2d=function(selvp=c("x","y","alpha"),
				       selvl=c("x_pred","y_pred","alpha_pred"), 
    				       labs=list(x="precinct (normalized)",y=NULL,caption=NULL)
				       ){
  longdf <- tidyr::pivot_longer(quintile,all_of(c(selvp,selvl)))
  go <-   ggplot2::ggplot(data=longdf) +
    ggplot2::geom_line(data=filter(longdf,name%in%selvl),aes(x=pri,y=value, color=name)) +
    ggplot2::geom_point(data=filter(longdf,name%in%selvp),aes(x=pri,y=value, color=name)) + 
    ggplot2::labs(x=labs$x,y=labs$y,caption=labs$caption) +
    ggplot2::theme_bw()
    pl_2dsort <<- list(go)
})
Countinggraphs$methods(plotxy=function(form=1){

  dfg  <- dplyr::select(rdfc,parameters[[form]])
  cmb <- combinat::combn(3, 2)
  #pl_corrxy[1]
  pl_corrxy <<- lapply(seq(1,dim(cmb)[2]), function(x){
    ggplot2::ggplot(data=dfg,aes_string(x='x',y='y')) +
    geom_point() +
    geom_smooth(method=lm,se=F) +
    #ggpubr::stat_regline_equation(label.x=0,label.y=0.10) +
    ggpubr::stat_cor() +
    #labs(x=selv[1],y=selv[2],title="") +
    ggplot2::theme_bw()
  }) 
})
Countinggraphs$methods(resplot=function(form=1){

  dfg <- dplyr::select(quintile,zeta_m,zeta_mr,zeta,paste0(parameters[[form]][c(1,2,4)],'_res'))
  cmb <- combinat::combn(3, 2)
  pl_rescro <<- lapply(seq(1,dim(cmb)[2]), function(x){
    ggplot2::ggplot(data=dfg,aes_string(x='zeta_mr',y='y_res')) +
    ggplot2::geom_point() +
    ggplot2::geom_smooth(method="lm", se=F) 
    #ggplot2::labs(x='x',y='y',title="") 
    })
})
Countinggraphs$methods(plotly3d=function(
					 partition=1,
					 sel=list(1:5,6:10),
					 selid=1
					 ){

  rdfcpar <- rdfc %>% dplyr::select(parameters[[partition]])
  mrdfc <- as.matrix(rdfcpar)
  combi <- combinat::combn(5, 3)
  seq(1,dim(combi)[2]) %>% purrr::map(function(x,comb=combi,df=rdfcpar){
  gdf <- df %>% dplyr::select(combi[,x])
  mrdfc <- as.matrix(gdf)
  x <- mrdfc[,1]
  y <- mrdfc[,2]
  z <- mrdfc[,3]
  plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers") %>%
  plotly::layout(scene = list(xaxis = list(title = names(gdf)[1]),
  yaxis = list(title = names(gdf)[2]),
  zaxis = list(title = names(gdf)[3]))) }) ->> pl_3dmani

})
Countinggraphs$methods(gridarrange=function(
					    pl3d=list(selo=1,selm=list(1:5,6:10)), 
					    ){
  ohtml <- div(class="row", style = "display: flex; flex-wrap: wrap; justify-content: center",
    	 div(pl_3dmani[[pl3d$sel[[1]]]],class="column"),
    	 div(pl_3dmani[[pl3d$sel[[2]]]],class="column"))

  list(page=htmltools::browsable(ohtml),ohtml=ohtml,one=pl_3dmani[[pl3d$selo]])[[3]]

#' @exportClass Countingtables
Countingtables <- setRefClass("Countingtables", contains = c('Countingprocess'), fields = list(ghi='list'))
