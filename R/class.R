##########################################################################################################################################################
##########################################################################################################################################################
#' @export pareq
pareq <- function(ste='(x + y*zeta)/(zeta + 1)',lv=list(x=0.75,y=0.25,zeta=1))
{
	eval(parse(text=ste),lv)
}
############################################################################################################################################################
###########################################################################################################################################################
#' @export Voterdatabase
Voterdatabase <- setRefClass("Voterdatabase", fields=list(voterrolldatabase='data.frame',
							  voterrollrealized='data.frame',
							  totpop='matrix',agebrack='vector'))
Voterdatabase$methods(initialize=function(agebracketmax=c(18,100,30),
					  nprect=5,
					  reg=0.80,
					  namebase='default',
					  newdraw=T
					  ){


    filn <- paste0('voterbase/',namebase)
    if(newdraw == T) {
    # Demograhpic structure
    agelength <- agebracketmax[2]-agebracketmax[1]
    brack <- seq(agebracketmax[1],agebracketmax[2])
    halflength <- agelength/2  #! should be changed
    earlpop <- matrix(1,agebracketmax[3],halflength)
    stlate <- halflength+1
    enlate <- length(brack)
    ## Making decreasing rate of voters belonging to older age groups
    latepop <- seq(stlate,enlate) %>% purrr::map_dfc(function(x,maxp=agebracketmax[3])
          	{
          		cf <-maxp/(enlate-stlate)
          		one <- floor(maxp-cf*(x-stlate))
          		zero <- maxp-one
    		matrix(c(rep(0,zero),rep(1,one)))
        		}) %>% as.matrix()
    colnames(latepop) <- NULL

    # Total Population
    totpop <<- cbind(earlpop,latepop)
    agebrack <<- agebracketmax
    # Desc statistics
    popvotgro <- colSums(totpop)           # Population for each age group
    popsize <- sum(popvotgro) 	         # Total number of citizien
    probage <- popvotgro/popsize 	         # Probability for each age group
    precv <- sample(nprect,size=popsize,T) # Allocated to various precincts (uniform?)

    # Registration
    rvot <- sample(seq(1,popsize),size=popsize*reg,F) # Registered voters

    # Allocation
    precv <-sample(nprect,size=popsize,T) # Allocated to various precincts (uniform)

    # Realvoters
    #sci <- 500; hc <- floor(popsize/sci); resnr <- c(rep(sci,hc),popsize-sci*hc)
    #voterrolldatabase <<- resnr %>% purrr::map_df(randNames::rand_names,nationality="US") %>%
    #dplyr::select(gender,name.first,name.last) %>%
    # Id-number for voters
    voterrolldatabase <<- data.frame(idn=seq(1:popsize)) %>%
      dplyr::mutate(status='real') %>%
      # Age being assigned to citizien making up the population
      dplyr::mutate(age=as.vector(wakefield::age(n(),x=seq(agebrack[1],agebrack[2]),prob=probage))) %>%
      # Assigned to different precincts
      dplyr::mutate(pre=sample(nprect,size=n(),replace=T)) %>%
      dplyr::arrange(pre) %>%
      # Assigned whether citizien register to vote or not
      dplyr::mutate(registered=ifelse(idn%in%rvot,1,0)) %>%
      # Assigned whether citizien register to vote or not
      dplyr::mutate(registered=ifelse(idn%in%rvot,1,0))
      usethis::use_data(voterrolldatabase, overwrite = TRUE)
    } else {
      rotp <- rprojroot::find_rstudio_root_file()
      defl <- paste0(rotp,'/data/default.rda')
      load(defl)
      voterrolldatabase <<-  voterrolldatabase
    }
})
Voterdatabase$methods(load=function(database='initial'){


	print('test')
})

Voterdatabase$methods(realizedgp=function(probv=list(c(0.70,0.30,0.00),
						     c(0.30,0.70,0.00)),
					  probw=c(0.50,0.05),
                                          Ztech=c(0,1),
                                          tvoting=c('EDV','MIV')){

  nprect <- max(voterrolldatabase$pre)
  ## Election Technology and voter sentiment
  ztech <- data.frame(pre=seq(1,nprect)) %>%
	  dplyr::mutate(probwd=rnorm(nprect,probw[1],probw[2])) %>%
	  dplyr::mutate(Zt=runif(n(), min=Ztech[1], max=Ztech[2])) %>%
          dplyr::mutate(p1=probv[[1]][1]) %>%
          dplyr::mutate(p2=probv[[1]][2]+probv[[1]][3]*Zt) %>%
          dplyr::mutate(p3=probv[[1]][3]*(1-Zt)) %>%
          dplyr::mutate(p4=probv[[2]][1]) %>%
          dplyr::mutate(p5=probv[[2]][2]+probv[[2]][3]*Zt) %>%
          dplyr::mutate(p6=probv[[2]][3]*(1-Zt))

  ## Technology
  voterrollrealized <<- voterrolldatabase %>% dplyr::left_join(ztech, by="pre") %>%
	  base::split(.$pre) %>%
  purrr::map(function(x){
  x %>%  dplyr::mutate(candraw=rbinom(n(),1,probwd)) %>%
	 dplyr::mutate(voted=ifelse(candraw==1,
      		      sample(1:3,size=n(),prob=c(x$p1[1],x$p2[1],x$p3[1]),T),
      		      sample(4:6,size=n(),prob=c(x$p4[1],x$p5[1],x$p6[1]),T)))
  }) %>%
  dplyr::bind_rows(.) %>%
  dplyr::mutate(a=ifelse(voted==1,1,0)) %>%
  dplyr::mutate(c=ifelse(voted==2,1,0)) %>%
  dplyr::mutate(b=ifelse(voted==4,1,0)) %>%
  dplyr::mutate(d=ifelse(voted==5,1,0)) %>%
  dplyr::mutate(regvoted=ifelse(voted==3 | voted==6,0,1)) %>%
  dplyr::mutate(status=ifelse(regvoted==0,'credit','active')) %>%
  dplyr::arrange(desc(status),pi)
})
#' @export Grafbase
Grafbase <- setRefClass("Grafbase", contains = c('Voterdatabase'), fields = list(def='list'))
#' @export Tablebase
Tablebase <- setRefClass("Tablebase", contains = c('Voterdatabase'), fields = list(ghi='list'))
############################################################################################################################################################
#' @export Countingprocess
#' @export class Countingprocess
Countingprocess <- setRefClass("Countingprocess", fields=list(sdfc='data.frame',rdfc='data.frame',quintile='data.frame',pardf='data.frame', polyc='list',parameters='list', se='list',lx='list',plot3dlist='list'))
Countingprocess$methods(initialize=function(sdfinp=NULL,polyn=6,sortby=alpha){

  
  # Loading 
  rotp <- rprojroot::find_rstudio_root_file()
  load(paste0(rotp,'/data/eqpar.rda'))
  load(paste0(rotp,'/data/stickers.rda'))
  
  # Assigning parameters 
  parameters <<- labels[['parameters']]

  # Assigning model equations
  #pareqs <<- eqpar
  se <<- eqpar$meqs
  lx <<- eqpar$meql
 
  sdfc <<- sdfinp %>% dplyr::select(pre,a,b,c,d) %>% dplyr::group_by(pre) %>%
    dplyr::arrange(pre) %>% dplyr::mutate(a=sum(a),b=sum(b),c=sum(c),d=sum(d)) %>%
    dplyr::ungroup() %>% dplyr::distinct() %>%
    #dplyr::filter(a>0) %>%
    #dplyr::filter(b>0) %>%
    #dplyr::filter(c>0) %>%
    #dplyr::filter(d>0) %>% 
    dplyr::mutate(x=pareq(se[['x_s']][1],lv=list(a=a,b=b,c=c,d=d))) %>%
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

  rdfc <<- sdfc %>% dplyr::arrange(alpha) %>% dplyr::mutate(pri=row_number()/length(pre))

  # Init values standard form
  polyc[[1]] <<- unname(coef(lm(rdfc$alpha ~ poly(rdfc$pri, polyn, raw=TRUE))))
  # Init values hybrid form
  #polyc[[2]] <<- unname(coef(lm(sdfc$alpha ~ poly(sdfc$pri, polyn, raw=TRUE))))
  ### Init values opposition form
  #polyc[[3]] <<- unname(coef(lm(sdfc$alpha ~ poly(sdfc$pri, polyn, raw=TRUE))))
  ### Init poly
})

Countingprocess$methods(sortpre=function(poly=6,sortby='alpha',selvar=c('x','y','alpha','lambda','zeta')){

 srdfc <- rdfc %>%
    dplyr::select(pre,zeta,all_of(selvar)) %>%
    dplyr::arrange(sortby) %>%
    dplyr::mutate(pri=row_number()/length(pre)) %>%
    dplyr::mutate(zeta_m=mean(zeta)) %>%
    dplyr::mutate(zeta_r=zeta-zeta_m)
    selvar %>% purrr::map(function(x,df=srdfc,p=poly){
	pred <- c(predict(lm(df[[x]] ~ poly(df$pri,p, raw=T))))
	res <- pred - df[[x]]
	data.frame(pred,res) %>% `colnames<-` (c(paste0(x,'_pred'),paste0(x,'_res')))
    }) %>% as.data.frame(.) -> predictor
  quintile <<- dplyr::bind_cols(srdfc, predictor)
})
Countingprocess$methods(riggsta=function(
  param=list(form=1,pre=c('x','alpha','y'), end=c('zeta','lambda')),
  predet=list(end1=quintile$x,end2=polyc[[1]],end3='x-alpha')
)
{
	browser()
  ends1 <- se[[paste0(param$end[1],'_s')]][2]
  ends2 <- se[[paste0(param$end[2],'_s')]][2]

  parampre <- data.frame(pri=quintile$pri) %>% 
  # Presetting three parameters
    dplyr::mutate(!!param$pre[1]:=predet[[1]]) %>%
    dplyr::mutate(!!param$pre[2]:=predict(polynom::polynomial(predet$end2),quintile$pri)) %>%
    dplyr::mutate(!!param$pre[3]:=pareq(predet[[3]],lv=list(x=x,alpha=alpha))) %>%
  # Backsolving for the two remaining parameters
    dplyr::mutate(!!param$end[1]:=pareq(ends1,lv=list(x=x,alpha=alpha,y=y))) %>%
    dplyr::mutate(!!param$end[2]:=pareq(ends2,lv=list(x=x,zeta=zeta,y=y))) 
    #dplyr::rename_all(paste0, "_st")
  rdfc[,c(param$pre,param$end)] <<- parampre[,-1]
})
Countingprocess$methods(rigghyp=function(sdfinp=NULL){
  # Init values standard form
  k <- function(alpha,x,k,h) eval(parse(text=formula,c(list(alpha=alpha,x=x),list(k=k,h=h))))
  rdfc <<- sdfc %>% dplyr::select(pri,pre,alpha,x,y)
})
Countingprocess$methods(riggopo=function(sdfinp=NULL){
  # Init values standard form
  n <- function(alpha,x,k,h) eval(parse(text=formula,c(list(alpha=alpha,x=x),list(k=k,h=h))))
  rdfc <<- sdfc %>% dplyr::select(pri,pre,alpha,x,y)
})
#' @export Countinggraphs
Countinggraphs <- setRefClass("Countinggraphs", contains = c('Countingprocess'))
Countinggraphs$methods(plot2d=function(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred")){
    
  titext <- paste0(polynom::polynomial(polyc[[1]]),' with R²=',cor(quintile$alpha_pred,quintile$alpha)^2
)
  longdf <- tidyr::pivot_longer(quintile,all_of(c(selvp,selvl)))
  ggplot2::ggplot(data=longdf) +
    geom_line(data=filter(longdf,name%in%selvl),aes(x=pri,y=value, color=name)) +
    geom_point(data=filter(longdf,name%in%selvp),aes(x=pri,y=value, color=name)) +
    labs(x='precinct (normalized)',y='probability',title=titext) +
    ggplot2::theme_bw()
})
Countinggraphs$methods(plotxy=function(selv=c("x","y")){

    widedf <- sdfc
    ggplot2::ggplot(data=widedf,aes_string(x=selv[1],y=selv[2])) +
	geom_point() +
	geom_smooth(method=lm,se=F) +
        #ggpubr::stat_regline_equation(label.x=0,label.y=0.10) +
        ggpubr::stat_cor() +
   	labs(x=selv[1],y=selv[2],title="") +
    	ggplot2::theme_bw()
})
Countinggraphs$methods(resplot=function(resvar=c("zeta_r","alpha_res")){

  x <- quintile[paste0(resvar[1])]
  y <- quintile[paste0(resvar[2])]
  quintile$z <<- x*y
  ggplot2::ggplot(data=quintile,aes_string(resvar[1],resvar[2])) +
    geom_smooth(method="lm") +
    geom_point() +
    stat_regline_equation(label.x=0,label.y=0.10) +
    stat_cor(label.x=0,label.y=0.15) +
    ggplot2::theme_bw()
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
  zaxis = list(title = names(gdf)[3]))) }) ->> plot3dlist

  ohtml <- div(class="row", style = "display: flex; flex-wrap: wrap; justify-content: center",
  	 div(plot3dlist[sel[[1]]], class="column"),
  	 div(plot3dlist[sel[[2]]],class="column"))
  list(page=htmltools::browsable(ohtml),ohtml=ohtml,one=plot3dlist[[selid]])
})
#' @exportClass Countingtables
Countingtables <- setRefClass("Countingtables", contains = c('Countingprocess'), fields = list(ghi='list'))



############################################################################################################################################################
#' A class description
#' @export Estimation
Estimation <- setRefClass("Estimation", fields=list(
						sdfc='data.frame',
						rdfc='data.frame',
						quintile='data.frame',
						parameters='list',
						plot3dlist='list'
						))
Estimation$methods(initialize=function(
					rdfcinp=NULL
					  ){

  parameters <<- list(standard=c("x","y","alpha","zeta","lambda"),
  		      hybrid=c("g","h","Omega","lambda","xi"),
		      opposition=c("m","n","Omega","xi","lambda"))

  sdfc <<- rdfcinp
})
Estimation$methods(rotation=function(
				     selvar=c('x','y','alpha'),
				     angles=list(tgrad=c(-41.771547,0,0)),
				     sli=list(depth=0.01,divi=0.02,shift=50,slide=-49)
				     ){
  browser()
  
  ra <- circular::rad(angles$tgrad)
  rdfc <<- sdfc[1:741,] %>% dplyr::select(selvar) %>%
  dplyr::mutate(rxy=ra[1]) %>%
  dplyr::mutate(cosxy=cos(rxy)) %>%
  dplyr::mutate(sinxy=sin(rxy)) %>%
  dplyr::mutate(ryz=ra[2]) %>%
  dplyr::mutate(cosyz=cos(ryz)) %>%
  dplyr::mutate(sinyz=sin(ryz)) %>%
  dplyr::mutate(rzx=ra[3]) %>%
  dplyr::mutate(coszx=cos(rzx)) %>%
  dplyr::mutate(sinzx=sin(rzx)) %>%
  dplyr::mutate(u=cosxy*y-sinxy*x) %>%
  dplyr::mutate(v=sinxy*y+cosxy*x) %>%
  dplyr::mutate(w=sinyz*v+cosyz*alpha) %>%
  dplyr::arrange(v)
  rdfc; l()


  plot(rdfc$u,rdfc$w)

  dplyr::mutate(rank_v=dense_rank(v)) %>%
  dplyr::mutate(slide=floor((v+sli$depth*sli$divi*sli$shift)/sli$depth)) %>%
  dplyr::mutate(slide_norm=slide-sli$slide+1) %>%
  dplyr::mutate(carry_slide_norm=1000*rank_v+slide_norm,
  	      carry_v=1000*rank_v+v,
  	      carry_u=1000*rank_v+u,
  	      carry_w=1000*rank_v+w) %>%
  dplyr::mutate(index=row_number()) %>%
  dplyr::mutate(sort_slide_norm=sort(carry_slide_norm)) %>%
  dplyr::mutate(sort_v=sort(carry_v),
                sort_u=sort(carry_u),
                sort_w=sort(carry_w)) %>%
  dplyr::mutate(drop_s=sort_slide_norm-1000*index+sli$slide-1,
               drop_v=sort_v-1000*index,
               drop_u=sort_u-1000*index,
               drop_w=sort_w-1000*index) %>%
  dplyr::mutate(fat_slide=ifelse(drop_s<=9,-1000,ifelse(drop_s>100,1000,drop_s)),
                partition_rank=rank(fat_slide),
                true_rank=rank(partition_rank))
  View(rdfc)

  View(t)

})

Estimation$methods(estimation=function(selvar=c('x','y','alpha')){

	#rsq <- function(x, y) summary(lm(y~x))$r.squared
	#k <- c(1.57874563,-0.5819051755,0.001519026359)
	#ge <- eval(parse(text='k[1]*alpha+k[2]*h+k[3]'),list(alpha=1,h=1,k=k))
	#edfc <<- sdfc %>% dplyr::mutate(gpred=gp(alpha,h,k)) %>% dplyr::mutate(rsq=rsq(g,gpred))
})

