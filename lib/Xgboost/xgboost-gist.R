setwd("/Users/zhuuu/Desktop/spr2017-proj3-grp1-master")

y <- read.csv("./data/sift_labels.csv" , as.is = T)


data1 <- read.csv("./lib/Features/GIST/chickf.csv",as.is = T,header = F)
data2 <- read.csv("./lib/Features/GIST/dogf.csv",as.is = T,header = F)

GIST.data<-rbind(data1,data2)
y<-y[1:2000,]

########test on new data##########
y1<-read.csv("./data/new.labels.csv" , as.is = T)
y1<-y1[1:260,]

test.data<-read.csv("./lib/Features/GIST/newfeatures.csv",as.is = T,header = F)
######################



per_train <- 0.75 # percentage of training data
smp_size <- floor(per_train * nrow(GIST.data)) # size of the sample
set.seed(95)
index <- sample(seq_len(nrow(GIST.data)), size = smp_size)



data.train<-GIST.data[index,]
y.train<-y[index]

data.test<-GIST.data[-index,]
y.test<-y[-index]

train.matrix <- data.matrix(data.train,rownames.force = NA)
train.D <- xgb.DMatrix(data=train.matrix,label=y.train,missing = NaN)
watchlist <- list(train.matrix=train.D)

depth.list<- c(5,6,7,8)
eta.list<- seq(0.1,0.2,0.1)


error<-matrix(NA,nrow = length(eta.list),ncol = length(depth.list))
iteration<-matrix(NA,nrow = length(eta.list),ncol = length(depth.list))
train.sd<-matrix(NA,nrow = length(eta.list),ncol = length(depth.list))
test.sd<-matrix(NA,nrow = length(eta.list),ncol = length(depth.list))


for (i in 1:length(depth.list)) {
  for (j in 1:length(eta.list) ) {
  
  parameters <- list ( objective        = "binary:logistic",
                       #booser              = "gbtree",
                       eta                 = eta.list[j],
                       max_depth           = depth.list[i],
                       subsample           = 0.5,
                       gamma = 0
  )
  
  crossvalid <- xgb.cv( params             = parameters,
                        data                = train.D,
                        nrounds             = 500,
                        verbose             = 1,
                        watchlist           = watchlist,
                        maximize            = FALSE,
                        nfold               = 5,
                        early_stopping_rounds    = 10,
                        print_every_n       = 1
  )
  
  iteration[j,i]<-crossvalid$best_iteration
  error[j,i]<- as.numeric(crossvalid$evaluation_log[crossvalid$best_iteration,4])
  train.sd[j,i]<-as.numeric(crossvalid$evaluation_log[crossvalid$best_iteration,3])
  test.sd[j,i]<-as.numeric(crossvalid$evaluation_log[crossvalid$best_iteration,5])
  }
}


best.index<-which(error == min(error), arr.ind = TRUE)
depth.choose<-depth.list[best.index[1,2]]
era.choose<-eta.list[best.index[1,1]]
iteration.choose<-iteration[best.index[1,1],best.index[1,2]]
#cv sd
test.sd.choose<-test.sd[best.index[1,1],best.index[1,2]]
train.sd.choose<-train.sd[best.index[1,1],best.index[1,2]]




plot(eta.list,error[,1],type= "o",col = 1,ylim = c(0,0.3),xlab = "eta",ylab = "error rate",main = "Cross Validation Error")
for (i in 2: length(depth.list)){points(eta.list,error[,i],type = "o",col = i)}
legend("topright", fill = 1:length(depth.list), legend = paste("max_depth=",depth.list),cex = 0.75)




parameters <- list ( objective        = "binary:logistic",
                     #booser              = "gbtree",
                     eta                 = era.choose,
                     max_depth           = depth.choose,
                     subsample           = 0.5,
                     gamma = 0
)

crossvalid <- xgb.cv( params             = parameters,
                      data                = train.D,
                      nrounds             = 500,
                      verbose             = 1,
                      watchlist           = watchlist,
                      maximize            = FALSE,
                      nfold               = 5,
                      early_stopping_rounds    = 8,
                      print_every_n       = 1
)


crossvalid$best_iteration
#best error from cross vaclidation
crossvalid$evaluation_log[crossvalid$best_iteration,4]
crossvalid$evaluation_log[crossvalid$best_iteration,5]


train.model <- xgb.train( params              = parameters,
                          data                = train.D,
                          #nrounds             = 130, 
                          nrounds             = iteration.choose, 
                          verbose             = 1,
                          watchlist           = watchlist,
                          maximize            = FALSE
)


testmodel <- data.matrix(data.test,rownames.force = NA)
result <- predict (train.model,testmodel)
result<-as.numeric(result > 0.5)
mean(y.test!=result)

tm_train <- system.time(md <- xgb.train( params              = parameters,
data                = train.D,
nrounds             = iteration.choose, 
verbose             = 1,
watchlist           = watchlist,
maximize            = FALSE
))



######## test the new data##########
testmodel <- data.matrix(test.data,rownames.force = NA)
result <- predict (train.model,testmodel)
result<-as.numeric(result > 0.5)
mean(y1!=result)

