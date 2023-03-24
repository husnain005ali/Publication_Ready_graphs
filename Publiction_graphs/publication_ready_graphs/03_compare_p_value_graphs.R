# publicatoin ready Graphs (part-03)
####################################################
# install following packages
####################################################
install.packages("readxl")
install.packages("tidyverse")
install.packages("ggplot2")
####################################################
# Main packag
install.packages("ggpubr")
####################################################
# Load all Packages
###################################################
library(readxl)
library(tidyverse)
library(ggpubr)
library(ggplot2)
##################################################
# import data set in R
###################################################
data("ToothGrowth")
####################################################
# simple boxplot
p1 <- ggboxplot(ToothGrowth, x = "dose", y = "len",
                color = "dose", palette = c("blue", "red", "green"),
                add = "jitter", shape = "dose",
                xlab = "Dose", ylab = "Length", legend.title = "Dose")
p1
#showing mean comparison
# Specify the comparisions you wnat
my_comparisons <- list(c("0.5", "0.1"), c("1", "2"), c("0.5", "2"))
# show significant stars
p1 + stat_compare_means(comparisons = my_comparisons,
                        method = "t.test",
                        label = "p.signif",
                        )+ # add pariwise comparisons p-value
  stat_compare_means(label.y = 30)+ylim(0,60) # Add global p-value
#against control treatment or reference group
p1 + stat_compare_means(label.y = 42,
                        method = "t.test",
                        label = "p.signif",
                        ref.group = "0.5")
# show p-values
p1 <- p1 + stat_compare_means(comparisons = my_comparisons)+ #add pariwise 
  stat_compare_means(label.y = 50)+ylim(0,60);p1 # Add global p-value
######################################################
#multiple grouping variable
#####################################################
# BOx plot facetted by "dose"
p2 <- ggboxplot(ToothGrowth, x = "supp", y = "len",
                color = "supp", palette = "npg",
                add = "jitter",
                facet.by = "dose", short.panel.labs = FALSE)
p2
# use only p.format as label. Remove method name.
p2 <-p2 + stat_compare_means(
  aes(label = paste0("p = ", ..p.format..))
)
p2
