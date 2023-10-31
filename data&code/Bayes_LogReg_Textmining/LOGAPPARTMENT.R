### LOG NYC
set.seed(5)
library(tidyverse)
library(dslabs)
library(InformationValue)

set.seed(5)
ind <- sample(2, nrow(subset_apt_nyc), replace=T, prob = c(0.8,0.2))
train <- subset_apt_nyc[ind==1,]
test <- subset_apt_nyc[ind==2,]
test
logit<-glm(as.factor(train$Class)~factor(train$room_type)+factor(train$bed_type)+factor(train$cancellation_policy)+factor(train$cleaning_fee)+train$accommodates+train$bathrooms+train$host_response_rate+train$number_of_reviews+train$review_scores_rating+train$bedrooms+train$beds,family =binomial(link = logit),data=train,maxit=100)
predictionlog<-plogis(predict(logit,test))
optCutOff <-optimalCutoff(as.factor(test$Class), predictionlog)[1]
optCutOff
confusionMatrix((test$Class),predictionlog[1:454])
pred1<-ifelse(predictionlog>1,1,0)
tab<-table(Predicted=pred1[1:454],Actual=test$Class)
acc<-(sum(diag(tab)))/(sum(tab))
acc
### LOG BOSTON
set.seed(5)
ind <- sample(2, nrow(subset_apt_Boston), replace=T, prob = c(0.8,0.2))
train <-subset_apt_Boston[ind==1,]
test <- subset_apt_Boston[ind==2,]
logit<-glm(as.factor(train$Class)~factor(train$room_type)+factor(train$bed_type)+factor(train$cancellation_policy)+factor(train$cleaning_fee)+train$accommodates+train$bathrooms+train$host_response_rate+train$number_of_reviews+train$review_scores_rating+train$bedrooms+train$beds,family =binomial(link = logit),data=train,maxit=100)
predictionlog<-plogis(predict(logit,test))
optCutOff <-optimalCutoff(as.factor(test$Class), predictionlog)[1]
optCutOff
confusionMatrix((test$Class),predictionlog[1:109])
pred1<-ifelse(predictionlog>1,1,0)
tab<-table(Predicted=pred1[1:109],Actual=test$Class)
acc<-(sum(diag(tab)))/(sum(tab))
acc
### LOG CHICAGO
set.seed(5)
ind <- sample(2, nrow(subset_apt_Chicago), replace=T, prob = c(0.8,0.2))
train <- subset_apt_Chicago[ind==1,]
test <- subset_apt_Chicago[ind==2,]

logit<-glm(as.factor(train$Class)~factor(train$room_type)+factor(train$bed_type)+factor(train$cancellation_policy)+factor(train$cleaning_fee)+train$accommodates+train$bathrooms+train$host_response_rate+train$number_of_reviews+train$review_scores_rating+train$bedrooms+train$beds,family =binomial(link = logit),data=train,maxit=100)
predictionlog<-plogis(predict(logit,test))
optCutOff <-optimalCutoff(as.factor(test$Class), predictionlog)[1]
optCutOff
confusionMatrix((test$Class),predictionlog[1:94])
pred1<-ifelse(predictionlog>1,1,0)
tab<-table(Predicted=pred1[1:94],Actual=test$Class)
acc<-(sum(diag(tab)))/(sum(tab))
acc
### LOG LA
set.seed(5)
ind <- sample(2, nrow(subset_apt_LA), replace=T, prob = c(0.8,0.2))
train <-subset_apt_LA[ind==1,]
test <- subset_apt_LA[ind==2,]
logit<-glm(as.factor(train$Class)~factor(train$room_type)+factor(train$bed_type)+factor(train$cancellation_policy)+factor(train$cleaning_fee)+train$accommodates+train$bathrooms+train$host_response_rate+train$number_of_reviews+train$review_scores_rating+train$bedrooms+train$beds,family =binomial(link = logit),data=train,maxit=100)
predictionlog<-plogis(predict(logit,test))
optCutOff <-optimalCutoff(as.factor(test$Class), predictionlog)[1]
optCutOff
confusionMatrix((test$Class),predictionlog[1:1079])
pred1<-ifelse(predictionlog>1,1,0)
tab<-table(Predicted=pred1[1:1079],Actual=test$Class)
acc<-(sum(diag(tab)))/(sum(tab))
acc
### SF
set.seed(5)
ind <- sample(2, nrow(subset_apt_SF), replace=T, prob = c(0.8,0.2))
train <-subset_apt_SF[ind==1,]
test <- subset_apt_SF[ind==2,]
logit<-glm(as.factor(train$Class)~factor(train$room_type)+factor(train$bed_type)+factor(train$cancellation_policy)+factor(train$cleaning_fee)+train$accommodates+train$bathrooms+train$host_response_rate+train$number_of_reviews+train$review_scores_rating+train$bedrooms+train$beds,family =binomial(link = logit),data=train,maxit=100)
predictionlog<-plogis(predict(logit,test))
optCutOff <-optimalCutoff(as.factor(test$Class), predictionlog)[1]
optCutOff
confusionMatrix((test$Class),predictionlog[1:332])
pred1<-ifelse(predictionlog>1,1,0)
tab<-table(Predicted=pred1[1:332],Actual=test$Class)
acc<-(sum(diag(tab)))/(sum(tab))
acc
####dc
set.seed(5)
ind <- sample(2, nrow(subset_apt_dc), replace=T, prob = c(0.8,0.2))
train <-subset_apt_dc[ind==1,]
test <- subset_apt_dc[ind==2,]
logit<-glm(as.factor(train$Class)~factor(train$room_type)+factor(train$bed_type)+factor(train$cancellation_policy)+factor(train$cleaning_fee)+train$accommodates+train$bathrooms+train$host_response_rate+train$number_of_reviews+train$review_scores_rating+train$bedrooms+train$beds,family =binomial(link = logit),data=train,maxit=100)
predictionlog<-plogis(predict(logit,test))
optCutOff <-optimalCutoff(as.factor(test$Class), predictionlog)[1]
optCutOff
confusionMatrix((test$Class),predictionlog[1:241])
pred1<-ifelse(predictionlog>1,1,0)
tab<-table(Predicted=pred1[1:241],Actual=test$Class)
acc<-(sum(diag(tab)))/(sum(tab))
acc
