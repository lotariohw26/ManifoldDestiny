library(ManifoldDestiny)
library(reticulate)
fqs <- reticulate::import("fqs")
p4 <- c(1,2,3,4,5)
fqs$quartic_roots(p4)
p3 <- c(1,2,3,4)
fqs$cubic_roots(p3)

2022, Sheriff Restoration, Clark County, Nevada.xlsx
Clark County, NV.xlsx
Cubic Equation Calculator, Standard.xlsx
Dallas Texas, Completed.xlsx
Dallas Texas Revised.xlsx
Dallas Texas.xlsx
MacombCountyRecorder.xlsx
Maricopa Plane Equation_F.xlsx
Maricopa Plane Equation_V.xlsx
Maricopa Plane Equation.xlsx
Maricopa Plane, Hybrid.xlsx
maricopareplicationplane.xlsx
MultiVariateQuadReg.xlsx
OaklandCountyRecorder.xlsx
Pascal Tet Formation.xlsx
Patriot Database, Nevada, Washoe.xlsx
PrefaceNevada.xlsx
Quartic Equation Calculator.xlsx
Reflection Test Fair.xlsx
Reflection Test Unfair.xlsx
Restored Nevada 2022 Primary Elections.xlsx
Tarrant County Texas, Completed.xlsx
Tarrant County.xlsx
voterdatabase.xlsx
# Dallas
filename <- paste0(abs_path(),'/data-raw/xlsx/Dallas Texas, Completed.xlsx')
filename
#"/home/joernih/research/ManifoldDestiny/data-raw/xlsx/Dallas Texas, Completed.xlsx"
openxlsx::getSheetNames(file=filename)
#  [1] "County Recorder Data"            "Dallas Original"                
#  [3] "Results"                         "TYA Quartic Pos Input D0"       
#  [5] " Y Dallas Quartic Positive D0"   "T Dallas Quartic Positive D0"   
#  [7] "Quartic Neg Input, D1"           "Y Dallas Quartic Neg D1"        
#  [9] "T Dallas Quartic Neg D1"         "Quartic Neg Input, D2"          
# [11] "Y Dallas Quartic Neg D2"         "T Dallas Quartic Neg D2"        
# [13] "Quartic Neg Input, D3"           "Y Dallas Quartic Neg D3"        
# [15] "T Dallas Quartic Neg D3"         "Dallas All Permutations EDV vs "
# [17] "Dallas All Permutations MiV vs " "Complex Rotator"                
# [19] "X-Ray Machine"                   "Mass Cubic Regression Calculato"
# [21] "Fractal Assessment Calc"         "Trivial Shattering"             
# [23] "Manifold Obliteration"           "Recursive Zeta Optimization"    
# [25] "EM"                              "EC"                             
# [27] "EI"                              "ED"                             
# [1] "Dallas EDV vs Advanced"          "County Recorder Data"           
# [3] "Dallas EDV vs Advan 45 degrees"  "Mail-in"                        
# [5] "Dallas All Permutations of the "
library(dplyr)
library(reticulate)
fqs <- reticulate::import("fqs")
dallas_sel <- openxlsx::read.xlsx(filename, sheet=" Y Dallas Quartic Positive D0") %>%
	dplyr::select(A,B,C,D,E) %>% 
        dplyr::mutate(pri=row_number()) %>%
	dplyr::group_by(pri) %>%
	dplyr::mutate(test=fqs$quartic_roots(c(A,B,C,D,E)))

View(dallas_sel)

library(ManifoldDestiny)
p4 <- c(1,2,3,4,5)
fqs$quartic_roots(p4)
p3 <- c(1,2,3,4)
fqs$cubic_roots(p3)

