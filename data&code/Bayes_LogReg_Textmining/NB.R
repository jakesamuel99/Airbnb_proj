library(caret)
library(e1071)
###NB NYC
set.seed(4274)
ind <- sample(2, nrow(subset_apt_nyc), replace=T, prob = c(0.8,0.2))
train <- subset_apt_nyc[ind==1,]
test <- subset_apt_nyc[ind==2,]
modeln<-naiveBayes(as.factor(Class) ~ accommodates+bathrooms+bedrooms+beds+host_response_rate+number_of_reviews+review_scores_rating+as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)+as.factor(bed_type), data = train)
prediction1<-predict(modeln,test)
result1<-table(as.factor(test$Class),prediction1)
confusionMatrix(result1)
### NB LA
set.seed(4274)
ind <- sample(2, nrow(subset_apt_LA), replace=T, prob = c(0.8,0.2))
train <- subset_apt_LA[ind==1,]
test <- subset_apt_LA[ind==2,]
modeln<-naiveBayes(as.factor(Class) ~ accommodates+bathrooms+bedrooms+beds+host_response_rate+number_of_reviews+review_scores_rating+as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)+as.factor(bed_type), data = train)
prediction1<-predict(modeln,test)
result1<-table(as.factor(test$Class),prediction1)
confusionMatrix(result1)
### NB DC
set.seed(4274)
ind <- sample(2, nrow(subset_apt_dc), replace=T, prob = c(0.8,0.2))
train <- subset_apt_dc[ind==1,]
test <- subset_apt_dc[ind==2,]
modeln<-naiveBayes(as.factor(Class) ~ accommodates+bathrooms+bedrooms+beds+host_response_rate+number_of_reviews+review_scores_rating+as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)+as.factor(bed_type), data = train)
prediction1<-predict(modeln,test)
result1<-table(as.factor(test$Class),prediction1)
confusionMatrix(result1)
### NB Chicago
set.seed(4274)
ind <- sample(2, nrow(subset_apt_Chicago), replace=T, prob = c(0.8,0.2))
train <- subset_apt_Chicago[ind==1,]
test <- subset_apt_Chicago[ind==2,]
modeln<-naiveBayes(as.factor(Class) ~ accommodates+bathrooms+bedrooms+beds+host_response_rate+number_of_reviews+review_scores_rating+as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)+as.factor(bed_type), data = train)
prediction1<-predict(modeln,test)
result1<-table(as.factor(test$Class),prediction1)
confusionMatrix(result1)
### NB Boston
set.seed(4274)
ind <- sample(2, nrow(subset_apt_Boston), replace=T, prob = c(0.8,0.2))
train <- subset_apt_Boston[ind==1,]
test <- subset_apt_Boston[ind==2,]
modeln<-naiveBayes(as.factor(Class) ~ accommodates+bathrooms+bedrooms+beds+host_response_rate+number_of_reviews+review_scores_rating+as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)+as.factor(bed_type), data = train)
prediction1<-predict(modeln,test)
result1<-table(as.factor(test$Class),prediction1)
confusionMatrix(result1)
### NB SF
set.seed(4274)
ind <- sample(2, nrow(subset_apt_SF), replace=T, prob = c(0.8,0.2))
train <- subset_apt_SF[ind==1,]
test <- subset_apt_SF[ind==2,]
modeln<-naiveBayes(as.factor(Class) ~ accommodates+bathrooms+bedrooms+beds+host_response_rate+number_of_reviews+review_scores_rating+as.factor(cancellation_policy)+as.factor(cleaning_fee)+as.factor(room_type)+as.factor(bed_type), data = train)
prediction1<-predict(modeln,test)
result1<-table(as.factor(test$Class),prediction1)
confusionMatrix(result1)

