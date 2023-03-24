# publication Ready Graphs part-05
#########################################################
# install data packages
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("multcompView")
install.packages("dplyr")
##########################################################
# load these packages
#########################################################
library(ggplot2)
library(ggthemes)
library(multcompView)
library(dplyr)
########################################################
# Load the data set.
data("chickwts")
tibble(chickwts) # check the characterstic
#########################################################
 ## 2- calculate "means" of you teatment group an the "standard deviation" SD to show on error bas as follow
mean_data <- group_by(chickwts, feed) %>% # feed is our treatment in this example
  summarise(weight_mean=mean(weight), sd = sd(weight)) %>% # to calculate mean and SD
  arrange(desc(weight_mean)) # to arange in descending order
tibble(mean_data)
##########################################################
## 3- this step involves performing analysis of varience "ANOVA", uisng buitin **aov()** function
library(stats)
anova <- aov(weight ~ feed, data = chickwts) # show the feed difference from weight
summary(anova)
##########################################################
# 4-if the ANOVA is significantly differenct then, we will draw a multiple mean comparison
tukey <- TukeyHSD(anova)
tukey 
#########################################################
# 5- Draw multiple comparison letters using *multcomp* R package as follows:
group_letters <- multcompLetters4(anova, tukey)
group_letters
#extracting group letters
group_letters <- as.data.frame.list(group_letters$feed)
group_letters 
#adding to the mean_data
mean_data$group_letters <- group_letters$Letters
tibble(mean_data)
##########################################################
# -6 Drawing the *publication ready barplot* in ggplot2
p <- ggplot(mean_data, aes(x = feed, y = weight_mean))+
  geom_bar(stat = "identity", aes(fill = feed), show.legend = FALSE, width = 0.6) +# barplot
  geom_errorbar( #this argument is putting sd as error bars
    aes(ymin = weight_mean-sd, ymax = weight_mean+sd),
    width = 0.1
  )+
  geom_text(aes(label = group_letters, y = weight_mean + sd), vjust = -0.4) + #add letters
  scale_fill_brewer(palette = "BrBG", direction = 1) + #theme setting
  labs( # this will add labels
    x = "Feed type",
    y = "chicken weight (g)",
    title = "Publication  Barplot",
    subtitle = "Made by Husnain_ali",
    fill = "Feed type"
  ) + 
  ylim(0, 410) + # change your yaxis limits based on the letters
  ggthemes::theme_par()
p
##############################################################
## 7- saving upto 4k barplots in r
tiff ("Barplot.tiff", units = "in", width = 10, height = 6, res = 300, compression = "lzw")
p
dev.off()
