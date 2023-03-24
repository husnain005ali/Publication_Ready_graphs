# publication ready Graph,s part-8
## create the heatmape-----
x <- as.matrix(mtcars)
heatmap(x, scale = "column")

##########################################
## -ggplot
install.packages("gplots")
library(gplots)
heatmap.2(x,scale = "column", col = bluered(90),
          trace = "none")
#################################################
## p-heatmaps
install.packages("pheatmap")
library(pheatmap)
pheatmap(x, scale = "column", cutree_rows = 4, cutree_cols = 2)

####################################################
install.packages("reshape")
library(reshape)
y2 <- melt(iris)
## creat the plots
library(ggplot2)
ggplot(y2, aes(y2$Species , y2$variable, fill = y2$value))+
  geom_tile()+
  scale_fill_gradient(low= "yellow", high =  "red")
 