# -publication Ready Graph (part-1)
#############################################
#install following packages
#############################################
install.packages("readxl")
install.packages("tidyverse")
install.packages("agricolae")
install.packages("devtools")
install.packages("WriteXLS")
devtools::install_github("JLSteenwyk/ggpubfigs")
install.packages("ggpubr")
install.packages("writexl")
install.packages("magrittr")
install.packages("dplyr")
install.packages("agricolae")
install.packages("ggplot2")
install.packages("ggthemes")
#############################################
#Load All packages
#############################################
library(readxl)
library(tidyverse)
library(agricolae)
library(WriteXLS)
library(ggpubfigs)
library(ggpubr)
library(writexl)
library(magrittr)
library(dplyr)
library(agricolae)
library(ggplot2)
library(ggthemes)
#############################################
#Load Data
############################################
data("PlantGrowth") #built in dataset
#set your directory pressing  (ctrl + shift + H)
write_xlsx(PlantGrowth, "E:\\R_Language\\Publiction_graphs\\publication_ready_graphs\\PlantGrowth.xlsx")
input_data <- read_excel("PlantGrowth.xlsx")
print(input_data)
#############################################
#Statistical Analysis of Data (TUKEY .HSD test)
#############################################
value_max = input_data %>%
  group_by(group) %>%
  summarize(max_value = max(weight)) #calculating the maximum value to draw letters

hsd = HSD.test(aov(weight ~ group, data = input_data), trt = "group", group =T) #give the complete summary of two groups
sig.letters <- hsd$groups[order(row.names(hsd$groups)), ] #to show the mean and groups

#############################################
#Visualization
#############################################
ggplot(data = input_data, aes(x = group, y = weight, fill = group))+
  geom_boxplot()+
  stat_boxplot(geom = "errorbar", width =0.1)+
  geom_text(data = value_max, aes(x = group, y = 0.15 + max_value,
                                  label = sig.letters$groups), vjust=0)+
  ggtitle("") + xlab("Treatments") + ylab("plant weight (g)")+
  scale_fill_manual(values = friendly_pal("bright_seven")) + theme_simple()+
  theme(legend.position = "none")+
  ggsave("shoot_length.tiff", units="in", width=8, height=8, dpi=300, compression = "lzw")


library(ggthemes)

ggplot(data = input_data, aes(x = group, y = weight, fill = group))+
  geom_boxplot()+
  stat_boxplot(geom = "errorbar", width =0.1)+
  geom_text(data = value_max, aes(x = group, y = 0.15 + max_value,
                                  label = sig.letters$groups), vjust=0)+
  ggtitle("") + xlab("Treatments") + ylab("plant weight (g)")+
  scale_fill_manual(values = friendly_palette("bright_seven")) + theme_simple()+
  theme(legend.position = "none")+
  ggsave("shoot_length.tiff", units="in", width=8, height=8, dpi=300, compression = "lzw")
