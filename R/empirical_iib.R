votplot <-function(x,label=NULL,caption=NULL){
  captionp <- paste0('correlation (r)= ',round(unique(x$corr), digits=5))
  ggplot2::ggplot(data=x, aes(x=age,y=value,color=name)) + geom_line() + 
    ggplot2::labs(caption =captionp)
    #ggplot2::xlab('Age category') +
    #ggplot2::ylab("Number of voters")
}
histerrpred <-function(x,label=NULL){
  ggplot2::ggplot(data=x) + geom_histogram(aes(x=value)) + ggplot2::labs(title = label$title)
}
countyplot <- function(county=1,scorecard=NULL,dfinput=NULL){

  df <- dfinputreport(county,scorecard)
  cou_name <-unique(df[[1]]$county)
  ck <- df %>% purrr::map(function(x) dplyr::filter(x,name%in%c('avgpredkeyratio')) %>% keyplot())
  cp <- df %>% purrr::map(function(x) dplyr::filter(x,name%in%c('geovoter','registered','voting','ballpred')) %>% votplot())
  ce <- df %>% purrr::map(function(x) dplyr::filter(x,name%in%c('prederror')) %>% histerrpred())
  g <- gridExtra::marrangeGrob(append(append(ck,cp),ce),nrow=length(scorecard),ncol=3,top=cou_name)
  plotname <- paste0(substr(cou_name,1,nchar(cou_name)-4),".png")
  plotfile <- paste0("pngs/",plotname)
  ggsave(file=plotfile,g)
  list(plot=g)
}
keyplot <-function(x,label=NULL){
  ggplot2::ggplot(data=x, aes(x=age,y=value, color=name)) + 
	  geom_point() + 
	  scale_y_continuous(limits=c(0, 2))
}
sortplot <- function(qdf=NULL,pis='pi_ind',scale_c=10){
  ggplot2::ggplot(qdf) +
  	geom_point(data=filter(qdf,name%in%c('x','y','alpha')),aes(x=pi_ind,y=value, color=name)) +
  	geom_line(data=filter(qdf,name%in%c('pred1','pred2','pred3')),aes(x=pi_ind,y=value, color=name)) +
    labs(x="precinct",y="percentage",title="") +
    geom_point(aes(x=pi_ind,y=zeta/scale_c)) +
    geom_line(aes(x=pi_ind,y=mean(zeta)/scale_c)) +
    scale_x_continuous(limits=c(0, 1)) +
    scale_y_continuous(
      limits=c(0, 0.75),
      name = "Probability",
      sec.axis = sec_axis(~.*scale_c, name="Zeta")
  )
}

resplot <- function(datadf=NULL,xt=NULL,yt=NULL,x_scale=c(-2.2)){

  ggplot2::ggplot(data=datadf,aes_string(x=xt,y=yt),) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE, col = "deeppink") +
    labs(caption = paste0("With fitted straight line model (R2)=",signif(summary(lm(datadf[[yt]]~datadf[[xt]]))$r.squared)),3)
#    scale_x_continuous(limits=c(-1.5,1.5))
    #scale_x_continuous(limits=c(x_scale[1], x_scale[2]))
    #scale_y_continuous(limits=c(0, 1))
}
