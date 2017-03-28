########################
### Cross Validation for the baseline###
########################



cv.function <- function(df.train, K, par_best){
  n <- nrow(df.train)
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  
  for (i in 2:K){
    train.data <- df.train[s != i,]
    test.data <- df.train[s == i,]
    
    fit <- train_gbm(train.data, par_best)
    pred <- test_gbm(fit, test.data)  
    cv.error[i] <- mean(pred != test.data$labels)  
  }			
  return(c(mean(cv.error),sd(cv.error)))
  
}

cv.function.shr <- function(train, shr, K){
  
  library(gbm)
  
  
  boost.fit <- gbm(labels~., data=train,
                        distribution="bernoulli",
                        n.trees=15000,
                        interaction.depth=1,
                        shrinkage=shr,
                        cv.folds=K)
  cv.error = boost.fit$cv.error
  return(cv.error)
  
}
