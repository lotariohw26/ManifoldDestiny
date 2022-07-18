# install.packages("xtable")
library("xtable")
sample_table <- mtcars[1:3,1:3]
print(xtable(sample_table), type="html", file="example.html")
