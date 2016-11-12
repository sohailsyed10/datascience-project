# read the input data

wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

str(wbcd)

#id column is not useful, lets drop it

wbcd <- wbcd[-1]

#diagnosis column is the category column, tells when benign or malignant

table(wbcd$diagnosis)

#convert the labels

wbcd$diagnosis<- factor(wbcd$diagnosis, levels = c("B", "M"),labels = c("Benign",
                                                                        
                                                                        "Malignant"))

# check the proportion of values of these categories

round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

#normalize the data

normalize <- function(x) {return ((x - min(x)) / (max(x) - min(x)))}

normalize(c(1, 2, 3, 4, 5))

normalize(c(10, 20, 30, 40, 50))

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_n$area_mean)

#Data preparation - creating training and test datasets

wbcd_train <- wbcd_n[1:469, ]

wbcd_test <- wbcd_n[470:569, ]

wbcd_train_labels <- wbcd[1:469, 1]

wbcd_test_labels <- wbcd[470:569, 1]

#Train The model

install.packages("class")

library(class)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,cl = wbcd_train_labels, k =
                        
                        21)

#evaluating model performance

install.packages("gmodels")

library(gmodels)

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,prop.chisq=FALSE)

#improving model performance - Test with different k values