library(tidyr)
library(ggpmisc)
library(dplyr)
library(plotly)
library(readxl)
source('../../../R/algofunctions.R')
###############################################################################
### Readling all data
path <- 'xlsx/Clark County,NV.xlsx'
#system('libreoffice xlsx/abc.xlsx')

clark_all <- readxl::read_excel('xlsx/Clark County, NV.xlsx',sheet=3) 
names(clark_all)
#  [1] "P#"           "Precinct"     "Registration"
#  [4] "Biden EDV"    "Biden MiV"    "Biden Adv"   
#  [7] "Trump EDV"    "Trump MiV"    "Trump Adv"   
# [10] "Other EDV"    "Other MiV"    "Other Adv"   
names(clark_all) <- c("P#","Precinct","Registration","BidenEDV","a","c","TrumpEDV","b","d","OtherEDV","OtherMiV","OtherAdv")

clark_all$a <- as.numeric(clark_all$a) 
clark_all$b <- as.numeric(clark_all$b)
clark_all$c <- as.numeric(clark_all$c)
clark_all$d <- as.numeric(clark_all$d)

k <- 0.0010245
f <- 0.633491
c <- -0.369029	
g <- function(alpha,h,k,c,f) eval(parse(text='(alpha+k-c*h)/f'),c(list(alpha=alpha,h=h), list(k=k,f=f,c=c)))
g(3,3,3,3,4)

clark_all_adj <- clark_all %>% 
	dplyr::mutate(g=d/(a+d),
		      h=b/(b+c),
		      alpha=(b+d)/(a+b+c+d)) %>%



ViewPipeSteps::print_pipe_steps()

