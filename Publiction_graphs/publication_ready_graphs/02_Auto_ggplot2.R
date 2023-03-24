# publication graphs (part-2)
##################################
#install following packages
##################################
install.packages("readxl")
install.packages("tidyverse")
install.packages("devtools")
devtools::install_github("JLSteenwyk/ggpubfigs")
install.packages("esquisse")
install.packages("hrbrthemes")

###################################
#load All packages
###################################
library(readxl)
library(tidyverse)
library(devtools)
library(ggpubfigs)
library(esquisse)
library(hrbrthemes)
####################################
#import Data set in R
####################################
data("midwest") #scater plot
data("iris")
data("mtcars") #heatmaps 
data("PlantGrowth")
#####################################

#####################################

esquisser() #show the IDE to import the dataset.(use Atuo_ggplotin)
#####################################
#creat the bar plot for plantGrowth data set.
#####################################
ggplot(PlantGrowth) +
  aes(x = group, y = weight, fill = group, colour = group) +
  geom_col() +
  scale_fill_manual(
    values = c(ctrl = "#470457",
               trt1 = "#22908B",
               trt2 = "#FDE725")
  ) +
  scale_color_manual(
    values = c(ctrl = "#470457",
               trt1 = "#22908B",
               trt2 = "#FDE725")
  ) +
  labs(
    x = "Treatmetns",
    y = "palnt Weight(g)",
    subtitle = "barplot.Autoplot"
  ) +
  theme_classic()

#######################################
# creat the heatmap for midwest dataset.
######################################
ggplot(midwest) +
  aes(x = state, y = category, fill = area) +
  geom_tile() +
  scale_fill_gradient() +
  theme_minimal() +
  facet_wrap(vars(inmetro))
