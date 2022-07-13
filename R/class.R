Countingprocess$methods(sortpre=function(poly=6,
					 sortby='alpha',
					 selvar=c('x','y','alpha')){

 srdfc <- rdfc %>%
    dplyr::select(pre,zeta,all_of(selvar)) %>%
    dplyr::arrange(sortby) %>%
    dplyr::mutate(pri=row_number()/length(pre)) %>%
    dplyr::mutate(zeta_m=mean(zeta)) %>%
    dplyr::mutate(zeta_mr=zeta-zeta_m)
    selvar %>% purrr::map(function(x,df=srdfc,p=poly){
	pred <- c(predict(lm(df[[x]] ~ poly(df$pri,p, raw=T))))
	res <- pred - df[[x]]
	data.frame(pred,res) %>% `colnames<-` (c(paste0(x,'_pred'),paste0(x,'_res')))
    }) %>% as.data.frame(.) -> predictor
  quintile <<- dplyr::bind_cols(srdfc, predictor)
})

Countingprocess$methods(riggsta=function(
  param=list(form=1,pre=c('x','alpha','y'), end=c('zeta','lambda')),
  predet=list(end1=quintile$x,
	      end2=polyc[[1]],
	      end3='x-alpha')
)
{

  forms <- list('_s','o_h','h_o')[param$form[[1]]]
  ends1 <- se[[paste0(param$end[1],forms)]][2]
  ends2 <- se[[paste0(param$end[2],forms)]][2]
  
  parampre <- data.frame(pri=quintile$pri) %>%
    # Presetting the first three parameters
    dplyr::mutate(!!param$pre[1]:=predet[[1]]) %>%
    dplyr::mutate(!!param$pre[2]:=predict(polynom::polynomial(predet$end2),quintile$pri)) %>%
    dplyr::mutate(!!param$pre[3]:=pareq(predet[[3]],lv=as.list(.[,param$pre[1:2]]))) %>% 
    # Backsolving for the two remaining parameters
    dplyr::mutate(!!param$end[1]:=pareq(ends1,lv=as.list(.[,param$pre[1:3]]))) %>%
    dplyr::mutate(!!param$end[2]:=pareq(ends2,lv=as.list(.[,c(param$end[1],param$pre[1:3])])))
  
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
Countinggraphs$methods(resplot=function(resvar=c("zeta_mr","alpha_res"),crossp=F){

  plotv <- list(resvar,c('pri','crossp'))[[ifelse(crossp==F,1,2)]]
  dfgp <- quintile %>% dplyr::select(pri,all_of(resvar)) %>% 
	  dplyr::mutate(crossp=quintile[[resvar[1]]]*quintile[[resvar[2]]])

  ggplot2::ggplot(data=dfgp,aes_string(x=plotv[1],y=plotv[2])) +
    geom_smooth(method="lm", se=F) +
    geom_point() +
    stat_regline_equation(label.y = 0.05, aes(label = ..eq.label..)) +
    stat_regline_equation(label.y = 0.0, aes(label = ..rr.label..))
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
})
Estimation$methods(estimation=function(selvar=c('x','y','alpha')){

	#rsq <- function(x, y) summary(lm(y~x))$r.squared
	#k <- c(1.57874563,-0.5819051755,0.001519026359)
	#ge <- eval(parse(text='k[1]*alpha+k[2]*h+k[3]'),list(alpha=1,h=1,k=k))
	#edfc <<- sdfc %>% dplyr::mutate(gpred=gp(alpha,h,k)) %>% dplyr::mutate(rsq=rsq(g,gpred))
})

