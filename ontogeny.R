setwd("~jamesbain/Dropbox/Growth Data/Growth")
growth<-read.csv("growth.csv", header=T)

#Clean up data
growth<-growth[,-c(60:123)]
growth<-growth[,-c(2,5,6,7,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,30,31,32,33,34,36,37,38,39,
                   41,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,68,69,70,71,72,73,74,75,76,83)]
colnames(growth)<-c("id","famid","year","sex","hand","birthdate","yob","colldate","age","dadid","momid",
                    "cm","kgs","r2d","l2d","r3d","l3d","r4d","l4d","r5d","l5d","old_bro","old_bro2",
                    "old_bro3","old_sis","old_sis2","old_sis3","oldsib_order", "sex_pre_sib2",
                    "sex_pre_sib","sex_pre_sibN","famsize","birth_interval")
growth$r2d4d<-growth$r2d/growth$r4d
growth$l2d4d<-growth$l2d/growth$l4d
growth$cmsq<-growth$cm^2

plot(growth$age,growth$cm)
plot(growth$age,growth$kgs)
plot(growth$cm,growth$kgs)

require(lme4)
require(ggplot2)
require(SSgompertz)

r_all<-lmer(r2d4d~cm+cmsq+sex+(1|momid/id),data=growth,REML=FALSE)
summary(r_all)

