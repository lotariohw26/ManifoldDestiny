#####################################################################################################################
########################################################################################################################
# Cleaning namespace
for name in dir():
  if not name.startswith('_'):
      del globals()[name]
# Import packages
import json
import sympy
import numpy
import sys
from sympy import solve, Eq, symbols, latex, simplify
import pandas
import os
import rpy2
import rpy2.robjects as robjects
from rpy2.robjects.packages import importr, data
rroot=importr('rprojroot')
abs_path = rroot.find_rstudio_root_file()[0]
csvfile=abs_path+'/inst/script/symbolic/csv/parameters.csv'
readmodvar = pandas.read_csv(csvfile, sep=',') 
sympy.var(readmodvar.iloc[:,0])
beforems = set(dir())
########################################################################################################################
#########################################################################################################################
### Standard form
x_s       = [Eq(x,a/(a+b))]
y_s       = [Eq(y,c/(c+d))]
zeta_s    = [Eq(zeta,(c+d)/(a+b)),Eq(zeta,(x-alpha)/(alpha-y))]
alpha_s   = [Eq(alpha,(a+c)/(a+b+c+d)),Eq(alpha,(x+zeta*y)/(1+zeta))]
lambda_s  = [Eq(lamda,(a+d)/(a+b+c+d)),Eq(lamda,(x+zeta*(1-y))/(zeta+1))]
###########################################################################################################################
###### Oppostion form
#Eq(alpha,Omega*x+(1-Omega)*y),Eq(alpha,(g+Gamma*h)/(Gamma+1))
#Eq(alpha,(1)/(xi+1)),Eq(lamda,(1)/(Gamma+1)),Eq(lamda,(m+xi*(1-n))/(xi+1))
g_h       = [Eq(g,a/(a+d))]
h_h       = [Eq(h,b/(b+c))]
Gamma_h   = [Eq(Gamma,(b+c)/(a+d))]
alpha_h   = [Eq(alpha,(a+c)/(a+b+c+d)),Eq(alpha,(g+Gamma*h)/(1+Gamma))]
Omega_h   = [Eq(Omega,(a+b)/(a+b+c+d)),Eq(alpha,(x+zeta*y)/(1+zeta))]
###############################################################################################################################
######### Hybrid form
n_o       = [Eq(n,b/(b+d))]
m_o       = [Eq(m,a/(a+c))]
xi_o      = [Eq(xi,(b+d)/(a+c)),Eq(alpha,(x+zeta*y)/(1+zeta))]
Omega_o   = [Eq(Omega,(a+b)/(a+b+c+d)),Eq(alpha,(m+xi*y)/(1+xi))]
lambda_o  = [Eq(lamda,(a+d)/(a+b+c+d)),Eq(alpha,(mi+xi*n)/(xi+1))]
#############################################################################################################################
##########################################################################################################################
y_s.append(Eq(y,solve(alpha_s[1],y)[0]))
#############################################################################################################################
##########################################################################################################################
###### Storing ###
##### Storing ###
afterms = set(dir())
modvarlist = list(afterms - beforems)
modvarlist.remove('beforems')
modvarlist
modeqs = dict()
modeql = dict()
dfs = [] 
dfl = [] 
parv = 'empty'
for i in range(0,len(modvarlist)):
  modeqs[parv] = dfs
  modeql[parv] = dfl
  parv = modvarlist[i]
  dfs = [] 
  dfl = [] 
  nid = len(eval(modvarlist[i])) 
  for j in range(0,nid):
    dfs.append(str(eval(modvarlist[i])[j].rhs))
    dfl.append(latex(eval(modvarlist[i])[j].rhs))
modeqs[parv] = dfs
modeql[parv] = dfl
modeqs.pop('empty')
modeql.pop('empty')
###########################################################################################################################
