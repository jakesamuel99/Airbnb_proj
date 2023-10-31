Airbnb <- read.csv("Airbnb.csv")

mean(Airbnb$Price[which(Airbnb$city=="LA"&Airbnb$property_type=="Apartment")])
mean(Airbnb$Price[which(Airbnb$city=="NYC"&Airbnb$property_type=="Apartment")])
mean(Airbnb$Price[which(Airbnb$city=="Chicago"&Airbnb$property_type=="Apartment")])
mean(Airbnb$Price[which(Airbnb$city=="SF"&Airbnb$property_type=="Apartment")])
mean(Airbnb$Price[which(Airbnb$city=="Boston"&Airbnb$property_type=="Apartment")])
mean(Airbnb$Price[which(Airbnb$city=="DC"&Airbnb$property_type=="Apartment")])
subset_apt_nyc<-Airbnb[which(Airbnb$property_type=="Apartment" & Airbnb$city=="NYC"),]
subset_apt_dc<-Airbnb[which(Airbnb$property_type=="Apartment" & Airbnb$city=="DC"),]
subset_apt_Boston<-Airbnb[which(Airbnb$property_type=="Apartment" & Airbnb$city=="Boston"),]
subset_apt_Chicago<-Airbnb[which(Airbnb$property_type=="Apartment" & Airbnb$city=="Chicago"),]
subset_apt_SF<-Airbnb[which(Airbnb$property_type=="Apartment" & Airbnb$city=="SF"),]
subset_apt_LA<-Airbnb[which(Airbnb$property_type=="Apartment" & Airbnb$city=="LA"),]
##### House
subset_apt_nyc<-Airbnb[which(Airbnb$property_type=="House" & Airbnb$city=="NYC"),]
subset_apt_dc<-Airbnb[which(Airbnb$property_type=="House" & Airbnb$city=="DC"),]
subset_apt_Boston<-Airbnb[which(Airbnb$property_type=="House" & Airbnb$city=="Boston"),]
subset_apt_Chicago<-Airbnb[which(Airbnb$property_type=="House" & Airbnb$city=="Chicago"),]
subset_apt_SF<-Airbnb[which(Airbnb$property_type=="House" & Airbnb$city=="SF"),]
subset_apt_LA<-Airbnb[which(Airbnb$property_type=="House" & Airbnb$city=="LA"),]
#####
subset_apt_nyc$Class <- ifelse(subset_apt_nyc$Price>=mean(subset_apt_nyc$Price),1,0)
subset_apt_dc$Class <- ifelse(subset_apt_dc$Price>=mean(subset_apt_dc$Price),1,0)
subset_apt_Boston$Class <- ifelse(subset_apt_Boston$Price>=mean(subset_apt_Boston$Price),1,0)
subset_apt_LA$Class <- ifelse(subset_apt_LA$Price>=mean(subset_apt_LA$Price),1,0)
subset_apt_SF$Class <- ifelse(subset_apt_SF$Price>=mean(subset_apt_SF$Price),1,0)
subset_apt_Chicago$Class <- ifelse(subset_apt_Chicago$Price>=mean(subset_apt_Chicago$Price),1,0)

