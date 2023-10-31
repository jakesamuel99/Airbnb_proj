project <- read.csv("final data.csv")

table(project$property_type)

a <- table(project$property_type)
View(a)



x<- c("Apartment", "House","Others(33)")
names(x)
y <- c(49003/74111*100 , 16511/74111*100 ,8597/74111*100)
z <- round( y , digits = 2)
lbls2 <- paste(x, z , "%")
pie( y , labels = lbls2 , main = "Property Type")


