dataset <- read.csv("final data.csv")
summary(dataset)
dim(dataset)

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

# Remove specific rows with null values 
airbnbdata[airbnbdata==""]= NA
dim(airbnbdata)
airbnb<- removeRowsWithNA(airbnbdata, c("neighbourhood","first_review","last_review", "host_since", "host_identity_verified","zipcode"))
sum(is.na(airbnb$zipcode))
dim(airbnb)
#Replacing null values with mean and converting categorical to numerical variables
airbnb[airbnb==""] = NA
airbnb$host_response_rate <- as.numeric(gsub("%", "", as.character(airbnb$host_response_rate)))
airbnb$host_identity_verified<-as.numeric(airbnb$host_identity_verified)
airbnb$bed_type<-as.numeric(airbnb$bed_type)
airbnb$cancellation_policy<-as.numeric(airbnb$cancellation_policy)
airbnb$room_type<-as.numeric(airbnb$room_type)
airbnb$cleaning_fee<-as.numeric(airbnb$cleaning_fee)
airbnb$instant_bookable<-as.numeric(airbnb$instant_bookable)
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


#Boston_City PriceModel
Boston_data <- airbnb[ which(airbnb$city=='Boston'), ]
summary(Boston_data)
dim(Boston_data)

Boston_model <- lm(Boston_data$log_price~ Boston_data$accommodates + Boston_data$bathrooms + Boston_data$room_type 
                   + Boston_data$bedrooms + Boston_data$review_scores_rating + Boston_data$cleaning_fee 
                   + Boston_data$host_response_rate + Boston_data$instant_bookable + Boston_data$property_type 
                   + Boston_data$neighbourhood)
step(Boston_model, direction = "backward")
                   
summary(Boston_model)
Boston_model_error = residuals(Boston_model)
qqnorm(Boston_model_error)
qqline(Boston_model_error)

#Chicago_City PriceModel
Chicago_data <- airbnb[ which(airbnb$city=='Chicago'), ]
summary(Chicago_data)
dim(Chicago_data)
Chicago_model<-lm(Chicago_data$log_price~ Chicago_data$accommodates + Chicago_data$bathrooms + Chicago_data$room_type 
                  + Chicago_data$bedrooms + Chicago_data$review_scores_rating + Chicago_data$cleaning_fee + Chicago_data$host_response_rate 
                  + Chicago_data$number_of_reviews + Chicago_data$beds + Chicago_data$instant_bookable + Chicago_data$neighbourhood 
                  + Chicago_data$property_type)
step(Chicago_model, direction = "backward")

summary(Chicago_model)

Chicago_model_error = residuals(Chicago_model)
qqnorm(Chicago_model_error)
qqline(Chicago_model_error)

#DC_City PriceModel
DC_data <- airbnb[ which(airbnb$city=='DC'), ]
DC_data
summary(DC_data)
dim(DC_data)
DC_model <- lm(DC_data$log_price~ DC_data$accommodates + DC_data$bathrooms + DC_data$room_type 
               + DC_data$bedrooms + DC_data$review_scores_rating + DC_data$cleaning_fee
               + DC_data$number_of_reviews + DC_data$beds  + DC_data$cancellation_policy + DC_data$neighbourhood 
               + DC_data$property_type)
step(DC_model, direction = "backward")

summary(DC_model)
DC_model_error = residuals(DC_model)
qqnorm(DC_model_error)
qqline(DC_model_error)

#LA_City PriceModel
LA_data <- airbnb[ which(airbnb$city=='LA'), ]
LA_data
summary(LA_data)
dim(LA_data)
LA_model<-lm(LA_data$log_price~ LA_data$accommodates + LA_data$bathrooms + LA_data$room_type 
             + LA_data$bedrooms + LA_data$review_scores_rating + LA_data$number_of_reviews +
               LA_data$beds + LA_data$cancellation_policy + LA_data$host_response_rate + LA_data$bed_type
             + LA_data$instant_bookable+ LA_data$neighbourhood + LA_data$property_type)
step(DC_model, direction = "backward")

summary(LA_model)
LA_model_error = residuals(LA_model)
qqnorm(LA_model_error)
qqline(LA_model_error)

#NYC_City PriceModel
NYC_data <- airbnb[ which(airbnb$city=='NYC'), ]
NYC_data
summary(NYC_data)
dim(NYC_data)
NYC_model <- lm(NYC_data$log_price~ NYC_data$accommodates + NYC_data$bathrooms + NYC_data$room_type 
                + NYC_data$bedrooms + NYC_data$review_scores_rating + NYC_data$number_of_reviews + NYC_data$cleaning_fee 
                + NYC_data$host_identity_verified + NYC_data$beds  + NYC_data$cancellation_policy 
                + NYC_data$host_response_rate+NYC_data$instant_bookable + NYC_data$neighbourhood + NYC_data$property_type)
step(NYC_model, direction = "backward")

summary(NYC_model)

NYC_model_error = residuals(NYC_model)
qqnorm(NYC_model_error)
qqline(NYC_model_error)

#San Francisco_City PriceModel
SF_data <- airbnb[ which(airbnb$city=='SF'), ]
SF_data
summary(SF_data)
dim(SF_data)
SF_model <- lm(SF_data$log_price~ SF_data$accommodates + SF_data$bathrooms + SF_data$room_type 
               + SF_data$bedrooms + SF_data$review_scores_rating + SF_data$bed_type + SF_data$number_of_reviews
               + SF_data$neighbourhood + SF_data$property_type + SF_data$host_identity_verified)
step(SF_model, direction = "backward")

summary(SF_model)

SF_model_error = residuals(SF_model)
qqnorm(SF_model_error)
qqline(SF_model_error)

#correlation
corr<- c("accommodates", "bathrooms" , "bedrooms", "review_scores_rating", "number_of_reviews")
NYC_data_corr<-NYC_data[corr]
pairs(NYC_data_corr)