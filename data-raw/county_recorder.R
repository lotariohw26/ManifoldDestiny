library(ManifoldDestiny)
library(dplyr)
library(DataEditR)
#library(tidyverse)
#library(tidyquant)
## code to prepare `DATASET` dataset goes here

# Dallas
filename <- 'xlsx/Dallas Texas.xlsx'
ctype <- c("pre","a","b","c","d","e","f")
dallas_sel <- openxlsx::read.xlsx(filename, sheet="County Recorder Data") %>% `colnames<-` (c("Precinct","e","f","b","a","d","c")) %>% filter(!row_number() %in% c(1170)) %>% dplyr::mutate(pre=substr(Precinct,1,4), .after = Precinct) %>% dplyr::mutate_at(ctype,as.numeric) 
usethis::use_data(dallas_sel, overwrite = TRUE)
View(t)

## Washow
ctype <- c("pre","a","b","c","d")
prefilename <- 'xlsx/Patriot Database, Nevada, Washoe.xlsx'
washoe_sel <- openxlsx::read.xlsx(filename) %>% dplyr::select(-1) %>%  `colnames<-` (c("pre","Precinct","Registered","b","d","Biden.Advn","a","c","Trump.Advn","Other.EDV","Other.Miv","Other.Advn")) %>%  dplyr::mutate_at(ctype,as.numeric) %>% dplyr::mutate_at(ctype, ~replace(., is.na(.), 0))
usethis::use_data(washoe_sel, overwrite = TRUE)

## Maricopa
filename <- 'xlsx/Maricopa Plane, Hybrid.xlsx'
maricopa_sel <- openxlsx::read.xlsx(filename) %>% `colnames<-` (c("pre","name","R","b","a","d","c"))
usethis::use_data(maricopa_sel, overwrite = TRUE)

## Oakland
filename <- 'xlsx/OaklandCountyRecorder.xlsx'
oakland_sel <- openxlsx::read.xlsx(filename)
names(oakland_sel)  <- c("pre","Town","Prec","BidenEdvspt","TrumpEdvspt","OtherEDVspt","BidenAVspt","TrumpAVspt","OtherAVspt","BidenEdvInd","TrumpEdvInd","OtherEDVInd","BidenAVInd","TrumpAVInd","OtherAVInd")
usethis::use_data(oakland_sel, overwrite = TRUE)

# Tarrant
filename <- 'xlsx/Tarrant County.xlsx'
washoe_sel <- openxlsx::read.xlsx(filename)
names(washoe_sel)

# Clark
ctype <- c("a","b","c","d")
filename <- 'xlsx/Clark County, NV.xlsx'
clark_sel <- openxlsx::read.xlsx(filename,sheet='Clark County Recorder') %>% `colnames<-` (c("pind","pre","registration","biden.edv","d","b","trump,edv","c","a","other.edv","other.miv","other.adv")) %>%
dplyr::mutate_at(ctype,as.numeric) %>%
dplyr::mutate_at(ctype, ~replace(., is.na(.), 0))
usethis::use_data(clark_sel, overwrite = TRUE)

# Nevada
ctype <- c("pre","reg","tot","a","b","c","d")
filename <- 'xlsx/PrefaceNevada.xlsx'
nevada_sel <- openxlsx::read.xlsx(filename,sheet=3) %>% select(c(1,3:8)) %>%   filter(!row_number() %in% c(1)) %>% 
	`colnames<-` (c("pre","reg","tot","a","b","c","d")) %>% dplyr::mutate_at(ctype,as.numeric) %>% dplyr::mutate_at(ctype, ~replace(., is.na(.), 0))
usethis::use_data(nevada_sel, overwrite = TRUE)











###
library(dplyr)
filename <- 'xlsx/Dallas Texas, Completed.xlsx'
openxlsx::getSheetNames(filename) 
dallasxray <- openxlsx::read.xlsx(filename,sheet='X-Ray Machine') 


s_depth	<- 0.01
s_division	<- 0.02
s_shift	<- 50
s_slide	<- -49

build <- dallasxray[1:741,] %>% dplyr::select(7,8,9) %>% 
	 dplyr::mutate(rank_v=dense_rank(v)) %>% 
	 dplyr::mutate(slide=floor((v+s_depth*s_division*s_shift)/s_depth)) %>%
	 dplyr::mutate(slide_norm=slide-(s_slide)+1) %>%
	 dplyr::mutate(carry_slide_norm=1000*rank_v+slide_norm, 
	 	      carry_v=1000*rank_v+v, 
	 	      carry_u=1000*rank_v+u,
	 	      carry_w=1000*rank_v+w) %>%
	 dplyr::mutate(index=row_number()) %>%
	 dplyr::mutate(sort_slide_norm=sort(carry_slide_norm)) %>%
	 dplyr::mutate(sort_v=sort(carry_v),
		       sort_u=sort(carry_u),
		       sort_w=sort(carry_w)) %>%
	 dplyr::mutate(drop_s=sort_slide_norm-1000*index+s_slide-1,
		      drop_v=sort_v-1000*index,
		      drop_u=sort_u-1000*index,
		      drop_w=sort_w-1000*index) 
	 dplyr::mutate(Fat_Slide=0,
		       Partition_Rank_=0,
		       True Rank=0)
View(build)

