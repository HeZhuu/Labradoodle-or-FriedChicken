
test_xgboost <- function(fit_train, dat_test){
  
  ### load libraries
  library(xgboost)
  
  testmodel <- data.matrix(dat_test,rownames.force = NA)
  result <- predict (fit_train,testmodel)
  result<-as.numeric(result > 0.5)

  
  return(result)
  
}


test_gbm <- function(fit_train, test){
  
  ### Fit the classfication model with testing data
  
  ### Input: 
  ###  - the fitted classification model using training data
  ###  -  processed features from testing images 
  ### Output: training model specification
  
  ### load libraries
  library("gbm")
  
  pred <- predict(fit_train$fit, newdata=test, 
                  n.trees=fit_train$iter, type="response")
  
  return(as.numeric(pred> 0.5))
}