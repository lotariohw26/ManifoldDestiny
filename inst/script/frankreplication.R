#' @export Voterrollanalysis
Voterrollanalysis <- setRefClass("Voterrollanalysis", fields=list(abc='list'))
Voterrollanalysis$methods(initialize=function(arg1=NULL){})
Voterrollanalysis$methods(load=function(arg1=NULL){})















#rm(list=rm())
####################################################################################################
# Version 2.0
# About: Based on Dr. Frank analysis for Ohio
###################################################################################################
# Functions
coupolpre <- function(county=1,
                      el_date='2020-01-04',
                      flist=list(gel='GENERAL-11/03/2020',
                                 pel='PRIMARY-03/17/2020',
                                 lage=18,
                                 uage=100,
                                 gen_el='GENERAL-11/03/2020',
                                 pri_el='PRIMARY-03/17/2020'),
                      path='../../../googledata/drfrank/ohio/'){
  # Finding the polynominalj
  ## Transformation of data

  # put this as function arguments later
  #View(cou_data_transf)
  cou_data_transf <- readr::read_csv(paste0(re_path,counties[county]))[] %>%
      dplyr::rename(c(general=gen_el,primary=pri_el)) %>%
      # might adjust this later
      dplyr::select(1:43,general,primary) %>%
      dplyr::ungroup() %>%
      #dplyr::mutate(age=lubridate::interval(DATE_OF_BIRTH, Sys.Date())%/%lubridate::years(1)) %>%
      dplyr::mutate(age=as.numeric(difftime(el_date,DATE_OF_BIRTH,units="weeks")/52.5)) %>%
      dplyr::mutate(age=floor(age)) %>%
      dplyr::filter(age>=flist$lage) %>%
      dplyr::filter(age<=flist$uage) %>%
      dplyr::arrange(age) %>%
      dplyr::group_by(age) %>%
      #dplyr::summarize(COUNTY_NUMBER=max(COUNTY_NUMBER), voting=sum(general=='X', na.rm=T), registered=sum(VOTER_STATUS=='ACTIVE', na.rm=T)) %>%
      dplyr::filter(age>=low_age) %>%
      dplyr::filter(age<=upp_age) %>%
      dplyr::mutate(voting=sum(general=='X', na.rm=T)) %>%
      dplyr::mutate(registered=sum(VOTER_STATUS=='ACTIVE', na.rm=T)) %>%
      # Can probably be deleted
      #dplyr::mutate(voters=sum(age)) %>%
      dplyr::mutate(vregratio=voting/registered) %>%
      dplyr::ungroup() %>%
      dplyr::select(COUNTY_NUMBER, age, vregratio, registered, voting) %>%
      unique() %>%
      dplyr::mutate(tvoting=sum(voting)) %>%
      dplyr::mutate(tregistered=sum(registered)) %>%
      dplyr::mutate(turnratio=tvoting/tregistered) %>%
      dplyr::mutate(keyratio=vregratio/turnratio)
}
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
# Importing libraries
library(dplyr)
library(ggplot2)
low_age <- 18
up_age <- 100
gen_el <- 'GENERAL-11/03/2020'
pri_el <- 'PRIMARY-03/17/2020'
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
