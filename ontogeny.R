setwd("~/Dropbox/Growth Data/Growth")
growth<-read.csv("growth.csv", header=T)

library(lme4)
library(ggplot2)
library(dplyr)

#Clean up data
growth<-select(growth,-(X2D_R1_P1:X5D_L4_P2)) # remove extra data
growth<-growth[,-c(2,5,6,7,13,14,15,16,18,19,20,21,22,23,24,25,26,
                   27,28,30,31,32,33,34,36,37,38,39,41,43,44,45,46,
                   47,48,49,50,51,52,53,54,55,56,57,58,59,68,69,70,
                   71,72,73,74,75,76,83)]
growth<-select(growth,-(old_bro:sex_pre_sibN)) # remove extra data
colnames(growth)<-c("id","famid","year","sex","hand","birthdate",
                    "yob","colldate","age","dadid","momid","cm",
                    "kgs","r2d","l2d","r3d","l3d","r4d","l4d",
                    "r5d","l5d","famsize","birth_interval")
growth<-within(growth,{
  r2d4d<-growth$r2d/growth$r4d
  l2d4d<-growth$l2d/growth$l4d
  cm2<-growth$cm^2
  cm3<-growth$cm^3
  age_year<-round(growth$age)
  age2<-growth$age^2
  age3<-growth$age^3
})

# height by age year
ggplot(growth,aes(x = age_year, y = cm, color = factor(sex))) + geom_point() + 
  stat_smooth(method = loess, se = FALSE) 

# height by exact age
ggplot(growth,aes(x = age, y = cm, color = factor(sex))) + geom_point() + 
  stat_smooth(method = loess, se = FALSE)

# include lattice like plots


