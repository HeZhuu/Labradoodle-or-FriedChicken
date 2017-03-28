#########################################################

### Train RBF SVM model with training images ###

#########################################################
### Author: Jihan Wei



### Train a Support Vector Machine (SVM)using processed features from training images:

### Input: 
###  -  processed features from images 
###  -  class labels for training images
###  -  gamma(parameter-1 for the SVM, with default value 0.008)
###  -  cost(parameter-2 for the SVM,with default value 0.8)


### Output: training model specification

train_svm <- function(Train.x,Train.y,gamma=0.008,cost = 1.2){
  ### load libraries
  library(e1071)
  fit_svm<-svm(Train.x,Train.y,scale=F,kernel="radial",gamma=gamma,cost = cost)
  return(fit_svm)
}