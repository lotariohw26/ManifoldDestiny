library(ManifoldDestiny)
library(dplyr)
library(DataEditR)
## code to prepare `DATASET` dataset goes here
## To candidates
# Dallas
filename <- paste0(abs_path(),'/data-raw/xlsx/Miller vs Stavros.xlsx')
clark_miller_stavros_sel <- openxlsx::read.xlsx(filename, sheet=2) %>% dplyr::select(1:8) %>% 
	`colnames<-` (c("P","R","a","b","c","d","Stavros.EDV","Miller.EDV"))

(sum(clark_miller_stavros_sel$Stavros.EDV)+sum(clark_miller_stavros_sel$Miller.EDV))

usethis::use_data(clark_miller_stavros_sel, overwrite = TRUE)

filename <- paste0(abs_path(),'/data-raw/xlsx/Dallas Texas, Completed.xlsx')
ctype <- c("pre","a","b","c","d","e","f")
dallas_sel <- openxlsx::read.xlsx(filename, sheet="County Recorder Data") %>% dplyr::select(1:7) %>%
	`colnames<-` (c("Precinct","e","f","b","a","d","c")) %>% filter(!row_number() %in% c(1170)) %>%
	dplyr::mutate(pre=gsub("-","",Precinct)) %>% dplyr::mutate_at(ctype,as.numeric) 
usethis::use_data(dallas_sel, overwrite = TRUE)

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

## Three candidates
filename <- paste0(abs_path(),'/data-raw/xlsx/Manifolds In Action; County Recorder Data.xlsx')
clark <- openxlsx::read.xlsx(filename,sheet=1) 
stn <- c("P","R","A1","A2","A3","B1","B2","B3","C1","C2","C3")
she <- clark[c(-1),c(-1,-4)] %>% dplyr::select(1,2,3:11)  %>% `colnames<-` (stn) %>% dplyr::mutate_at(stn,as.numeric) 
gov <- clark[c(-1),c(-1,-4)] %>% dplyr::select(1,2,12:20) %>% `colnames<-` (stn) %>% dplyr::mutate_at(stn,as.numeric) 
sen <- clark[c(-1),c(-1,-4)] %>% dplyr::select(1,2,21:29) %>% `colnames<-` (stn) %>% dplyr::mutate_at(stn,as.numeric) 
clark_sgs_sel <- list(sheriff=she,governor=gov,senate=sen)
usethis::use_data(clark_sgs_sel,overwrite = TRUE)
