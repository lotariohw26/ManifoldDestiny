library(ManifoldDestiny)
library(dplyr)
library(DataEditR)
#library(tidyverse)
#library(tidyquant)
## code to prepare `DATASET` dataset goes here

# Dallas
filename <- paste0(abs_path(),'/data-raw/xlsx/Dallas Texas.xlsx')
ctype <- c("pre","a","b","c","d","e","f")
<<<<<<< HEAD
dallas_sel <- openxlsx::read.xlsx(filename, sheet="County Recorder Data") %>%
	`colnames<-` (c("Precinct","e","f","b","a","d","c")) %>% filter(!row_number() %in% c(1170)) %>%
	dplyr::mutate(pre=gsub("-","",Precinct)) %>% dplyr::mutate_at(ctype,as.numeric) 
usethis::use_data(dallas_sel, overwrite = TRUE)
=======
dallas_sel <- openxlsx::read.xlsx(filename, sheet="County Recorder Data") %>% `colnames<-` (c("Precinct","e","f","b","a","d","c")) %>% 
	filter(!row_number() %in% c(1170)) %>%
	dplyr::mutate(gsub("-","" )
	dplyr::mutate(pre=substr(Precinct,1,8), .after = Precinct) %>% 
	dplyr::mutate_at(ctype,as.numeric) 
usethis::use_data(dallas_sel, overwrite = TRUE)
View(dallas_sel)
>>>>>>> fc2a7d2f4659f2225a02c874c4f41a3e0b1ff15a

## Washow
ctype <- c("pre","a","b","c","d")
filename <- paste0(abs_path(),'/data-raw/xlsx/Patriot Database, Nevada, Washoe.xlsx')
washoe_sel <- openxlsx::read.xlsx(filename) %>% dplyr::select(-1) %>%  `colnames<-` (c("pre","Precinct","Registered","b","d","Biden.Advn","a","c","Trump.Advn","Other.EDV","Other.Miv","Other.Advn")) %>%  dplyr::mutate_at(ctype,as.numeric) %>% dplyr::mutate_at(ctype, ~replace(., is.na(.), 0))
usethis::use_data(washoe_sel, overwrite = TRUE)

## Maricopa
filename <- paste0(abs_path(),'/data-raw/xlsx/Maricopa Plane, Hybrid.xlsx')
maricopa_sel <- openxlsx::read.xlsx(filename) %>% `colnames<-` (c("pre","name","R","b","a","d","c"))
usethis::use_data(maricopa_sel, overwrite = TRUE)

## Oakland
filename <- paste0(abs_path(),'/data-raw/xlsx/OaklandCountyRecorder.xlsx')
oakland_sel <- openxlsx::read.xlsx(filename)
names(oakland_sel)  <- c("pre","Town","Prec","BidenEdvspt","TrumpEdvspt","OtherEDVspt","BidenAVspt","TrumpAVspt","OtherAVspt","BidenEdvInd","TrumpEdvInd","OtherEDVInd","BidenAVInd","TrumpAVInd","OtherAVInd")
usethis::use_data(oakland_sel, overwrite = TRUE)

# Tarrant
filename <- paste0(abs_path(),'/data-raw/xlsx/Tarrant County.xlsx')
washoe_sel <- openxlsx::read.xlsx(filename)
names(washoe_sel)

# Clark
ctype <- c("a","b","c","d")
filename <- paste0(abs_path(),'/data-raw/xlsx/Clark County, NV.xlsx')
clark_sel <- openxlsx::read.xlsx(filename,sheet='Clark County Recorder') %>% `colnames<-` (c("pind","pre","registration","biden.edv","d","b","trump,edv","c","a","other.edv","other.miv","other.adv")) %>%
dplyr::mutate_at(ctype,as.numeric) %>%
dplyr::mutate_at(ctype, ~replace(., is.na(.), 0))
usethis::use_data(clark_sel, overwrite = TRUE)

# Nevada
ctype <- c("pre","reg","tot","a","b","c","d")
filename <- paste0(abs_path(),'/data-raw/xlsx/xlsx/PrefaceNevada.xlsx')
nevada_sel <- openxlsx::read.xlsx(filename,sheet=3) %>% select(c(1,3:8)) %>%   filter(!row_number() %in% c(1)) %>% 
	`colnames<-` (c("pre","reg","tot","a","b","c","d")) %>% dplyr::mutate_at(ctype,as.numeric) %>% dplyr::mutate_at(ctype, ~replace(., is.na(.), 0))
usethis::use_data(nevada_sel, overwrite = TRUE)





