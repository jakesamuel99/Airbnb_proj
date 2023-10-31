airbnb.df <- read.csv("final.data.csv")


table(airbnb.df$city)
names(table(airbnb.df$city))
a<-(table(airbnb.df$city)/74111)*100
round(a, digits = 2)
lbls2<-paste(names(table(airbnb.df$city)),round(a, digits = 2),"%")
pie(table(airbnb.df$city),labels = lbls2,main = "City")