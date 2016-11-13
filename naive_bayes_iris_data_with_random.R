#Naive bayes Algorithm
irisdata <- iris

str(irisdata)
# first 125 rows in the iris data set contains same values in rows 
iris_train <- iris[1:125,-5]

iris_train_labels <- iris[1:125,5]

iris_test <- iris[126:150,-5]

iris_test_labels <- iris[126:150,5]

prop.table(table(iris_train_labels))

#### select random Train and test samples ###

set.seed(123)

train_sample <- sample(150,100)

iris_train <- iris[train_sample,-5]

iris_train_labels <- iris[train_sample,5]

iris_test <- iris[-train_sample,-5]

iris_test_labels <- iris[-train_sample,5]

prop.table(table(iris_train_labels))
# applying algorithm
library(e1071)

iris_classifier <- naiveBayes(iris_train,iris_train_labels)

iris_classifier

iris_predict <- predict(iris_classifier,iris_test)

iris_predict

library(gmodels)

CrossTable( iris_test_labels,iris_predict,prop.chisq = FALSE)