library(reticulate)
fqs <- reticulate::import("fqs")
p4 <- c(1,2,3,4,5)
fqs$quartic_roots(p1)
p3 <- c(1,2,3,4)
fqs$cubic_roots(p3)


