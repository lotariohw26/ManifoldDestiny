#!/bin/bash

## R
cp -f R/wasmconverting.R MD_WASMP/wasmconverting.R
cp -f R/wasmconverting.R MD_WASMS/examples/r/MD-sandbox/wasmconverting.R

## Shiny
cp -f shinyapps/r2rsim/app.R MD_WASMS/examples/r/MD-r2rsim/app.R
cp -f shinyapps/empapp/app.R MD_WASMS/examples/r/MD-empapp/app.R
cp -f shinyapps/restor/app.R MD_WASMS/examples/r/MD-restor/app.R
cp -f shinyapps/manimp/app.R MD_WASMS/examples/r/MD-manimp/app.R

# Python
cp -f script/python/polysolver.py MD_WASMS/examples/python/sandbox/polysolver.py
