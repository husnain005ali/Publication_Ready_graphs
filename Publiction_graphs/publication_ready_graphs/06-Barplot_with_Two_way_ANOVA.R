# publication Ready graph part -06
####################################################
# isntalll packages
###################################################
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("multcompview")
install.packages("dplyr")
install.packages("stats")
###################################################
# Load packages
###################################################
data2 <- ToothGrowth
data2$dose = as.factor(data2$dose)
##################################################
# 2- calculating Two Way ANOVA
anova <- aov(len ~ supp*dose, data = data2) # tow way anova
summary(anova)
###################################################
# 3- Multiple mean comparison analysis (only if you have significant difference in TWO-Way anova)
tukey <- TukeyHSD(anova)
tukey
###################################################
## 4- Extract lettering from TWO-WAY-ANOVA and Tukey's Test.
group_lettering <- multcompLetters4(anova,tukey)
group_lettering

group_lettering2 <- data.frame(group_lettering$`supp:dose`$Letters)
group_lettering2
#####################################################
## 5- Calculating and addinf mean, sd and letting columns to the dat set.
#######################################################
mean_data2 <- data2 %>%
  group_by(supp, dose) %>%
  summarise(len_mean = mean(len), sd = sd(len)) %>%
  arrange(desc(len_mean))
summarise()
tibble(mean_data2)

mean_data2$group_lettering <- group_lettering2$group_lettering..supp.dose..Letters
mean_data2
##########################################################
## 6- Drawing publication ready Barplot with TOW-WAY ANOVA
###########################################################
ggplot(mean_data2, aes(x = dose, y = len_mean, group = supp, fill = supp)) +
  geom_bar(position = position_dodge(width = 0.9), stat = "identity", show.legend = TRUE)
## show the error bars
ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",aes(fill = supp), show.legend = TRUE)+
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),width = 0.1, position = position_dodge(0.9))
## add lettering to error bars
ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",aes(fill = supp), show.legend = TRUE)+ #barplot
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),width = 0.1, position = position_dodge(0.9))+
  geom_text(aes(label = group_lettering, y = len_mean + sd), vjust =-0.4, position = position_dodge(0.9))#add letters
# final barplot with TWO-WAy ANOVA(type-1)
p <- ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",aes(fill = supp), show.legend = TRUE)+ #barplot
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),width = 0.1, position = position_dodge(0.9))+
  geom_text(aes(label = group_lettering, y = len_mean + sd), vjust =-0.4, position = position_dodge(0.9))+#add letters
  scale_fill_brewer(palette = "BrBG", direction = 1) + #these setting
  labs(
    x = "Dose",
    y = "length (cm)",
    title = "Group Barplot",
    subtitle = "made by HUSNAIN ALI",
    fill = "Dose"
  )+
  ylim(0,35)+
  ggthemes::theme_par()
p
#using facet_wrap 
p1 <- ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",aes(fill = supp), show.legend = TRUE)+ #barplot
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),width = 0.1, position = position_dodge(0.9))+
  geom_text(aes(label = group_lettering, y = len_mean + sd), vjust =-0.4, position = position_dodge(0.9))+#add letters
  scale_fill_brewer(palette = "BrBG", direction = 1) + #these setting
  labs(
    x = "Dose",
    y = "length (cm)",
    title = "Group Barplot",
    subtitle = "made by HUSNAIN ALI",
    fill = "Dose"
  )+
  facet_wrap(~supp)
  ylim(0,35)+
  ggthemes::theme_par()
  p1
#####################################################
## save the graph
####################################################
  tiff("barplot_G1.tiff", units = "in", height = 6, res = 300,compression = "lzw")
  p
  dev.off()
  ##2nd graph
  tiff("barplot_G2.tiff", units = "in", height = 6, res = 300,compression = "lzw")
  p1
  dev.off()
  