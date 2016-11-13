insurance <- read.csv(file.choose(), stringsAsFactors = TRUE)

str(insurance)

#Explore the data

summary(insurance$charges)

hist(insurance$charges)

table(insurance$region)

#Before fitting a regression model to data, it can be useful to determine how the

independent variables are related to the dependent variable and each other. A

correlation matrix provides a quick overview of these relationships

cor(insurance[c("age", "bmi", "children", "charges")])

pairs(insurance[c("age", "bmi", "children", "charges")])

#If we add more information to the plot, it can be even more useful

install.packages("psych")

library(psych)

pairs.panels(insurance[c("age", "bmi", "children", "charges")])

#Training a model on the data

ins_model <- lm(charges ~ age + children + bmi + sex +smoker + region, data =
                  
                  insurance)


# equivalent command

ins_model <- lm(charges ~ ., data = insurance)

ins_model

#evaluating model performance
p<-predict(ins_model,insurance[1338, ])
summary(ins_model)

#improving model performance