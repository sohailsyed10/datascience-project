concrete <- read.csv(file.choose())

str(concrete)

#normalize data

normalize <- function(x) {return((x - min(x)) / (max(x) - min(x)))}

concrete_norm <- as.data.frame(lapply(concrete, normalize))

summary(concrete_norm)

# Training and Test data sets

concrete_train <- concrete_norm[1:773, ]

concrete_test <- concrete_norm[774:780, ]

#training a model on the data

install.packages("neuralnet")

library(neuralnet)

#train the model

concrete_model <- neuralnet(strength ~ Cement + Slag + Fly_Ash  + Water  + Superplasticizer +
                              
                              Coarse_Aggregate + Fine_Aggregate + Age ,data = concrete_train)

plot(concrete_model)

#evaluating model performance

model_results <- compute(concrete_model, concrete_test[1:8])

predicted_strength <- model_results$net.result

cor(predicted_strength, concrete_test$strength)

#improving model performance

concrete_model2 <- neuralnet(strength ~ cement + slag + ash + water + superplastic +
                               
                               coarseagg + fineagg + age,data = concrete_train , hidden = 5)

plot(concrete_model2)

model_results2 <- compute(concrete_model2, concrete_test[1:8])

predicted_strength2 <- model_results2$net.result

cor(predicted_strength2, concrete_test$strength)