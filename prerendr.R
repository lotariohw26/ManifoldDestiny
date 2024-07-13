suppressMessages(ManifoldDestiny::wasmconload())
##############################################################################################################
#library(ManifoldDestiny)
###############################################################################################################
### Settings
#abc <- F # Bygg pakker
#if(isTRUE(abc)) {
#  metd <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_variables.yml"))
#  usethis::use_data(metd,overwrite=T)
#  
#  # Model
#  fdm <- paste0(rprojroot::find_rstudio_root_file(),'/script/python/pysympy.py')
#  reticulate::source_python(fdm)
#  eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
#  ## Saving data
#  usethis::use_data(eqpar, overwrite = TRUE)
#  
#  # 20 laws and 40 isos
#  fdm <- paste0(rprojroot::find_rstudio_root_file(),'/script/python/20_laws_40_isos.py')
#  reticulate::source_python(fdm)
#  eqdef <- list(meql=reticulate::py$dfl,meqs=reticulate::py$dfs)
#  
#  # Saving data
#  usethis::use_data(eqdef, overwrite = TRUE)
#  stickers <-
#    list(parameters=list(
#    standard=c("alpha","x","y","zeta","lamda","Omega"),
#    hybrid=c("alpha","g","h","Gamma","Omega","lamda"),
#    opposition=c("alpha","m","n","xi","lamda","Omega")),
#    forms=list('_s','o_h','h_o')) 
#  usethis::use_data(stickers, overwrite = TRUE)
#  
#  # Cubic
#  peqs <-c(
#  'k0 + k1*u + k2*v',
#  'k0 + k1*u + k2*v + k3*u**2 + k4*v**2 + k5*u*v',
#  'k0 + k1*u + k2*v + k3*u**2 + k4*v**2 + k5*u*v + k6*v**3 + k7*u*v + k8*u**2*v + k9*u*v**2',
#  'k0 + k1*u + k2*v + k3*u**2 + k4*v**2 + k5*u*v + k6*u**3 + k7*v**3 + k8*u**2*v + k9*u*v**2 + k10*u**4 + k11*v**4 + k12*u**3*v + k13*u**2*v**2 + k14*u*v**3 +k15*u**4*v + k16*u*v**2')
#  usethis::use_data(peqs, overwrite = TRUE)
#  
#  ManifoldDestiny::bm()
# source(paste0(rprojroot::find_rstudio_root_file(),'/script/R/simulations.R'))
# usethis::use_data(basc, overwrite = TRUE)
# usethis::use_data(rigv, overwrite = TRUE)
# ManifoldDestiny::bm()
#  # source(paste0(rprojroot::find_rstudio_root_file(),'/data-raw/recorder.R'))
#}
#
#
#

#source("data-raw/recorder.R")

#laws1 <- data.frame(
#  V1 = c("North Ratio", "West Ratio", "Northwest Ratio", "Diagonal Aggregate", "Diagonal Complement", "West Aggregate", "East Aggregate", "North Aggregate", "South Aggregate"),
#  V2 = c("South Ratio", "East Ratio", "Northeast Ratio", "Diagonal Proportion", "Diagonal Inverse", "East to West Proportion", "West to East Proportion", "South to North Proportion", "North to South Proportion"),
#  V3 = c("North Complement", "West Complement", "Southeast Ratio", "1st Alpha Identity", "2nd Alpha Identity", "1st Lambda Identity", "2nd Lambda Identity", "1st Omega Identity", "2nd Omega Identity"),
#  V4 = c("South Complement", "East Complement", "Southwest Ratio", "Xi Identity", "Inverse Xi Identity", "Gamma Identity", "Inverse Gamma Identity", "Zeta Identity", "Inverse Zeta Identity"),
#  Equation1 = c("$x_{1} = \\frac{s}{s+t}$", "$g_{1} = \\frac{s}{s+v}$", "$m_{1} = \\frac{s}{s+u}$", "$\\alpha_{1} = \\frac{s+u}{(s+u)+(t+v)}$", "$\\alpha_{2} = \\frac{t+v}{(s+u)+(t+v)}$", "$\\lambda_{1} = \\frac{s+v}{(s+v)+(u+t)}$", "$\\lambda_{2} = \\frac{u+t}{(s+v)+(u+t)}$", "$\\Omega_{1} = \\frac{s+t}{(s+t)+(u+v)}$", "$\\Omega_{2} = \\frac{u+v}{(s+t)+(u+v)}$"),
#  Equation2 = c("$y_{1} = \\frac{u}{u+v}$", "$h_{1} = \\frac{u}{u+t}$", "$n_{1} = \\frac{t}{t+v}$", "$\\xi = \\frac{t+v}{s+u}$", "$\\xi^{-1} = \\frac{s+u}{t+v}$", "$\\gamma = \\frac{u+t}{s+v}$", "$\\gamma^{-1} = \\frac{s+v}{u+t}$", "$\\zeta = \\frac{u+v}{s+t}$", "$\\zeta^{-1} = \\frac{s+t}{u+v}$"),
#  Equation3 = c("$x_{2} = (1-x_{1}) = \\frac{t}{s+t}$", "$g_{2} = (1-g_{1}) = \\frac{v}{s+v}$", "$m_{2} = (1-m_{1}) = \\frac{u}{s+u}$", "$\\alpha_{1} = (\\xi+1)^{-1}$", "$\\alpha_{2} = (\\xi^{-1}+1)^{-1}$", "$\\lambda_{1} = (\\gamma+1)^{-1}$", "$\\lambda_{2} = (\\gamma^{-1}+1)^{-1}$", "$\\Omega_{1} = (\\zeta+1)^{-1}$", "$\\Omega_{2} = (\\zeta^{-1}+1)^{-1}$"),
#  Equation4 = c("$y_{2} = (1-y_{1}) = \\frac{v}{u+v}$", "$h_{2} = (1-h_{1}) = \\frac{t}{u+t}$", "$n_{2} = (1-n_{1}) = \\frac{v}{t+v}$", "$\\xi = \\frac{1-\\alpha_{1}}{\\alpha_{1}} = \\frac{\\alpha_{2}}{\\alpha_{1}}$", "$\\xi^{-1} = \\frac{1-\\alpha_{2}}{\\alpha_{2}} = \\frac{\\alpha_{1}}{\\alpha_{2}}$", "$\\gamma = \\frac{1-\\lambda_{1}}{\\lambda_{1}} = \\frac{\\lambda_{2}}{\\lambda_{1}}$", "$\\gamma^{-1} = \\frac{1-\\lambda_{2}}{\\lambda_{2}} = \\frac{\\lambda_{1}}{\\lambda_{2}}$", "$\\zeta = \\frac{1-\\Omega_{1}}{\\Omega_{1}} = \\frac{\\Omega_{2}}{\\Omega_{1}}$", "$\\zeta^{-1} = \\frac{1-\\Omega_{2}}{\\Omega_{2}} = \\frac{\\Omega_{1}}{\\Omega_{2}}$")
#)
#usethis::use_data(laws1, overwrite = TRUE)
#
#laws2 <- tribble(
#  ~Law_Number, ~North_vs_South, ~West_vs_East, ~Diagonal_vs_Diagonal,
#  "First Law", "$x_{1}=\\alpha_{1}+\\zeta(\\alpha_{1}-y_{1})$", "$g_{1}=\\alpha_{1}+\\gamma(\\alpha_{1}-h_{1})$", "$m_{1}=\\Omega_{1}+\\xi(\\Omega_{1}-n_{1})$",
#  "Second Law", "$x_{1}=\\lambda_{1}+\\zeta(\\lambda_{1}-y_{2})$", "$g_{1}=\\Omega_{1}+\\gamma(\\Omega_{1}-h_{2})$", "$m_{1}=\\lambda_{1}+\\xi(\\lambda_{1}-n_{2})$",
#  "Third Law", "$x_{1}=\\frac{\\alpha_{1}y_{2}-\\lambda_{1}y_{1}}{(\\alpha_{1}-\\lambda_{1})-(y_{1}-y_{2})}$", "$g_{1}=\\frac{\\alpha_{1}h_{2}-\\Omega_{1}h_{1}}{(\\alpha_{1}-\\Omega_{1})-(h_{1}-h_{2})}$", "$m_{1}=\\frac{\\Omega_{1}n_{2}-\\lambda_{1}n_{1}}{(\\Omega_{1}-\\lambda_{1})-(n_{1}-n_{2})}$",
#  "Fourth Law", "$x_{1}=\\frac{\\lambda_{1}+\\alpha_{1}-\\Omega_{2}}{2\\Omega_{1}}$", "$g_{1}=\\frac{\\Omega_{1}+\\alpha_{1}-\\lambda_{2}}{2\\lambda_{1}}$", "$m_{1}=\\frac{\\lambda_{1}+\\Omega_{1}-\\alpha_{2}}{2\\alpha_{1}}$",
#  "Fifth Law", "$y_{1}=\\alpha_{1}-\\zeta^{-1}(\\alpha_{1}-x_{1})$", "$h_{1}=\\alpha_{1}-\\gamma^{-1}(\\alpha_{1}-g_{1})$", "$n_{1}=\\Omega_{1}-\\xi^{-1}(\\Omega_{1}-m_{1})$",
#  "Sixth Law", "$y_{1}=\\lambda_{2}-\\zeta^{-1}(\\lambda_{1}-x_{1})$", "$h_{1}=\\Omega_{2}-\\gamma^{-1}(\\Omega_{1}-g_{1})$", "$n_{1}=\\lambda_{2}-\\xi^{-1}(\\lambda_{1}-m_{1})$",
#  "Seventh Law", "$y_{1}=\\frac{x_{1}\\lambda_{2}-x_{2}\\alpha_{1}}{(\\lambda_{2}-\\alpha_{1})-(x_{2}-x_{1})}$", "$h_{1}=\\frac{g_{1}\\Omega_{2}-g_{2}\\alpha_{1}}{(\\Omega_{2}-\\alpha_{1})-(g_{2}-g_{1})}$", "$n_{1}=\\frac{m_{1}\\lambda_{2}-m_{2}\\Omega_{1}}{(\\lambda_{2}-\\Omega_{1})-(m_{2}-m_{1})}$",
#  "Eighth Law", "$y_{1}=\\frac{\\lambda_{2}+\\alpha_{1}-\\Omega_{1}}{2\\Omega_{2}}$", "$h_{1}=\\frac{\\Omega_{2}+\\alpha_{1}-\\lambda_{1}}{2\\lambda_{2}}$", "$n_{1}=\\frac{\\lambda_{2}+\\Omega_{1}-\\alpha_{1}}{2\\alpha_{2}}$",
#  "Ninth Law", "$\\alpha_{1}=x_{1}\\Omega_{1}+\\Omega_{2}y_{1}$", "$\\alpha_{1}=g_{1}\\lambda_{1}+\\lambda_{2}h_{1}$", "$\\Omega_{1}=m_{1}\\alpha_{1}+\\alpha_{2}n_{1}$",
#  "Tenth Law", "$\\alpha_{1}=\\Omega_{1}(x_{1}-x_{2})+\\lambda_{2}$", "$\\alpha_{1}=\\lambda_{1}(g_{1}-g_{2})+\\Omega_{2}$", "$\\Omega_{1}=\\alpha_{1}(m_{1}-m_{2})+\\lambda_{2}$",
#  "Eleventh Law", "$\\alpha_{1}=\\Omega_{2}(y_{1}-y_{2})+\\lambda_{1}$", "$\\alpha_{1}=\\lambda_{2}(h_{1}-h_{2})+\\Omega_{1}$", "$\\Omega_{1}=\\alpha_{2}(n_{1}-n_{2})+\\lambda_{1}$",
#  "Twelfth Law", "$\\alpha_{1}=\\frac{x_{1}(y_{2}-y_{1})-\\lambda_{1}(x_{1}-y_{1})}{y_{2}-x_{1}}$", "$\\alpha_{1}=\\frac{g_{1}(h_{2}-h_{1})-\\Omega_{1}(g_{1}-h_{1})}{h_{2}-g_{1}}$", "$\\Omega_{1}=\\frac{m_{1}(n_{2}-n_{1})-\\lambda_{1}(m_{1}-n_{1})}{n_{2}-m_{1}}$",
#  "Thirteenth Law", "$\\lambda_{1}=x_{1}\\Omega_{1}+\\Omega_{2}y_{2}$", "$\\Omega_{1}=g_{1}\\lambda_{1}+\\lambda_{2}h_{2}$", "$\\lambda_{1}=m_{1}\\alpha_{1}+\\alpha_{2}n_{2}$",
#  "Fourteenth Law", "$\\lambda_{1}=\\Omega_{1}(x_{1}-x_{2})+\\alpha_{2}$", "$\\Omega_{1}=\\lambda_{1}(g_{1}-g_{2})+\\alpha_{2}$", "$\\lambda_{1}=\\alpha_{1}(m_{1}-m_{2})+\\Omega_{2}$",
#  "Fifteenth Law", "$\\lambda_{1}=\\frac{\\alpha_{1}(x_{1}-y_{2})-x_{1}(y_{1}-y_{2})}{x_{1}-y_{1}}$", "$\\Omega_{1}=\\frac{\\alpha_{1}(g_{1}-h_{2})-g_{1}(h_{1}-h_{2})}{g_{1}-h_{1}}$", "$\\lambda_{1}=\\frac{\\Omega_{1}(m_{1}-n_{2})-m_{1}(n_{1}-n_{2})}{m_{1}-n_{1}}$",
#  "Sixteenth Law", "$\\lambda_{1}=\\Omega_{2}(y_{2}-y_{1})+\\alpha_{1}$", "$\\Omega_{1}=\\lambda_{2}(h_{2}-h_{1})+\\alpha_{1}$", "$\\lambda_{1}=\\alpha_{2}(n_{2}-n_{1})+\\Omega_{1}$",
#  "Seventeenth Law", "$\\zeta=\\frac{x_{1}-\\alpha_{1}}{\\alpha_{1}-y_{1}};\\Omega_{1}=\\frac{y_{1}-\\alpha_{1}}{y_{1}-x_{1}}$", "$\\gamma=\\frac{g_{1}-\\alpha_{1}}{\\alpha_{1}-h_{1}};\\lambda_{1}=\\frac{h_{1}-\\alpha_{1}}{h_{1}-g_{1}}$", "$\\xi=\\frac{m_{1}-\\Omega_{1}}{\\Omega_{1}-n_{1}};\\alpha_{1}=\\frac{n_{1}-\\Omega_{1}}{n_{1}-m_{1}}$",
#  "Eighteenth Law", "$\\Omega_{1}=\\frac{\\lambda_{2}-\\alpha_{1}}{x_{2}-x_{1}}=\\frac{\\alpha_{2}-\\lambda_{1}}{x_{2}-x_{1}}$", "$\\gamma_{1}=\\frac{\\Omega_{2}-\\alpha_{1}}{g_{2}-g_{1}}=\\frac{\\alpha_{2}-\\Omega_{1}}{g_{2}-g_{1}}$", "$\\alpha_{1}=\\frac{\\lambda_{2}-\\Omega_{1}}{m_{2}-m_{1}}=\\frac{\\Omega_{2}-\\lambda_{1}}{m_{2}-m_{1}}$",
#  "Nineteenth Law", "$\\zeta=\\frac{x_{1}-\\lambda_{1}}{\\lambda_{1}-y_{2}}; \\Omega_{1}=\\frac{y_{2}-\\lambda_{1}}{y_{2}-x_{1}}$", "$\\gamma=\\frac{g_{1}-\\Omega_{1}}{\\Omega_{1}-h_{2}}; \\lambda_{1}=\\frac{h_{2}-\\Omega_{1}}{h_{2}-g_{1}}$", "$\\xi=\\frac{m_{1}-\\lambda_{1}}{\\lambda_{1}-n_{2}}; \\alpha_{1}=\\frac{n_{2}-\\lambda_{1}}{n_{2}-m_{1}}$",
#  "Twentieth Law", "$\\zeta=\\frac{\\lambda_{1}-\\alpha_{1}}{(y_{2}-y_{1})+(\\alpha_{1}-\\lambda_{1})}$", "$\\gamma=\\frac{\\Omega_{1}-\\alpha_{1}}{(h_{2}-h_{1})+(\\alpha_{1}-\\Omega_{1})}$", "$\\xi=\\frac{\\lambda_{1}-\\Omega_{1}}{(n_{2}-n_{1})+(\\Omega_{1}-\\lambda_{1})}$"
#)
#
#
#ManifoldDestiny::bm()
#
#
#
#
#
#
#
#
#
#
#
#
#

#ctone <-'Applications'
#formved <- c('Opposition', 
#	     'Opposition', 
#	     'Normal', 
#	     'Opposition')
#casevec <- c('Miller vs. Stavros, 2020',
#'Gilbert vs. Sisiolak vs. Lombardo 2020',
#'Lake vs. Hobbs, 2022',
#'Trump vs. Biden, 2020')
#propv_vec <- c("1rd & 2th","1rd & 2th","1rd & 2th","1rd & 2th")
#prope_vec <- c("5th & 6th","5th & 6th","3rd & 4th","5th & 6th")
#cou_abc <- c("Case","Form of rigg","Properties","Violations")
#concl_appps <- data.frame(case=casevec,
#			  rig=formved,
#			  propn=prope_vec, 
#			  propv=propv_vec)
#
#usethis::use_data(concl_appps, overwrite = TRUE)
#

#source(paste0(rprojroot::find_rstudio_root_file(),'/script/R/simulations.R'))
#usethis::use_data(basc, overwrite = TRUE)
#usethis::use_data(rigv, overwrite = TRUE)
#appnf <- seloutput(rppnf <- selreport(basc))
#appr1 <- seloutput(rppr1 <- selreport(rigv[[1]]))
#appr2 <- seloutput(rppr2 <- selreport(rigv[[2]]))
#appr3 <- seloutput(rppr3 <- selreport(rigv[[3]]))
#penf <- polynom::polynomial(unname(rppnf[[1]]$polyc[[1]][[1]],3))
#per1 <- polynom::polynomial(unname(rppr1[[1]]$polyc[[1]][[1]],3))
#per2 <- polynom::polynomial(unname(rppr2[[1]]$polyc[[1]][[1]],3))
#per3 <- polynom::polynomial(unname(rppr3[[1]]$polyc[[1]][[1]],3))
#

ManifoldDestiny::wasmconload()

