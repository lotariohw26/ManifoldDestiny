library(ggplot2)
library(dplyr)
#' @export Voterrollanalysis
Voterrollanalysis <- setRefClass("Voterrollanalysis", fields=list(voterroll='data.frame', 
								  listscard='list', 
								  polyscard='list',
								  polypredi='list' 
								  ))
Voterrollanalysis$methods(initialize=function(coudatafile='vtr_ohio.rda'){
  rotp <- rprojroot::find_rstudio_root_file()
  vfile <- paste0(rotp,'/data/',coudatafile)
  load("~/research/ManifoldDestiny/data/vtr_ohio.rda")
  #¡
  voterroll <<- as.data.frame(vtr_ohio) 
})
Voterrollanalysis$methods(scorecard=function(polyo=c(1,2,6,8)){

  vr <- voterroll
  nrco <- unique(voterroll$cou_nr)
    lapply(nrco,function(x){
      lapply(1:length(polyo),function(y){
        dft <- dplyr::filter(voterroll,cou_nr==x)
        ft <- paste0("dft$key_ratio~poly(dft$age,",polyo[y],")")
        lm(as.formula(ft))
      })
    }) ->> listscard
    polyscard <<- lapply(1:4, function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]]$coeff)))	
})
Voterrollanalysis$methods(predictinput=function(predict=c(1,2,6,8)){

  avgpredkeyratio <- t(polyscard[[3]]) %>% base::colMeans()
  polypredi[[1]] <<- voterroll %>%
	  dplyr::group_by(cou_nr) %>%
          dplyr::mutate(ballpred=tot_regist*tur_ratio*avgpredkeyratio) 
          dplyr::mutate(prederror=tot_voted-ballpred) %>%
          #dplyr::mutate(corr=cor(ballpred,tot_voted)) 
	  dplyr::ungroup()
warnings()
  dft <- polypredi[[1]] %>% dplyr::filter(cou_nr==3)
  plot(dft$age,dft$key_ratio) 
  View(polypredi[[1]])
names(dft)
  polyscard[[1]]
  View(voterroll)
  dim(voterroll[1])
browser()
  
#    dplyr::mutate(ballpred=registered*turnratio*avgpredkeyratio) %>%

#  cou_data_trans <- foudatatidy(county) %>% tidyr::drop_na() %>% dplyr::select(county,age,keyratio,geovoter,voting,registered,turnratio)
#  
# dfinputreport <- scorecard %>%
#    purrr::map_df(function(x) as.data.frame(left_join(x,cou_data_trans,by='age'))) %>%
#    dplyr::group_by(polinc) %>%
#    tidyr::drop_na() %>%
#    dplyr::mutate(ballpred=registered*turnratio*avgpredkeyratio) %>%
#    dplyr::mutate(prederror=voting-ballpred) %>%
#    dplyr::mutate(corr=cor(ballpred,voting)) %>%
#    tidyr::nest() %>%
#    tidyr::unnest(data) %>%
#    dplyr::ungroup() %>%
#    tidyr::pivot_longer(c(avgpredkeyratio,keyratio,prederror,ballpred,geovoter,voting,registered)) %>%
#    split(.$polinc)
})
Voterrollanalysis$methods(predictplots=function(arg1=NULL){})
Voterrollanalysis$methods(gridarrange=function(arg1=NULL){})
Voterrollanalysis$methods(teste=function(arg1=NULL){
browser()
})
ohio_vr <- Voterrollanalysis()
#View(ohio_vr)
ohio_vr$voterroll
ohio_vr$scorecard()
ohio_vr$predictinput()

ohio_vr$predictplots()
ohio_vr$gridarrange()


View(ohio_vr$polyscard[[1]])


names(ohio_vr$voterroll)
head(ohio_vr$voterroll)
dft <- dplyr::filter(ohio_vr$voterroll,cou_nr==3)

names(dft)
palette <- c("Registered voters","Ballot votes","Predicted votes")

ggplot2::ggplot(data=dft) +
  geom_line(aes(x=age,y=ag_regis,color=palette[1])) +
  geom_line(aes(x=age,y=ag_voted,color=palette[2])) +
  #geom_line(aes(x=age,y=ag_regra,color=palette[3])) +
  labs(caption='test') +
  ggplot2::xlab('xlab') +
  ggplot2::ylab('ylab')+
  theme_classic()
ggplot2::ggplot(data=df,aes(x=df$age,y=df$key_ratio))+geom_point()
View()
#rm(list=rm())
####################################################################################################
# Version 2.0
# About: Based on Dr. Frank analysis for Ohio
###################################################################################################
polorderpred <- function(keyratio,age,polorderset=c(1,2,6,8)){
	pol_order_all <- list()
  	for (i in 1:length(polorderset)){
    		pol_order_all[[i]] <- lm(keyratio ~ poly(age,polorderset[i]))
  	}
  pol_order_all
}
###################################################################################################
###################################################################################################
### Part I: Estimating the parameters for the polynominal functions ###
###################################################################################################
## Setting parameters
re_path <-"../../../googledata/drfrank/ohio/" # user specific relative path
pol_order_set <- c(1,2,6,8) # Polynominal set
cou_set <- c(1:5)
counties <- list.files(re_path, pattern='*.csv')
#counties <- system(paste0('cd ',re_path,'; ls *.csv --all'),intern=T)
###################################################################################################
## Reading the data
cou_data_all <- NULL
## Finding the polynominal parameters for the state
#pol_list_state <- data.frame()
state_scorcard <- NULL
for(cou in cou_set){
  #cou <- 1
  maxp <- max(pol_order_set)
  scorcard <- matrix(0,maxp+1,length(pol_order_set))
  # Change this
  keyage <- coupolpre(cou)
  coudatr <- polorderpred(keyage$keyratio,keyage$age,pol_order_set)
  for(pou in 1:length(pol_order_set)){
    #pou <- 1
    polvec <- unname(unlist(coudatr[[pou]]$coefficients))
    scorcard[1:(pol_order_set[pou]+1),pou] <- polvec
  }
  scorcard_df <- data.frame(countynr=cou,polnr=seq(0,maxp),scorcard)
  state_scorcard <- rbind(scorcard_df,state_scorcard)
}
names(state_scorcard)[-c(1,2)] <- paste0("polynomorder",pol_order_set)
file_scorecard <- paste0('scorecard',length(cou_set))
save(state_scorcard, file =file_scorecard)
###################################################################################################
###################################################################################################
### Part II: Predicting ballot votes for different counties ###
###################################################################################################
# Importing libraries
library(dplyr)
library(ggplot2)
counties <- list.files(re_path, pattern='*.csv')
pol_order_set <- c(1,2,6,8) # Polynominal set
cou_set_plot <- c(1,2,3,4,5)
#low_age <- 18
#upp_age <- 100
#gen_el <- 'GENERAL-11/03/2020'
#pri_el <- 'PRIMARY-03/17/2020'
re_path <-"../../../googledata/drfrank/ohio/" # user specific relative path
file_scorecard <- 'scorecard5'
palette <- c("Registered voters","Ballot votes","Predicted votes")
xy_labels <- c("Age category","Number of voters")
###################################################################################################
load(file =file_scorecard)
state_pol_order_set <- state_scorcard %>% dplyr::arrange(countynr) %>% group_by(polnr) %>%
	dplyr::mutate_at(names(state_scorcard)[][-c(1,2)],mean) %>% dplyr::ungroup() %>%
	dplyr::select(3:dim(state_scorcard)[2]) %>% unique()
state_scorcard
scorecardmatrix <- state_pol_order_set %>% as.matrix()
## Transformation of data
#View(scorecardmatrix)
for (county in cou_set_plot){
	#county <- 1
	main_title <- counties[county]
	cou_data_trans <-coupolpre(county)
        pred_coeff <- polorderpred(cou_data_trans$keyratio,cou_data_trans$age,pol_order_set)
	cou_data_trans <-coupolpre(county)
	plot_pol_list <- list()
	plot_pre_list <- list()
	for (p in 1:length(pol_order_set)){
	  #p <- 1
	  # Settings
	  pol_length <- pol_order_set[p]+1
	  pred_coeff[[p]][[1]][1:pol_length] <- scorecardmatrix[,p][1:pol_length]
	  pol_pred <- predict(pred_coeff[[p]])
	  pol_order_ext  <- cou_data_trans %>% dplyr::mutate(predictpol=pol_pred) %>%
	    dplyr::mutate(ballpred=registered*turnratio*pol_pred) %>%
	    dplyr::mutate(r2=cor(ballpred,voting))
	  r2_text <- paste("Correlation coefficient (r)",round(unique(pol_order_ext$r2),digits=4))
	  pol_order <- paste("Polynomial of order",pol_order_set[p])

	  # Polynomial
	  plot_pol_list[[p]] <-
	    ggplot2::ggplot(data=pol_order_ext,aes(x=age,y=predictpol)) +
	    geom_line() +
	    labs(caption=pol_order) +
	    ggplot2::ylab('Index') +
	    ggplot2::xlab(xy_labels[1]) +
	    theme_classic()

	  # Predictions
	  plot_pre_list[[p]] <- ggplot2::ggplot(data=pol_order_ext) +
	    geom_line(aes(x=age,y=registered,color=palette[1])) +
	    geom_line(aes(x=age,y=voting,color=palette[2])) +
	    geom_line(aes(x=age,y=ballpred,color=palette[3])) +
	    labs(caption=r2_text) +
	    ggplot2::xlab(xy_labels[1]) +
	    ggplot2::ylab(xy_labels[2]) +
	    theme_classic()

	}
  comb <- c(plot_pol_list,plot_pre_list)
	grob <-  gridExtra::marrangeGrob(comb, nrow=length(pol_order_set), ncol=2, top=main_title)
	tleng <- nchar(main_title)
	grobfile <- paste0(substr(main_title,1,tleng-4),'.png')
	ggsave(file=grobfile, grob)
}
# Appendix
#names(readr::read_csv(paste0(re_path,counties[i])))
#unique(readr::read_csv(paste0(re_path,counties[1])))
