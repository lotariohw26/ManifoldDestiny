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

#foudatatidy <- function(county=1,
#                      el_date='2020-01-04',
#                      flist=list(lage=18,
#                                 uage=100,
#                                 gen_el='GENERAL-11/03/2020',
#                                 pri_el='PRIMARY-03/17/2020'),
#                      path='/home/joernih/gitclones/homepageJIH/rprojects/research/election2020investigation/website/static/data-raw/ohio/'){
#      #print(getwd())
#      counties <- list.files(path,"*.csv")
#      ## Transformation of data
#      cou_data_transf <- readr::read_csv(paste0(path,counties[county]))[] %>%
#      dplyr::rename(c(general=flist$gen_el,primary=flist$pri_el)) %>%
#      # might adjust this later
#      dplyr::select(1:43,general,primary) %>% dplyr::mutate(county=counties[county]) %>%
#      dplyr::ungroup() %>%
#      #dplyr::mutate(age=lubridate::interval(DATE_OF_BIRTH, Sys.Date())%/%lubridate::years(1)) %>%
#      dplyr::mutate(age=as.numeric(difftime(el_date,DATE_OF_BIRTH,units="weeks")/52.5)) %>%
#      dplyr::mutate(age=floor(age)) %>%
#      dplyr::filter(age>=flist$lage) %>%
#      dplyr::filter(age<=flist$uage) %>%
#      dplyr::arrange(age) %>%
#      dplyr::group_by(age) %>%
#      dplyr::filter(age>=flist$lage) %>%
#      dplyr::filter(age<=flist$uage) %>%
#      dplyr::mutate(voting=sum(general=='X', na.rm=T)) %>%
#      dplyr::mutate(registered=sum(VOTER_STATUS=='ACTIVE', na.rm=T)) %>%
#      dplyr::mutate(geovoter=registered+sum(VOTER_STATUS=='CONFIRMATION', na.rm=T)) %>%
#      dplyr::mutate(vregratio=voting/registered) %>%
#      dplyr::ungroup() %>%
#      dplyr::select(county,COUNTY_NUMBER, age, vregratio, geovoter, registered, voting) %>%
#      unique() %>%
#      dplyr::mutate(tgeo=sum(geovoter)) %>%
#      dplyr::mutate(tvoting=sum(voting)) %>%
#      dplyr::mutate(tregistered=sum(registered)) %>%
#      dplyr::mutate(turnratio=tvoting/tregistered) %>%
#      dplyr::mutate(keyratio=vregratio/turnratio)
#}

#agedatatidy2 <- function(dfage=NULL,flist=list(lage=18,uage=100)){
##browser()
#
# # View(agedatatidy)
#
#    agedatatidy <- dfage %>%
#    dplyr::filter(age>=flist$lage) %>%
#    dplyr::filter(age<=flist$uage) %>%
#    dplyr::arrange(county,age) %>%
#    dplyr::group_by(county,age) %>%
#    dplyr::mutate(geovoter=sum(dplyr::dense_rank(status))) %>%
#    dplyr::mutate(gteovoter=sum(ifelse(status=='real',1,0))) %>%
#    dplyr::mutate(voting=sum(voting, na.rm=T)) %>%
#    dplyr::mutate(registered=sum(registered, na.rm=T)) %>%
#    dplyr::mutate(vregratio=voting/registered) %>%
#    dplyr::select(state,county,status,age,geovoter,gteovoter,vregratio, registered, voting) %>%
#    dplyr::distinct() %>%
#    dplyr::group_by(county) %>%
#    dplyr::mutate(tgeovoter=sum(geovoter)) %>%
#    dplyr::mutate(tgfeovoter=sum(gteovoter)) %>%
#    dplyr::mutate(tvoting=sum(voting)) %>%
#    dplyr::mutate(tregistered=sum(registered)) %>%
#    dplyr::mutate(turnratio=tvoting/tregistered) %>%
#    dplyr::mutate(keyratio=vregratio/turnratio) %>%
#    base::split(.$county)
#
#}

keypolorder <- function(polyorder=2,county=seq(1,3)){
 
  keypolorder <- county %>%
  purrr::map_dfr(function(x) foudatatidy(x)[,c('age','keyratio','county')]) %>%
  dplyr::mutate(nr=dplyr::dense_rank(county)) %>%
  dplyr::group_by(county) %>%
  tidyr::nest() %>%
  dplyr::mutate(model = data %>% purrr::map(~lm(keyratio ~ poly(age,polyorder,raw=T), data = .))) %>%
  dplyr::mutate(pred = purrr::map2(model, data, predict)) %>%
  dplyr::select(-model) %>%
  tidyr::unnest(c(pred,data)) %>%
  dplyr::select(nr,pred,county,keyratio,age) %>%
  dplyr::group_by(age) %>%
  dplyr::mutate(avgpredkeyratio=mean(pred)) %>%
  dplyr::select(age,avgpredkeyratio) %>%
  dplyr::distinct()

  #ggplot2::ggplot(keypolorder,aes(x=age,y=avgpredkeyratio)) + geom_line()
}

dfinputreport <- function(county=3,scorecard=NULL,digits=100){

  cou_data_trans <- foudatatidy(county) %>% tidyr::drop_na() %>% dplyr::select(county,age,keyratio,geovoter,voting,registered,turnratio)
  
 dfinputreport <- scorecard %>%
    purrr::map_df(function(x) as.data.frame(left_join(x,cou_data_trans,by='age'))) %>%
    dplyr::group_by(polinc) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(ballpred=registered*turnratio*avgpredkeyratio) %>%
    dplyr::mutate(prederror=voting-ballpred) %>%
    dplyr::mutate(corr=cor(ballpred,voting)) %>%
    tidyr::nest() %>%
    tidyr::unnest(data) %>%
    dplyr::ungroup() %>%
    tidyr::pivot_longer(c(avgpredkeyratio,keyratio,prederror,ballpred,geovoter,voting,registered)) %>%
    split(.$polinc)
}

#' @param data the data.frame (or data.table)
#' @importFrom openxlsx write.xlsx
#' @export
v <- function(data_df=NULL) {
    open_command <- switch(Sys.info()[['sysname']],
                           Windows= 'open',
                           Linux  = 'xdg-open',
                           Darwin = 'open')

    temp_file <- paste0(tempfile(), '.xlsx')

    data <- as.data.frame(data_df)
    openxlsx::write.xlsx(data, file = temp_file)

    invisible(system(paste(open_command, temp_file),
                     ignore.stdout = TRUE, ignore.stderr = TRUE))
}

V <- function(data_df=NULL) {
	View(data_df)
}

csv <- function(df=iris,nr=NULL,path='/home/joernih/tmp/R/tmp'){
	pathc <- paste0(path,nr,'.csv')
	write.csv(df,file=pathc)
}

