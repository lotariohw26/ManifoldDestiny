


library(reticulate)'
np <- import("numpy", convert = TRUE)
np1 <- np$array(c(1:4))
np1


reticulate::py_run_string("a=[1,3,3]")
a <- reticulate::py_run_string("print(a)", convert=T)
str(a)
