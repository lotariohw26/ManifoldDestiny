








library(reticulate)
py_run_string("p = [10,29,30]")
tuple(p =c(1,2,3))
os <-reticulate::import("fqs")
os$cubic_roots(p)



