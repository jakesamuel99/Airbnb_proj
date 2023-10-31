# Optimizing Airbnb Listings: Insights and Recommendations for Property Owners/Investors

This was a group-based project that I led in 2020 where we obtained a data set on Airbnb Listings and deployed various machine learning and data analytics techniques to uncover valuable listing insights. Other contributers to this project were Aarthi Ashokan, Joel Alencherry, Reeva Sanghavi, and Aditya Meher.



**Problem Statement:**

Airbnb, Inc. is an American vacation rental online marketplace company based in San Francisco, California, United States. Airbnb maintains and hosts a marketplace, accessible to consumers on its website or via an app. Through the service, users can arrange lodging, primarily homestays, and tourism experiences or list their properties for rental.

We acquired a data set of 74111 Airbnb listings in major US cities from 2015-2017, with each listing having 29 attributes. The goal of this analysis is to gain valuable insight for Airbnb property owners/investors wanting to create profitable listings by answering:

- How do listing prices vary between major US cities?
- Which attributes are most influential on listing prices?
- How do customer preferences impact whether their desired homestay will be cheap or expensive (relatively)?
- Which amenities are expected and which come with higher priced properties?

**Skills Demonstrated:**
Data pre-processing, feature engineering

**Tools Used:**
R, Excel, Tableau

**Data:**
This data was collected by Rudy Mizrahi and is accessible using this [link](https://www.kaggle.com/rudymizrahi/airbnb-listings-in-major-us-cities-deloitte-ml?select=train.csv).



### How do listing prices vary between major US cities?

The data was first preprocessed in the following manner:

- Cleaning & handling missing data
  - Removed rows with missing values of neighbourhood, first_review, last_review, host_since, host_identity_verified, and zip code.
  - Replacing rows with missing values with the mean value for bathrooms, log_price, accommodates, host_response_rate, review_score_rating, bedrooms, and beds.
- Data Conversion
  - Converted the log_price into original price.
  - Changed the host_response_rate from character type to numeric data type.

Tableau was used to create a bar chart of the average listing price of each city.

After averaging the booking prices across cities, SF had the highest average cost while Chicago had the lowest average cost. This information on listing costs could help Airbnb users decide which cities they could afford to visit.



### Which attributes are most influential on listing prices by city?

Due to large price variation across cities, a linear regression model was developed for each city. These models did not include listing ID, latitude, longitude, zipcode, first_review, last_review, host_since as they were assumed to not have a significant impact on price compared to other attributes. Stepwise regression was executed to remove attributes that did not have a strong relationship to price.

Before proceeding to develop linear regression models, a correlation matrix was created to assess covariance between input variables and normal QQ plots were created to ensure normality of residuals. There was no covariance, and the residuals followed a relatively normal distribution, so it was safe to proceed to develop linear regression models. The following table shows the factors affecting price and the adjusted R-sq values for each model.

![](/images/airbnb_regression.png)

For all the cities, the prices depend on the number of accommodates, number of bathrooms, room_type, bedrooms, review_score_rating, neighbourhood, and property_type. Additionally, models for each city have their own unique input variables that impact listing price. All of the input variables that most impact listing price for each city are shown in the tables.



### How do customer preferences impact whether their desired homestay will be cheap or expensive (relatively)?

**Method:**
1. Data was subsetted by city and property type (houses & apartments)
2. Subsets were split into 80% train data and 20% test data
3. Listing prices were compared to the average price of the subset and were classified as either ‘Inexpensive’ (Price < Avg) or ‘Expensive’ (Price > Avg)
4. Naive Bayes, Decision Trees, and Logistic Regression models were developed using train data to classify listings as either inexpensive or expensive based on attributes
5. Method accuracies were compared using confusion matrix on test data

The classifier accuracies for each city and property type are as follows:

![](/images/airbnb_modelperformance.png)

For both property types, the Naive Bayes classifier outperformed the Logistic Regression and Decision Tree classifiers.

With varying levels of accuracy that depend on the city and property type, the Naive Bayes classifier can determine if a customer will opt for a relatively expensive or inexpensive property based on their specific preferences. This knowledge can help in setting competitive and attractive prices that align with customer preferences.



### Which amenities are expected and which come with higher priced properties?

**Method:**
1. Text mining was implemented on the attribute amenities
2. 6 clusters were created using K-Means clustering on the basis of price
3. The most common amenities were determined for each cluster

Below visually demonstrates the text mining implementation on amenities.
![](/images/airbnb_textmining.png)

The table below shows the frequency of various amenities for the different clusters.
![](/images/airbnb_amenities.png)

Analysis:

- Almost all amenities are more frequent in expensive listings than in cheap listings.
- Basic amenities have nearly the same frequency across all clusters, whereas ‘special’ amenities may be 1.5x or more frequent in expensive clusters than in cheap clusters.
  

## Recommendations:

1. **Select Your City Strategically:** If you aim for higher average listing prices, consider investing in properties in cities like San Francisco. For lower initial investment costs, explore opportunities in cities like Chicago.
2. **Emphasize Special Amenities:** Features such as parking, indoor fireplaces, and gym access can significantly boost the value of your property as these amenities are at least 50% more common in expensive listings than in cheap ones.
3. **Optimize Accommodations:** Ensure that your property can accommodate larger. Space management and adding items such as pull-out beds can be simple ways to accommodate more people and increase the listing value.
4. **Maximize Positive Reviews:** Prioritize providing excellent service and ensuring guests have a great experience as high review scores are influential in determining pricing potential.
