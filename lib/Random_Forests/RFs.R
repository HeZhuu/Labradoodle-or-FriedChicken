############################
#######Random Forests#######
############################

## Author: Chenyun Zhu

library(randomForest)
library(ggplot2)

# Import the dataset
setwd("~/Desktop/GR5243/spr2017-proj3-grp1")
sift <- read.csv("./data/sift_features.csv")
sift.label <- read.csv("./data/sift_labels.csv")

# Transpose the sift data
sift.new <- t(sift)

# Randomly split the data into test and training set
# 75% training set and 25% test set
n <- dim(sift.new)[1]
set.seed(618)
index <- sample(n, n*0.75)

x.train <- sift.new[index,]
y.train <- as.vector(sift.label[index,])

x.test <- sift.new[-index,]
y.test <- as.vector(sift.label[-index,])

# Model selection using cross validation
K = 10
m <- length(y.train)
m.fold <- floor(m/K)
set.seed(6)
s <- sample(rep(1:K, c(rep(m.fold, K-1), m-(K-1)*m.fold))) 
cv.error <- rep(NA, K)

for (i in 1:K){
  train.data <- x.train[s != i,]
  train.label <- y.train[s != i]
  test.data <- x.train[s == i,]
  test.label <- y.train[s == i]
  
  # use sqrt(5000) = 70 as ntree
  fit <- tuneRF(train.data, as.factor(train.label), ntree = 70, doBest = TRUE)
  pred <- predict(fit, test.data)
  cv.error[i] <- mean(pred != test.label)
}

# Visualize Cross Validation
ggplot(data = data.frame(cv.error)) + geom_point(aes(x = 1:10, y = cv.error))

# Get the lowest error rate of cross validation
which.min(cv.error)

# Get the 'mtry' for trained model
system.time(fit.1 <- tuneRF(x.train[s != 1,], as.factor(y.train[s != 1]), ntreeTry = 70, doBest = TRUE))

# Training error
train_pred <- predict(fit.1, x.train)
train_error <- mean(train_pred != y.train)

# Test error
test_pred <- predict(fit.1, x.test)
test_error <- mean(test_pred != y.test)

save(fit.1, file="./lib/Random_Forests/output/RFs_fit_train.RData")