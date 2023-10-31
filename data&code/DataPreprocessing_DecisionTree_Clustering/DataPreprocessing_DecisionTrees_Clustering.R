library(ggplot2)
library(grid)
library(dplyr)
library(cluster)
library(factoextra)
library(dendextend)
library(party)


dataset <- read.csv("final data.csv")
summary(dataset)
str(dataset)

# Cleaning Dataset
removeRowsWithNA <- function(data, desiredCols) 
{
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

variables_to_keep<- c("id","log_price","property_type","room_type","accommodates","bathrooms","bed_type","cancellation_policy",
                       "cleaning_fee","city","first_review","host_has_profile_pic","host_identity_verified","host_response_rate",
                       "host_since","instant_bookable","last_review","latitude","longitude","neighbourhood","number_of_reviews",
                       "review_scores_rating","zipcode"	,"bedrooms","beds")
airbnbdata<- dataset[variables_to_keep]
summary(airbnbdata)
airbnbdata[airbnbdata==""]= NA


sum((is.na(airbnbdata$neighbourhood)))
sum((is.na(airbnbdata$first_review)))
sum((is.na(airbnbdata$last_review)))
sum((is.na(airbnbdata$host_since)))
sum((is.na(airbnbdata$host_identity_verified)))
dim(airbnbdata)
airbnb<- removeRowsWithNA(airbnbdata, c("neighbourhood","first_review","last_review", "host_since", "host_identity_verified","zipcode"))
sum(is.na(airbnb$zipcode))
dim(airbnb)
airbnb[airbnb==""] = NA
airbnb$host_response_rate <- as.numeric(gsub("%", "", as.character(airbnb$host_response_rate)))

airbnb$bathrooms <- ifelse(is.na(airbnb$bathrooms), 
                            ave(airbnb$bathrooms, FUN = function(x) 
                              mean(x, na.rm = TRUE)), 
                           airbnb$bathrooms)

airbnb$log_price <- ifelse(is.na(airbnb$log_price), 
                            ave(airbnb$log_price, FUN = function(x) 
                              mean(x, na.rm = TRUE)), 
                           airbnb$log_price)

airbnb$accommodates <- ifelse(is.na(airbnb$accommodates), 
                              ave(airbnb$accommodates, FUN = function(x) 
                                mean(x, na.rm = TRUE)), 
                              airbnb$accommodates)

airbnb$host_response_rate <- ifelse(is.na(airbnb$host_response_rate), 
                                     ave(airbnb$host_response_rate, FUN = function(x) 
                                       mean(x, na.rm = TRUE)), 
                                    airbnb$host_response_rate)
airbnb$review_scores_rating <- ifelse(is.na(airbnb$review_scores_rating), 
                                       ave(airbnb$review_scores_rating, FUN = function(x) 
                                         mean(x, na.rm = TRUE)), 
                                      airbnb$review_scores_rating)
airbnb$bedrooms<- ifelse(is.na(airbnb$bedrooms), 
                          ave(airbnb$bedrooms, FUN = function(x) 
                            mean(x, na.rm = TRUE)), 
                         airbnb$bedrooms)
airbnb$beds<- ifelse(is.na(airbnb$beds), 
                      ave(airbnb$beds, FUN = function(x) 
                        mean(x, na.rm = TRUE)), 
                     airbnb$beds)
sum(is.na(airbnb))
summary(airbnb)

#converting log-price to normal price
airbnb$log_price <- exp(airbnb$log_price)
names(airbnb)[names(airbnb)=="log_price"] <- "Price"


#####Subset on city and property type#####
cancellation_policy <- as.factor(airbnb$cancellation_policy)
room_type <- as.factor(airbnb$room_type)
bed_type <- as.factor(airbnb$bed_type)
cleaning_fee <- as.factor(airbnb$cleaning_fee)
subset_apt_nyc<-airbnb[which(airbnb$property_type=="Apartment" & airbnb$city=="NYC"),]
subset_apt_dc<-airbnb[which(airbnb$property_type=="Apartment" & airbnb$city=="DC"),]
subset_apt_Boston<-airbnb[which(airbnb$property_type=="Apartment" & airbnb$city=="Boston"),]
subset_apt_Chicago<-airbnb[which(airbnb$property_type=="Apartment" & airbnb$city=="Chicago"),]
subset_apt_SF<-airbnb[which(airbnb$property_type=="Apartment" & airbnb$city=="SF"),]
subset_apt_LA<-airbnb[which(airbnb$property_type=="Apartment" & airbnb$city=="LA"),]

subset_hs_nyc<-airbnb[which(airbnb$property_type=="House" & airbnb$city=="NYC"),]
subset_hs_dc<-airbnb[which(airbnb$property_type=="House" & airbnb$city=="DC"),]
subset_hs_Boston<-airbnb[which(airbnb$property_type=="House" & airbnb$city=="Boston"),]
subset_hs_Chicago<-airbnb[which(airbnb$property_type=="House" & airbnb$city=="Chicago"),]
subset_hs_SF<-airbnb[which(airbnb$property_type=="House" & airbnb$city=="SF"),]
subset_hs_LA<-airbnb[which(airbnb$property_type=="House" & airbnb$city=="LA"),]

subset_apt_nyc$Class <- ifelse(subset_apt_nyc$Price>=mean(subset_apt_nyc$Price),1,0)
subset_apt_dc$Class <- ifelse(subset_apt_dc$Price>=mean(subset_apt_dc$Price),1,0)
subset_apt_Boston$Class <- ifelse(subset_apt_Boston$Price>=mean(subset_apt_Boston$Price),1,0)
subset_apt_LA$Class <- ifelse(subset_apt_LA$Price>=mean(subset_apt_LA$Price),1,0)
subset_apt_SF$Class <- ifelse(subset_apt_SF$Price>=mean(subset_apt_SF$Price),1,0)
subset_apt_Chicago$Class <- ifelse(subset_apt_Chicago$Price>=mean(subset_apt_Chicago$Price),1,0)

subset_hs_nyc$Class <- ifelse(subset_hs_nyc$Price>=mean(subset_hs_nyc$Price),1,0)
subset_hs_dc$Class <- ifelse(subset_hs_dc$Price>=mean(subset_hs_dc$Price),1,0)
subset_hs_Boston$Class <- ifelse(subset_hs_Boston$Price>=mean(subset_hs_Boston$Price),1,0)
subset_hs_LA$Class <- ifelse(subset_hs_LA$Price>=mean(subset_hs_LA$Price),1,0)
subset_hs_SF$Class <- ifelse(subset_hs_SF$Price>=mean(subset_hs_SF$Price),1,0)
subset_hs_Chicago$Class <- ifelse(subset_hs_Chicago$Price>=mean(subset_hs_Chicago$Price),1,0)

####Classification on Class for Apartments & Houses######

tree <- ctree(Class ~ accommodates+bathrooms+bedrooms+beds
              +host_response_rate+number_of_reviews+review_scores_rating
              +as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)
              +as.factor(bed_type), data = subset_hs_Boston, 
              controls = ctree_control(mincriterion = 0.9999, minsplit = 6))
print(tree)
plot(tree)
pred <- predict(tree, subset_hs_Boston)
tab <- table(Predicted = pred, Actual = subset_hs_Boston$Class)
acc <- sum(diag(tab))/sum(tab)
acc

####Clustering on Neighbourhood#####

am <- read.csv("am.csv")

am_kmeans <- kmeans(am$log_price,6)
#grouping
KmeanCluster1 = subset(am, am_kmeans$cluster==1)
KmeanCluster2 = subset(am, am_kmeans$cluster==2)
KmeanCluster3 = subset(am, am_kmeans$cluster==3)
KmeanCluster4 = subset(am, am_kmeans$cluster==4)
KmeanCluster5 = subset(am, am_kmeans$cluster==5)
KmeanCluster6 = subset(am, am_kmeans$cluster==6)

#6 most frequent words in each cluster
tail(sort(colMeans(KmeanCluster1)))
tail(sort(colMeans(KmeanCluster2)))
tail(sort(colMeans(KmeanCluster3)))
tail(sort(colMeans(KmeanCluster4)))
tail(sort(colMeans(KmeanCluster5)))
tail(sort(colMeans(KmeanCluster6)))

# kmean cluster plot
fviz_cluster(am_kmeans,am)

clus1 <- sort(colMeans(KmeanCluster1))
clus1[100:136]
clus2 <- sort(colMeans(KmeanCluster2))
clus2[100:136]
clus3 <- sort(colMeans(KmeanCluster3))
clus3[100:136]
clus4 <- sort(colMeans(KmeanCluster4))
clus4[100:136]
clus5 <- sort(colMeans(KmeanCluster5))
clus5[100:136]
clus6 <- sort(colMeans(KmeanCluster6))
clus6[100:136]